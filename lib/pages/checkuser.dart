import 'package:flutter/material.dart';
import 'package:todo/auth.dart';
import 'package:todo/utils/routes.dart';

class CheckUserAuth extends StatefulWidget {
  const CheckUserAuth({super.key});

  @override
  State<CheckUserAuth> createState() => _CheckUserAuthState();
}

class _CheckUserAuthState extends State<CheckUserAuth> {
  @override
  void initState() {
    super.initState();
    checkUserAuth().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      } else {
        Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
      }
    });
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
