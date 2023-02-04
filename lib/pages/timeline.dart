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
    // createUser();
    super.initState();
  }

  createUser() async {
    await userRef
        .doc("danikk")
        .set({"Username": "Jeff", "postCount": "0", "isAdmin": false});
  }

  updateUser() {
    userRef
        .doc("danikk")
        .update({"Username": "John", "postCount": "0", "isAdmin": false});
  }

  deleteUser() {
    userRef.doc("danikk").delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText: '', isAppTitle: true),
      body: StreamBuilder(
          stream: userRef.snapshots(),
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
