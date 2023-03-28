import 'dart:convert';

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
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                selectedItemColor: themeBlueGrey,
                currentIndex: 2,
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
                    // backgroundColor: themeBlueGrey,
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
          // backgroundColor: Colors.grey.shade300,
          body: GetBuilder<dashboardController>(
            builder: ((controller) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logos/bg9.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/logos/Dr J Vertical Image_edited.jpg',
                              height: 215,
                              width: 500,
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                ),
                                child: Text(
                                  "DR. J HAS ALWAYS CONSIDERED HIMSELF AN ARTIST",
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 124, 20, 20),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Color.fromARGB(255, 124, 20, 20)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: Text(
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      "With a family background rich in medical professionals, he was almost destined to follow in their footsteps. But before “Dr. J” did his surgical internship at the University of Alabama and received medical training at Phoenix’s Good Samaritan Hospital, before meeting his wife nearly 25 years in medical school, and even before making Florida his home in 1984, a young Dr. J was working with very different media during his youth. Dr. J Anti Aging Clinic is a premier medical spa. We offer a wide range of med spa services to help you look and feel your best including; cosmetic injectables, sexual wellness, hair restoration, laser hair removal, exosomes therapy, and many more! Our team will provide you with high-quality care that will leave you feeling refreshed and rejuvenated. We work together with our clients to provide them with a personalized service based on their individual needs. For more information.")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          )),
    );
  }
}
