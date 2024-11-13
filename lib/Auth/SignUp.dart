import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqf_lite/Auth/Login.dart';

import '../main.dart';
import '../sqfLite/sqlDB.dart';
import 'CustomTextFormField.dart';
import 'Valid.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  SqlDb sqlDb = SqlDb();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                padding: const EdgeInsets.only(top: 150),
                children: [
                  Form(
                      key: formState,
                      child: Column(
                        children: [
                          const Icon(Icons.assignment_ind_outlined, size: 80),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              valid: (val) {
                                return validInput(val ?? "", 2, 20);
                              },
                              hint: "Username",
                              myController: username),
                          CustomTextFormField(
                              valid: (val) {
                                return validInput(val ?? "", 8, 50);
                              },
                              hint: "Email",
                              myController: email),
                          CustomTextFormField(
                              valid: (val) {
                                return validInput(val ?? "", 4, 20);
                              },
                              hint: "password",
                              myController: password),
                          MaterialButton(
                            onPressed: () async {
                              if (formState.currentState!.validate()) {
                                int response = await sqlDb.insertData('''
                INSERT INTO users(name,email,password)VALUES("${username.text.trim()}","${email.text.trim()}","${password.text.trim()}")
                ''');
                                if (response != 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "Added User Successfully",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.verified_outlined,
                                                color: Colors.white,
                                              )
                                            ],
                                          )));
                                  sharedPref.setString(
                                      "email", email.text.trim());
                                  sharedPref.setString(
                                      "pass", password.text.trim());
                                  sharedPref.setString(
                                      "name", username.text.trim());
                                  Get.offAll(() => Login());
                                }
                              }
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            height: 48,
                            shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text("Sign Up",
                                style: TextStyle(fontSize: 18)),
                          ),
                          TextButton(
                              onPressed: () async {
                                Get.to(() => const Login());
                              },
                              child: const Text("Login->"))
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
