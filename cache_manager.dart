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
  Future<bool> saveValue(dynamic value, CacheManagerKey onKey) async {
    final box = GetStorage();
    final valueToCache = CacheValue(value: value, lastSaved: DateTime.now());
    await box.write(onKey.toString(), valueToCache.toJson());
    return true;
  }

  CacheValue? getValueFrom(CacheManagerKey key) {
    final box = GetStorage(); 
    final savedValue = box.read(key.toString());
    return savedValue == null ? null : CacheValue.fromJson(savedValue);
  }

  Future<void> removeValueFrom(CacheManagerKey key) async {
    final box = GetStorage();
    await box.remove(key.toString());
  }

  Future<void> removeAllCacheData() async {
    final box = GetStorage();
    await box.erase();
  }

  bool isValid(int time, TimeValid timeValid, DateTime lastTime) {
    switch (timeValid) {
      case TimeValid.inDays:
        return (lastTime.difference(DateTime.now()).inDays > time);
      case TimeValid.inHours:
        return (lastTime.difference(DateTime.now()).inHours > time);
      case TimeValid.inSeconds:
        return (lastTime.difference(DateTime.now()).inSeconds > time);
    }
  }
}

enum TimeValid {
  inDays,
  inHours,
  inSeconds;
}

enum CacheManagerKey {
  userToken,
  userData
}