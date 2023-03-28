import 'dart:convert';

import 'package:drj/screens/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../controllers/dashboardController.dart';
import 'about.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({Key? key}) : super(key: key);

  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage> {
  final box = GetStorage();
  final dashboardController controller =
      Get.put(dashboardController(), permanent: true);
  late String email, first_name, last_name, phone_number;
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

  submitAppoinment() async {
    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };

    print(' ===> ${email}, ${first_name}, ${last_name}, ${phone_number}');
    var url = Uri.parse('https://capitechs.co/drj/api/create-appointment');
    var response = await http.post(url, headers: requestHeaders, body: {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number
    });
    print('statusCode : ${response.statusCode}');
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Get.off(Dashboard());
    } else {
      print('Response body ===> : ${response.body}');
      // var data = json.decode(response.body);
      // print('Response body ===> : ${data}');
      // Get.snackbar(
      //   "Error",
      //   data['errors'][0].toString(),
      //   snackPosition: SnackPosition.BOTTOM,
      //   // backgroundColor: Color.fromARGB(255, 253, 80, 0),
      //   borderRadius: 20,
      //   margin: EdgeInsets.all(15),
      //   colorText: Colors.white,
      //   duration: Duration(seconds: 4),
      //   isDismissible: true,
      //   dismissDirection: DismissDirection.horizontal,
      //   forwardAnimationCurve: Curves.easeOutBack,
      // );
    }
  }

  Widget _buildfullnameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            first_name = value;
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

  Widget _buildlastnameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            last_name = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.drive_file_rename_outline,
              color: mainColor,
            ),
            labelText: 'Last Name'),
      ),
    );
  }

  Widget _buildphonenumberRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          setState(() {
            phone_number = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: mainColor,
            ),
            labelText: 'Phone Number'),
      ),
    );
  }

  Widget _buildemailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        // obscureText: true,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: 'Email Address'),
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
            color: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              submitAppoinment();
            },
            child: Text(
              "Submit",
    style: GoogleFonts.poppins(
    color: Colors.white,letterSpacing: 1.5,fontSize: MediaQuery.of(context).size.height / 50,),
              // style: TextStyle(
              //   backgroundColor: mainColor,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Schedule Appointment ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 40),
                    ),
                  ],
                ),
                _buildfullnameRow(),
                _buildlastnameRow(),
                _buildphonenumberRow(),
                _buildemailRow(),
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

  bottomNavigation(val) {
    print(val);
    if (val == 0) {
      Get.to(Dashboard());
    }
    if (val == 1) {
      Get.to(Promotion());
    }
    if (val == 2) {
      Get.to(About());
    }
    if (val == 3) {
      Get.to(const AppoinmentPage());
      // String url =
      //     'https://api.automatikpro.com/widget/form/gA46unzxdU4Rjy8iB43J';
      // launch(url,
      //     forceWebView: true, enableJavaScript: true, enableDomStorage: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              selectedItemColor: themeBlueGrey,
              currentIndex: 0,
              onTap: ((value) => bottomNavigation(value)),
              type: BottomNavigationBarType.fixed,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: themeBlueGrey,
                  ),
                  label: 'Home',
                  backgroundColor: themeBlueGrey,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_offer_outlined,
                    color: themeBlueGrey,
                  ),
                  label: 'Promotion',
                  backgroundColor: themeBlueGrey,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.comment,
                    color: themeBlueGrey,
                  ),
                  label: 'About',
                  backgroundColor: themeBlueGrey,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apartment,
                    color: themeBlueGrey,
                  ),
                  label: 'Appoinment',
                  backgroundColor: themeBlueGrey,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xfff2f3f7),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/logos/bg9.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                Divider(
                  color: themeBlueGrey,
                  height: 45,
                  thickness: 45,
                  indent: 45,
                  endIndent: 45,
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
      ),
    );
  }
}