import 'package:get_storage/get_storage.dart';

class CacheValue {
  dynamic value;
  DateTime? lastSaved;
  
  CacheValue({required this.value, this.lastSaved});

  Map<String, dynamic> toJson() => {
    'value': value,
    'lastSaved': lastSaved.toString()
  };

  CacheValue.fromJson(Map<String, dynamic> json) :
    value = json['value'],
    lastSaved = DateTime.parse(json['lastSaved'].toString());
}
mixin CacheManager {
  // Save values locally
  Future<bool> saveValue(dynamic value, CacheManagerKey onKey) async {
    final box = GetStorage();
    final valueToCache = CacheValue(value: value, lastSaved: DateTime.now());
    await box.write(onKey.toString(), valueToCache.toJson());
    return true;
  }

  // Read the value according to a key
  CacheValue? getValueFrom(CacheManagerKey key) {
    final box = GetStorage(); 
    final savedValue = box.read(key.toString());
    return savedValue == null ? null : CacheValue.fromJson(savedValue);
  }

  // Remove the value according to a key
  Future<void> removeValueFrom(CacheManagerKey key) async {
    final box = GetStorage();
    await box.remove(key.toString());
  }

  // Remove all values saved locally
  Future<void> removeAllCacheData() async {
    final box = GetStorage();
    await box.erase();
  }

  // Validate based on expiration time
  bool isValid(ExpirationTime expiration, int time, DateTime lastTime) {
    switch (expiration) {
      case ExpirationTime.inDays:
        return (lastTime.difference(DateTime.now()).inDays > time);
      case ExpirationTime.inHours:
        return (lastTime.difference(DateTime.now()).inHours > time);
      case ExpirationTime.inSeconds:
        return (lastTime.difference(DateTime.now()).inSeconds > time);
    }
  }
}

enum ExpirationTime {
  inDays,
  inHours,
  inSeconds;
}

enum CacheManagerKey {
  userToken,
  userData
}