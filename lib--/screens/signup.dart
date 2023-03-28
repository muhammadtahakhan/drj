import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String fullname, name, email, password, confirmed;

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Image.asset(
          'assets/logos/dr-j-logo.png',
          height: 150,
          width: 200,
        ),
        Spacer(),
        Text(
          '',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildfullnameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            fullname = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.contacts,
              color: mainColor,
            ),
            labelText: 'Full Name'),
      ),
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: 'Password'),
      ),
    );
  }

  Widget _buildConfirmPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            confirmed = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock_open_sharp,
              color: mainColor,
            ),
            labelText: 'Confirm Password'),
      ),
    );
  }

  signup() async {
    print('${fullname},  ${email}, ${password}, ${confirmed};');
    var url = Uri.parse('https://capitechs.co/drj/api/register');
    var response = await http.post(url, body: {
      'fullname': fullname,
      'name': fullname,
      'email': email,
      'password': password,
      'confirmed': confirmed
    });
    print('statusCode : ${response.statusCode}');
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Get.snackbar(
        "Success",
        "Sign up Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 88, 12, 12),
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      Get.off(LoginPage());
    } else {
      var data = json.decode(response.body);
      print('Response body ===> : ${data}');
      Get.snackbar(
        "Error",
        data['errors'][0].toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 88, 12, 12),
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 27),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            elevation: 5.0,
            color: Color.fromARGB(255, 88, 12, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              signup();
            },
            child: Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                color: Colors.white,letterSpacing: 1.5,fontSize: MediaQuery.of(context).size.height / 50,),
              // style: TextStyle(
              //   color: Colors.white,
              //   fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),

      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       'Sign Up ',
                //       style: TextStyle(
                //           fontSize: MediaQuery.of(context).size.height / 30),
                //     ),
                //   ],
                // ),
                _buildfullnameRow(),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildConfirmPasswordRow(),
                SizedBox(height: 25),
                _buildLoginButton(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(70),
                  bottomRight: const Radius.circular(70),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              Divider(
                color: themeBlueGrey,
                height: 50,
                thickness: 50,
                indent: 50,
                endIndent: 50,
              ),
              _buildContainer(),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey,
                height: 15,
                thickness: 2,
                indent: 50,
                endIndent: 50,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
