import 'dart:convert';

import 'package:drj/screens/about.dart';
import 'package:drj/screens/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../controllers/dashboardController.dart';
import 'appoinment.dart';
import 'dashboard.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);
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
      // Get.to(const AppoinmentPage());
      String url =
          'https://api.automatikpro.com/widget/form/gA46unzxdU4Rjy8iB43J';
      launch(url,
          forceWebView: true, enableJavaScript: true, enableDomStorage: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 1),
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
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 124, 20, 20)),
                        ),
                        SizedBox(height: 10,),
                        Column(
                            children: controller.categories!
                                .where((element) =>
                                    element?.discount != null &&
                                    element?.discount != '')
                                .map((e) =>
                                    // Text(e?.discount.toString() ?? '')
                                    Center(
                                      child: Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(
                                                Icons.notifications,
                                                color: mainColor,
                                              ),
                                              title: Text(
                                                'Dr J Clinic offers a ' +
                                                    e!.discount.toString() +
                                                    '% discount on ' +
                                                    e!.title.toString(),
                                                style:
                                                    TextStyle(color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
