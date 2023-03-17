import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_day_1/features/home/data/models/user.dart';

class UserController extends StateNotifier<List<User>> {
  UserController() : super(const []) {
    getUser();
  }

  List<User> users = [];

  getUser() {
    state = users;
  }

  Future<User> loadDataFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUser = jsonDecode(prefs.getString('users')!);
    final userdata = jsonDecode(extractedUser) as Map<String, dynamic>;
    User user = User.fromMap(userdata);
    return user;
  }

  addUser({required User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user);
    prefs.setString('users', userData);

    users.add(user);
    getUser();
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, List<User>>((ref) {
  return UserController();
});
