import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';
import 'package:listview_mahasiswa/helper/snackbar_success.dart';

class CreateMhs extends StatefulWidget {
  CreateMhs({super.key, required this.onUpdate});

  final String apiAddress = Config.apiUrl;

  final VoidCallback onUpdate;

  @override
  State<CreateMhs> createState() => _CreateMhsState();
}

class _CreateMhsState extends State<CreateMhs> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController enrollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Buat Mahasiswa"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
              hintText: 'ex: 00001',
            ),
            controller: nimController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              hintText: 'ex: Ronald',
            ),
            controller: nameController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Sex',
              border: OutlineInputBorder(),
              hintText: 'ex: 0: Laki-laki, 1: Perempuan',
            ),
            controller: sexController,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enroll',
              border: OutlineInputBorder(),
              hintText: 'ex: 2025',
            ),
            controller: enrollController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await createData();
            widget.onUpdate();
            Navigator.of(context).pop();
          },
          child: Text("Konfirmasi"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Batal"),
        ),
      ],
    );
  }

  List mhsData = [];

  Future<void> createData() async {
    String uri = 'http://${widget.apiAddress}/koneksimhs.php';

    try {
      final res = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'nim': nimController.text,
          'name': nameController.text,
          'sex': sexController.text,
          'enroll': enrollController.text,
        },
      );
      if (mounted) {
        showSuccessSnackbar(context, 'Berhasil membuat data mahasiswa');
      }

      if (res.statusCode != 200) {
        throw Exception(res.statusCode);
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
      }
    }
  }
}
