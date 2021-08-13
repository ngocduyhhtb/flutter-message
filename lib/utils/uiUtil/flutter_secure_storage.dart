import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SecureStorage {
  final _logger = Logger();
  final secureStorage = FlutterSecureStorage();

  Future writeValue(String key, dynamic value) async {
    var writeData = await secureStorage.write(key: key, value: value);
    _logger.d("Write value success");
    return writeData;
  }

  Future<String> readValue(String key) async {
    var readData;
    await secureStorage.read(key: key).then((value) => readData = value);
    return readData;
  }

  Future deleteValue(String key) async {
    await secureStorage.delete(key: key);
  }
}
