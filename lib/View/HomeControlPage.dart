
import 'package:bookmyaqua/Controller/LoginController.dart';
import 'package:bookmyaqua/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Home.dart';
import 'LoginPage.dart';


class HomeControlPage extends StatefulWidget {
  @override
  _HomeControlPageState createState() => _HomeControlPageState();
}

class _HomeControlPageState extends State<HomeControlPage> {
  final LoginController controller = Get.put(LoginController());

  // Future<Widget> goto() async {
  //   String token = await User.getToken();
  //   if (token != null) {
  //     try {
  //       bool refresh = await controller.refresh();
  //       if (refresh) {
  //         return HomePage();
  //       }
  //     } catch (e) {
  //       return LoginPage();
  //     }
  //   }
  //   return LoginPage();
  // }

  Widget build(BuildContext context) {
    return FutureBuilder(
        //future: goto(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Please wait its loading...'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.requireData;
          } else {
            return Center(
              child: Text("Oop"),
            );
          }
        });
  }
}
