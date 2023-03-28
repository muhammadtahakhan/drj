import 'dart:convert';

import 'package:drj/screens/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:badges/badges.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../controllers/dashboardController.dart';
import 'about.dart';
import 'appoinment.dart';
import 'dashboard.dart';

class SubServiceDetails extends StatelessWidget {
  SubServiceDetails({Key? key}) : super(key: key);
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

  openAppoinment() {
    String url =
        'https://api.automatikpro.com/widget/form/gA46unzxdU4Rjy8iB43J';
    launch(url,
        forceWebView: true, enableJavaScript: true, enableDomStorage: true);
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
          backgroundColor: Colors.grey.shade300,
          body: GetBuilder<dashboardController>(
            builder: ((controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 8, right: 8),
                        child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: controller.categories!
                                .where((e) =>
                                    e?.parentId == controller.selectedCat)
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      // Get.to(const AppoinmentPage());
                                      openAppoinment();
                                    },
                                    child: SizedBox(
                                      width: 120.0,
                                      height: 120.0,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 8.0),
                                              Container(
                                                child: Text(
                                                    e?.title.toString() ?? '0',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 92, 9, 9),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30.0)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
