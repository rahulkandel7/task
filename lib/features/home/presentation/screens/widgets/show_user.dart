import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_day_1/features/home/data/models/user.dart';

import '../../controllers/user_controller.dart';

class ShowUser extends ConsumerWidget {
  const ShowUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<User> users = ref.watch(userControllerProvider.notifier).state;
    return ListView.builder(
      itemBuilder: (ctx, i) => ListTile(
        title: Text('Name: ${users[i].name}'),
        subtitle: Text('Address: ${users[i].address}'),
        trailing: Text('Age: ${users[i].age}'),
      ),
      itemCount: users.length,
    );
  }
}
