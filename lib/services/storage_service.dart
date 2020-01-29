import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class StorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String> read(String key) async {
    return await _storage.read(key: key);
  }

  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  static void write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static void delete(String key) async {
    await _storage.delete(key: key);
  }

  static void deleteAll() async {
    await _storage.deleteAll();
  }
}
