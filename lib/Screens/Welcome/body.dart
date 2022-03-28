import 'package:flutter/material.dart';
import 'package:redditech/Components/rounded_button.dart';
import 'package:redditech/constants.dart';

class Body extends StatelessWidget {

  Future<void> _tryLogin(BuildContext context) async {
    if (await redditAuth.firstLogin()) {
      Navigator.of(context).pushReplacementNamed('/second');
    }
  }

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size screen
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/Logo_simple.png",
            height: size.height * 0.3,
          ),
          Text (
            "A PROJECT EPITECH",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          RoundedButton (
            text: "LOGIN WITH REDDIT",
            press: () => _tryLogin(context),
            textColor: PrimaryLightColor,
            color: PrimaryColor,
          ),
          const SizedBox(height: 100),
          Image.asset(
            "assets/images/Logo_plice.png",
            height: size.height * 0.2,
            width: size.width * 0.6,
            ),
        ],
      ),
    );
  }
} 