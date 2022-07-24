import 'package:flutter/material.dart';
import 'package:naturalgas/Login/login.dart';

class NaturalGas extends StatelessWidget {
  const NaturalGas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
