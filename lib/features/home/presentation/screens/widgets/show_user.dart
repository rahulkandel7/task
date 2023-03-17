import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_day_1/features/home/data/models/user.dart';

import '../../controllers/user_controller.dart';

class ShowUser extends ConsumerStatefulWidget {
  const ShowUser({super.key});

  @override
  ShowUserState createState() => ShowUserState();
}

class ShowUserState extends ConsumerState<ShowUser> {
  bool isSingleUser = false;
  late User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<User> users = ref.watch(userControllerProvider.notifier).state;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSingleUser ? Colors.indigo : Colors.purple.shade50,
                ),
                onPressed: () {
                  ref
                      .read(userControllerProvider.notifier)
                      .loadDataFromSharedPreference()
                      .then((value) {
                    setState(() {
                      isSingleUser = true;
                      user = value;
                    });
                  });
                },
                child: Text(
                  'Load Shared Prefs Data',
                  style: TextStyle(
                      color: isSingleUser ? Colors.white : Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      !isSingleUser ? Colors.indigo : Colors.purple.shade50,
                ),
                onPressed: () {
                  setState(() {
                    isSingleUser = false;
                  });
                },
                child: Text(
                  'Load modal Data',
                  style: TextStyle(
                      color: !isSingleUser ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isSingleUser
              ? ListTile(
                  title: Text('Name: ${user.name}'),
                  subtitle: Text('Address: ${user.address}'),
                  trailing: Text('Age: ${user.age}'),
                )
              : ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text('Name: ${users[i].name}'),
                    subtitle: Text('Address: ${users[i].address}'),
                    trailing: Text('Age: ${users[i].age}'),
                  ),
                  itemCount: users.length,
                ),
        ),
      ],
    );
  }
}
