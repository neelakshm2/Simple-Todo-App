import 'package:flutter/material.dart';
import 'package:todo/auth.dart';
import 'package:todo/utils/routes.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/signup_image.png",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                "Sign Up",
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
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Name", labelText: "Name"),
                    ),
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
                          createUser(
                                  nameController.text,
                                  userNameController.text,
                                  passwordController.text)
                              .then((value) {
                            if (value == "success") {
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.loginRoute);
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
                                          children: <Widget>[
                                            Text(value),
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
                          "Sign Up",
                          style: TextStyle(fontSize: 17.0),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.loginRoute);
                        },
                        child: const Text(
                          "Login",
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
