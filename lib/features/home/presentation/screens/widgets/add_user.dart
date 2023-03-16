import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_day_1/features/home/presentation/controllers/user_controller.dart';

import '../../../data/models/user.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  late String name;
  late String age;
  late String address;

  Widget inputBox({
    required Size size,
    required String label,
    required IconData iconName,
    required TextInputType textInputType,
    required FocusNode focusNode,
    required Function handleEditingComplete,
    required Function(String?)? handleSaved,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(
            iconName,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Text Field cannot be null';
          } else {
            return null;
          }
        },
        keyboardType: textInputType,
        onEditingComplete: () => handleEditingComplete,
        onSaved: handleSaved,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameFocusNode.dispose();
    ageFocusNode.dispose();
    addressFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Column(
        children: [
          inputBox(
            size: size,
            label: 'Enter Name',
            iconName: Icons.person,
            textInputType: TextInputType.name,
            focusNode: nameFocusNode,
            handleEditingComplete: () =>
                FocusScope.of(context).requestFocus(ageFocusNode),
            handleSaved: (value) => name = value!,
          ),
          inputBox(
            size: size,
            label: 'Enter Age',
            iconName: Icons.date_range,
            textInputType: TextInputType.number,
            focusNode: ageFocusNode,
            handleEditingComplete: () =>
                FocusScope.of(context).requestFocus(addressFocusNode),
            handleSaved: (value) => age = value!,
          ),
          inputBox(
            size: size,
            label: 'Enter Adddress',
            iconName: Icons.location_city,
            textInputType: TextInputType.text,
            focusNode: addressFocusNode,
            handleEditingComplete: () =>
                FocusScope.of(context).requestFocus(addressFocusNode),
            handleSaved: (value) => address = value!,
          ),
          Consumer(
            builder: (context, ref, child) {
              return FilledButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  formKey.currentState!.save();
                  User user =
                      User(name: name, age: int.parse(age), address: address);
                  ref.read(userControllerProvider.notifier).addUser(user: user);
                  formKey.currentState!.reset();
                },
                child: const Text(
                  'Add Info',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
