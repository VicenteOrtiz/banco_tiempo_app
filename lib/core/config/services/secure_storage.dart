import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  //Own methods

  Future<String?> getUserId() async {
    var userId = await readSecureData("userId");
    return userId ?? null;
  }

  Future<void> setUserId(String userId) async {
    await writeSecureData("userId", userId);
  }

  Future<String?> getToken() async {
    var token = await readSecureData("token");
    if (token != null) {
      return "Bearer ${token}";
    } else {
      return null;
    }
  }

  Future<void> setToken(String token) async {
    await writeSecureData("token", token);
  }

  //Flutter Storage Methods

  Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key);
    return readData;
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  //modificar en caso de necesitar
  /* Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list =
        allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  } */
}
