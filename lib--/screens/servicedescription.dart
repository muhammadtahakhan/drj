import 'dart:convert';

import 'package:drj/screens/about.dart';
import 'package:drj/screens/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drj/screens/subservices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../controllers/dashboardController.dart';
import 'appoinment.dart';
import 'dashboard.dart';

class Servicedescription extends StatefulWidget {
  Servicedescription({Key? key}) : super(key: key);

  @override
  State<Servicedescription> createState() => _ServicedescriptionState();
}

class _ServicedescriptionState extends State<Servicedescription> {
  final dashboardController controller =
      Get.put(dashboardController(), permanent: true);

  final box = GetStorage();

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

  Widget _buildAppoinmentButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            // elevation: 5.0,
            color: Color.fromARGB(255, 88, 12, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              bottomNavigation(3);
            },
            child: Text(
              "Appoinment",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 10),
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
          backgroundColor: Colors.white,
          body: GetBuilder<dashboardController>(
            builder: ((controller) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logos/bg9.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Center(
                            child: Image.network(
                          "https://capitechs.co/drj/storage/${controller.selectedSubCatImg}" ??
                              '',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                        )
                            //  Image.network(
                            //   // 'assets/logos/dr-j-logo.png',
                            //   controller.selectedSubCatImg.toString(),
                            //   height: 150,
                            //   width: 200,
                            // ),
                            ),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Center(
                              child: Text(
                                "${controller?.selecctedTitle}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 124, 20, 20)),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: SingleChildScrollView(
                                        child: Text(
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 2,
                                          color:
                                              Color.fromARGB(255, 124, 20, 20)),
                                      // "With a family background rich in medical professionals, he was almost destined to follow in their footsteps. But before “Dr. J” did his surgical internship at the University of Alabama and received medical training at Phoenix’s Good Samaritan Hospital, before meeting his wife nearly 25 years in medical school, and even before making Florida his home in 1984, a young Dr. J was working with very different media during his youth. /n Dr. J Anti Aging Clinic is a premier medical spa. We offer a wide range of med spa services to help you look and feel your best including; cosmetic injectables, sexual wellness, hair restoration, laser hair removal, exosomes therapy, and many more! Our team will provide you with high-quality care that will leave you feeling refreshed and rejuvenated. We work together with our clients to provide them with a personalized service based on their individual needs. For more information,"
                                      controller.selectedSubCatDescrtip
                                          .toString(),
                                    )))),
                            _buildAppoinmentButton()
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }
}
