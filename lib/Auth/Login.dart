import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqf_lite/Auth/SignUp.dart';
import 'package:sqf_lite/Notes/HomePage.dart';
import 'package:sqf_lite/main.dart';
import '../sqfLite/sqlDB.dart';
import 'CustomTextFormField.dart';
import 'Valid.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool isLoading = false;
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                padding: EdgeInsets.only(top: 150),
                children: [
                  Form(
                      key: formState,
                      child: Column(
                        children: [
                          const Icon(Icons.login, size: 80),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              valid: (val) {
                                return validInput(val ?? "", 8, 50);
                              },
                              hint: "Email",
                              myController: emailController),
                          CustomTextFormField(
                              valid: (val) {
                                return validInput(val ?? "", 4, 20);
                              },
                              hint: "password",
                              myController: passwordController),
                          MaterialButton(
                            onPressed: () async {
                              if (formState.currentState!.validate()) {
                                var response = await sqlDb.readData(
                                    'SELECT * FROM users WHERE email = "${emailController.text.trim()}" AND password = "${passwordController.text.trim()}"');
                                print("-----------=");
                                print(response.toString());
                                if (response.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "User Not Found",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.verified_outlined,
                                                color: Colors.white,
                                              )
                                            ],
                                          )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "Login Successfully",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.verified_outlined,
                                                color: Colors.white,
                                              )
                                            ],
                                          )));
                                  sharedPref.setString("login", "done");

                                  Get.offAll(() => NotePage());
                                }
                              }
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            height: 44,
                            shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text("Login",
                                style: TextStyle(fontSize: 18)),
                          ),
                          TextButton(
                              onPressed: () async {
                                Get.to(() => const SignUp());
                              },
                              child: const Text("Sign up->"))
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
