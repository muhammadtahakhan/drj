import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../models/login.dart';
import 'dashboard.dart';
import 'signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email = '', password = '';
  final box = GetStorage();

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

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 27),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            // elevation: 5.0,
            color: Color.fromARGB(255, 88, 12, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              if (email.length > 0 && password.length > 0) {
                login();
              }
            },
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 50,
              ),
              // style: TextStyle(
              //   color: Colors.white,
              //   letterSpacing: 1.5,
              //   fontSize: MediaQuery.of(context).size.height / 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _builddonothaveaccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 27),
          width: 6 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            elevation: 5.0,
            color: Color.fromARGB(255, 88, 12, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
            child: Text(
              "Signup Now",
              style: GoogleFonts.poppins(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 50,
              ),
              // style: TextStyle(
              //   color: Colors.white,
              //   letterSpacing: -1,
              //   fontSize: MediaQuery.of(context).size.height / 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            "Don't have an account?",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            // style: TextStyle(
            //   fontWeight: FontWeight.w700,
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 25,
          thickness: 2,
          indent: 5,
          endIndent: 5,
        )
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
            height: MediaQuery.of(context).size.height * 0.4,
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
                //       'Login',
                //       style: TextStyle(
                //           fontSize: MediaQuery.of(context).size.height / 30),
                //     ),
                //   ],
                // ),
                _buildEmailRow(),
                _buildPasswordRow(),
                SizedBox(height: 15),
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

  login() async {
    Loader.show(
      context,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Color.fromARGB(255, 88, 12, 12),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
    var url = Uri.parse('https://capitechs.co/drj/api/login');
    var response =
        await http.post(url, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      Loader.hide();
      Login? body = loginFromJson(response.body);

      // print('Response body Token: ${body?.data?.token}');
      print('Response body User: ${body?.data?.user}');
      box.write('token', body?.data?.token);
      box.write('user', "");
      box.write('user', body?.data?.user);
      // ignore: use_build_context_synchronously
      Get.off(() => Dashboard());
    } else {
      Loader.hide();
      var data = json.decode(response.body);
      // print('Response body ===> : ${data['errors'][0]}');
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _buildLogo(),
                Divider(
                  color: themeBlueGrey,
                  height: MediaQuery.of(context).size.height * 0.11,
                  thickness: 35,
                  indent: 35,
                  endIndent: 35,
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
                SizedBox(
                  height: 10,
                ),
                _buildCreateAccountRow(),
                _builddonothaveaccountButton(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
