import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText: ''),
    );
  }
}
