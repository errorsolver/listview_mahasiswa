import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';

class DetailMhs extends StatefulWidget {
  DetailMhs({super.key, required this.nim});

  final String nim;

  final String apiAddress = Config.apiUrl;

  @override
  State<DetailMhs> createState() => _DetailMhsState();
}

class _DetailMhsState extends State<DetailMhs> {
  Map<String, dynamic> mhsData = {};

  Future<void> detailData(String nim) async {
    String uri = 'http://${widget.apiAddress}/koneksimhs.php?nim=$nim';

    try {
      final res = await http.get(Uri.parse(uri));

      if (res.statusCode != 200) {
        throw Exception(res.statusCode);
      }

      final data = jsonDecode(res.body);
      setState(() {
        mhsData = data;
      });
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
      }
    }
  }

  @override
  void initState() {
    detailData(widget.nim);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String sex = mhsData['sex'] ?? 'Kelamin Mahasiswa Tidak Ditemukan';

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Mahasiswa")),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              mhsData['name'] ?? 'Nama Mahasiswa Tidak Ditemukan',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'NIM: ${mhsData['nim'] ?? 'NIM Tidak Ditemukan'}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Sex: ${sex == '0' ? 'Laki-laki' : 'Perempuan'}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Enroll: ${mhsData['enroll'] ?? 'Enroll Mahasiswa Tidak Ditemukan'}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
