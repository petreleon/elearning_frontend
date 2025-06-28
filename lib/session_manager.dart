import 'package:hive/hive.dart';

class SessionManager {
  static const String _boxName = 'session';
  static const String _currentUserKey = 'currentUser';

  static Future<void> storeCurrentUser(String username) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_currentUserKey, username);
  }

  static Future<String?> getCurrentUser() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_currentUserKey);
  }

  static Future<void> logoutCurrentUser() async {
    var box = await Hive.openBox(_boxName);
    await box.delete(_currentUserKey);
  }
}
