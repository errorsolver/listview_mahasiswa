import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';
import 'package:listview_mahasiswa/helper/snackbar_success.dart';
import 'package:listview_mahasiswa/widget/custom_input_text.dart';
import 'package:listview_mahasiswa/widget/input_wrap.dart';

class UpdateMhs extends StatefulWidget {
  UpdateMhs({
    super.key,
    required this.mhsData,
    required this.nim,
    required this.name,
    required this.sex,
    required this.enroll,
    required this.onUpdate,
  });

  final List mhsData;
  final String nim;
  final String name;
  final String sex;
  final String enroll;
  final VoidCallback onUpdate;

  final String apiAddress = Config.apiUrl;

  @override
  State<UpdateMhs> createState() => _UpdateMhsState();
}

class _UpdateMhsState extends State<UpdateMhs> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController enrollController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nimController.text = widget.nim;
    nameController.text = widget.name;
    sexController.text = widget.sex.toString();
    enrollController.text = widget.enroll;

    return AlertDialog(
      title: Text("Perbarui Mahasiswa"),
      content: InputWrap(
        nimController: nimController,
        nameController: nameController,
        sexController: sexController,
        enrollController: enrollController,
        hideNIM: true,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await updateData();
            widget.onUpdate();
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Text("Perbarui"),
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

  Future<void> updateData() async {
    String uri = 'http://${widget.apiAddress}/koneksimhs.php';

    try {
      final res = await http.put(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'nim': nimController.text,
          'name': nameController.text,
          'sex': sexController.text,
          'enroll': enrollController.text,
        },
      );

      if (res.statusCode != 200) {
        throw Exception(res.statusCode);
      }

      if (mounted) {
        showSuccessSnackbar(context, "Berhasil update data mahasiswa");
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
      }
    }
  }
}
