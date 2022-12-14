import 'package:bookmyaqua/Controller/LoginController.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());

  var _emailTextController = TextEditingController(text: "");
  var _passwordTextController = TextEditingController(text: "");
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Obx(() {
              return Form(
                  key: _formKey,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("CQAccount",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32)),
                            SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _emailTextController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person), labelText: "Email"),
                              validator: (value) {
                                return controller.emailValidator(value!);
                              },
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _passwordTextController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (value) {
                                return controller.passwordValidator(value!);
                              },
                            ),
                            SizedBox(height: 32),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: controller.loginProcess.value
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                onPressed: () async {
                                  controller.createAlbum(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
                                      password1: _passwordTextController.text);
                                  // if (_formKey.currentState!.validate()) {
                                  //   String error = await controller.createAlbum(
                                  //       email: _emailTextController.text,
                                  //       password: _passwordTextController.text);
                                  //   if (error != "") {
                                  //     Get.defaultDialog(
                                  //         title: "Oop!", middleText: error);
                                  //   } else {
                                  //     Get.to(HomePage());
                                  //   }
                                  // }
                                },
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ));
            })),
      ),
    );
  }
}
