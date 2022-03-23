import 'package:first_flutter_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      // await context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        // child: Center(
        //   child: Text("Login Page", style: TextStyle(
        //     fontSize: 20,
        //     color: Colors.blue,
        //     fontWeight: FontWeight.bold,
        //     ),
        //     textScaleFactor: 2.0,
        //   ),
        // ),
        color: context.canvasColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/logo.jpg",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome $name",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter username",
                          labelText: "Username",
                        ),
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value != null && value.length < 6) {
                            return "Password length should be atleast 6";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Material(
                  borderRadius: BorderRadius.circular(changeButton ? 60 : 8),
                  color: context.theme.buttonColor,
                  child: InkWell(
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: changeButton ? 60 : 150,
                      height: 60,
                      alignment: Alignment.center,
                      child: changeButton
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                      // decoration: BoxDecoration(
                      //   color: Colors.deepPurple,
                      //   // shape: changeButton ? BoxShape.circle : BoxShape.rectangle,
                      //   borderRadius: BorderRadius.circular(changeButton ? 60 : 8),
                      // ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   child: Text("Login"),
                //   style: TextButton.styleFrom(
                //     minimumSize: Size(150, 40),
                //   ),
                //   onPressed: () {
                //     // print("Hello Imad");
                //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                //   },
                // )
              ],
            ),
          ),
        ));
  }
}
