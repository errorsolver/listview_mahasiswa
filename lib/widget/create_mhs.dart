import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';
import 'package:listview_mahasiswa/helper/snackbar_success.dart';
import 'package:listview_mahasiswa/widget/custom_input_text.dart';
import 'package:listview_mahasiswa/widget/input_wrap.dart';

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
      content: InputWrap(
        nimController: nimController,
        nameController: nameController,
        sexController: sexController,
        enrollController: enrollController,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await createData();
            setState(() {
              widget.onUpdate();
              Navigator.of(context).pop();
            });
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
