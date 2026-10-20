
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class AuthRepository {
  final Box users = Hive.box('users');

  Future<void> register(String email, String password) async {
    // Same email again replaces the previously saved password.
    await users.put(email.trim().toLowerCase(), password);
  }

  bool login(String email, String password) {
    return users.get(email.trim().toLowerCase()) == password;
  }
}
