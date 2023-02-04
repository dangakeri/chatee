import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/header.dart';
import '../widgets/progress.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];
  @override
  void initState() {
    // getUserById();
    getUsers();
    super.initState();
  }

  getUsers() async {
    final QuerySnapshot snapshot = await userRef.get();
    setState(() {
      users = snapshot.docs;
    });
    // userRef.get().then((snapshot) {
    // snapshot.docs.forEach((DocumentSnapshot doc) {
    //   print(doc.data);
    //   print(doc.id);
    //   print(doc.exists);
    // });
  }
  // getUserById() async {
  //   final String id = "X3hX5eRD9qhI7GeaiV2V";
  //   final DocumentSnapshot doc = await userRef.doc(id).get();
  //   print(doc.data);
  //   print(doc.id);
  //   print(doc.exists);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText: '', isAppTitle: true),
      body: FutureBuilder(
          future: userRef.get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final List<Text> children = snapshot.data!.docs
                .map((doc) => Text(doc['username']))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          }),
    );
  }
}
