import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/header.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    getUserById();
    // getUsers();
    super.initState();
  }

  // getUsers() {
  //   userRef.get().then((snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.data);
  //     });
  //   });
  // }
  getUserById() async {
    final String id = "X3hX5eRD9qhI7GeaiV2V";
    final DocumentSnapshot doc = await userRef.doc(id).get();
    print(doc.data);
    print(doc.id);
    print(doc.exists);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText: ''),
    );
  }
}
