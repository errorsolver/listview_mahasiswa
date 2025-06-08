import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiUrl {
    if (dotenv.isInitialized) {
      print('dotenv.isInitialized: ${dotenv.isInitialized}');
      print('API_BASE_URL: ${dotenv.env['API_BASE_URL']}');
    } else {
      print('dotenv belum diinisialisasi!');
    }

    return dotenv.env['API_BASE_URL'] ?? 'localhost:3000';
  }
}
