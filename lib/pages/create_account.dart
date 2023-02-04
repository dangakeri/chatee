import 'package:flutter/material.dart';

import '../widgets/header.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formkey = GlobalKey<FormState>();
  late String username;
  submit() {
    _formkey.currentState!.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText: 'Setup your profile'),
      body: ListView(
        children: [
          Column(
            children: [
              const Center(
                child: Text('Create a Username'),
              ),
              Form(
                key: _formkey,
                child: TextFormField(
                  onSaved: (value) => username,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 15),
                    hintText: 'Must be atleast 3 characters',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: submit,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  child: const Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
