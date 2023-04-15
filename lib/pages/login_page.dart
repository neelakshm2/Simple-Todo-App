import 'package:flutter/material.dart';
import 'package:todo/auth.dart';
import 'package:todo/utils/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          hintText: "Enter Username", labelText: "Username"),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Enter Password", labelText: "Password"),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          loginUser(userNameController.text,
                                  passwordController.text)
                              .then((value) {
                            if (value == "logged") {
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.homeRoute);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'ERROR',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Invalid Username Password'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                            minimumSize: const Size(150, 40)),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 17.0),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.signUpRoute);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 17.0,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
