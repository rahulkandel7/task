import 'package:flutter/material.dart';
import 'package:task_day_1/features/home/presentation/screens/widgets/add_user.dart';
import 'package:task_day_1/features/home/presentation/screens/widgets/show_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Task',
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person_2_outlined),
                child: Text('Show Users'),
              ),
              Tab(
                icon: Icon(Icons.person_add_alt),
                child: Text('Add User'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ShowUser(),
            AddUser(),
          ],
        ),
      ),
    );
  }
}
