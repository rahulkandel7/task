import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_day_1/features/home/data/models/user.dart';

class UserController extends StateNotifier<List<User>> {
  UserController() : super(const []) {
    getUser();
  }

  List<User> users = [];

  getUser() {
    state = users;
  }

  addUser({required User user}) {
    users.add(user);
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, List<User>>((ref) {
  return UserController();
});
