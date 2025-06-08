import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/tampil_mahasiswa.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  runApp(MainApp());
}

Future<void> loadEnv() async {
  try {
    print('meng-inisialisasi');
    await dotenv.load(fileName: ".env");
    print('ter-inisialisasi');
  } catch (e) {
    print('gagal inisialisasi');
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final String APIaddress = Config.apiUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),

      home: TampilDataMhs(),
    );
  }
}
