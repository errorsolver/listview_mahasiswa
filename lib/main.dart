import 'package:flutter/material.dart';
import 'package:listview_mahasiswa/config/config.dart';
import 'package:listview_mahasiswa/pages/tampil_mahasiswa.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.loadEnv();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
