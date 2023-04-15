import 'package:flutter/material.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/utils/routes.dart';
import 'pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/checkuser.dart';
import 'package:provider/provider.dart';
import 'pages/add_new_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoProvider()),
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: GoogleFonts.lato().fontFamily),
        initialRoute: '/checkuser',
        routes: {
          MyRoutes.checkUserRoute: (context) => CheckUserAuth(),
          MyRoutes.homeRoute: (context) => HomePage(),
          MyRoutes.loginRoute: (context) => LoginPage(),
          MyRoutes.signUpRoute: (context) => SignUpPage(),
          MyRoutes.NewTodo: (context) => NewTodo()
        },
      ),
    );
  }
}
