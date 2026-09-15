abstract class ILocalStorageAdapter {
  Future<String?> readString({required String key});

  Future<void> writeString({required String key, required String value});

  Future<bool?> readBool({required String key});

  Future<void> writeBool({required String key, required bool value});

  Future<int?> readInt({required String key});

  Future<void> writeInt({required String key, required int value});

  Future<double?> readDouble({required String key});

  Future<void> writeDouble({required String key, required double value});

  Future<List<String>?> readStringList({required String key});

  Future<void> writeStringList({required String key, required List<String> value});

  Future<void> delete({required String key});

  Future<void> clear();
}
