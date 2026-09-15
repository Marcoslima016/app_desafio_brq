import 'package:app_desafio_brq/lib.exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements ILocalStorageAdapter {
  SharedPreferencesStorage([Future<SharedPreferences>? instance])
      : _instance = instance ?? SharedPreferences.getInstance();

  final Future<SharedPreferences> _instance;

  @override
  Future<String?> readString({required String key}) async => (await _instance).getString(key);

  @override
  Future<void> writeString({required String key, required String value}) async =>
      (await _instance).setString(key, value);

  @override
  Future<bool?> readBool({required String key}) async => (await _instance).getBool(key);

  @override
  Future<void> writeBool({required String key, required bool value}) async =>
      (await _instance).setBool(key, value);

  @override
  Future<int?> readInt({required String key}) async => (await _instance).getInt(key);

  @override
  Future<void> writeInt({required String key, required int value}) async => (await _instance).setInt(key, value);

  @override
  Future<double?> readDouble({required String key}) async => (await _instance).getDouble(key);

  @override
  Future<void> writeDouble({required String key, required double value}) async =>
      (await _instance).setDouble(key, value);

  @override
  Future<List<String>?> readStringList({required String key}) async => (await _instance).getStringList(key);

  @override
  Future<void> writeStringList({required String key, required List<String> value}) async =>
      (await _instance).setStringList(key, value);

  @override
  Future<void> delete({required String key}) async => (await _instance).remove(key);

  @override
  Future<void> clear() async => (await _instance).clear();
}
