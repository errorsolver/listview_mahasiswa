import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';
import 'package:listview_mahasiswa/helper/snackbar_success.dart';
import 'package:listview_mahasiswa/widget/input_wrap.dart';

class DeleteMhs extends StatefulWidget {
  DeleteMhs({
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
  final int sex;
  final int enroll;
  final VoidCallback onUpdate;

  final String apiAddress = Config.apiUrl;

  @override
  State<DeleteMhs> createState() => _DeleteMhsState();
}

class _DeleteMhsState extends State<DeleteMhs> {
  Future<void> deleteData(String nim) async {
    String uri = 'http://${widget.apiAddress}/koneksimhs.php?nim=$nim';

    try {
      final res = await http.delete(Uri.parse(uri));
      if (res.statusCode != 200) {
        throw Exception(res.statusCode);
      }
      if (mounted) {
        showSuccessSnackbar(context, 'Berhasil menghapus data mahasiswa');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String sexConvert = widget.sex == 0 ? 'Laki-laki' : 'Perempuan';
    String enrollConvert = (widget.enroll).toString();

    return AlertDialog(
      title: Text("Hapus Mahasiswa"),
      content: InputWrap.readOnly(
        nimText: widget.nim,
        nameText: widget.name,
        sexText: sexConvert,
        enrollText: enrollConvert,
      ),
      //  Text(
      //   'Konfirmasi penghapusan data\nNIM: ${widget.nim}\nNama: ${widget.name}\nSex: $sexConvert\nEnroll: $enrollConvert',
      // ),
      actions: [
        TextButton(
          onPressed: () async {
            await deleteData(widget.nim);
            widget.onUpdate();
            setState(() {
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
}
