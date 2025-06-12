import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/helper/snackbar_error.dart';
import 'package:listview_mahasiswa/widget/create_mhs.dart';
import 'package:listview_mahasiswa/widget/delete_mhs.dart';
import 'package:listview_mahasiswa/pages/detail_mhs.dart';
import 'package:listview_mahasiswa/widget/update_mhs.dart';

class TampilDataMhs extends StatefulWidget {
  const TampilDataMhs({super.key, required});

  @override
  State<TampilDataMhs> createState() => _TampilDataMhsState();
}

class _TampilDataMhsState extends State<TampilDataMhs> {
  List mhsData = [];
  final String apiAddress = Config.apiUrl;

  Future<void> bacaData() async {
    String uri = 'http://$apiAddress/koneksimhs.php';

    bool getData = false;

    while (!getData) {
      try {
        final res = await http.get(Uri.parse(uri));
        if (res.statusCode != 200) {
          throw Exception(res.statusCode);
        }
        final data = jsonDecode(res.body);
        setState(() {
          mhsData = data;
        });
        getData = true;
      } catch (e) {
        setState(() {
          mhsData = [];
        });
        if (mounted) {
          showErrorSnackbar(context, e.toString());
        }
        getData = false;
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  void initState() {
    bacaData();
    super.initState();
  }

  void _showCreatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateMhs(onUpdate: bacaData),
    );
  }

  void _showUpdatePopup(
    BuildContext context,
    String nim,
    String name,
    String sex,
    String enroll,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => UpdateMhs(
            mhsData: mhsData,
            nim: nim,
            name: name,
            sex: sex,
            enroll: enroll,
            onUpdate: bacaData,
          ),
    );
  }

  void _showDeletePopup(
    BuildContext context,
    String nim,
    String name,
    String sex,
    String enroll,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => DeleteMhs(
            mhsData: mhsData,
            nim: nim,
            name: name,
            sex: int.parse(sex),
            enroll: int.parse(enroll),
            onUpdate: bacaData,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listview Data Mahasiswa')),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showCreatePopup(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text('Buat Mahasiswa'),
              ),
              SizedBox(width: 10),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mhsData.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(mhsData[index]['nim']),
                        subtitle: Text(mhsData[index]['name']),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DetailMhs(nim: mhsData[index]['nim']),
                          ),
                        );
                      },
                      child: Text('Detail'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showUpdatePopup(
                          context,
                          mhsData[index]['nim'],
                          mhsData[index]['name'],
                          mhsData[index]['sex'],
                          mhsData[index]['enroll'],
                        );
                      },
                      child: Text('Perbarui'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showDeletePopup(
                          context,
                          mhsData[index]['nim'],
                          mhsData[index]['name'],
                          mhsData[index]['sex'],
                          mhsData[index]['enroll'],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Hapus'),
                    ),
                    SizedBox(width: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
