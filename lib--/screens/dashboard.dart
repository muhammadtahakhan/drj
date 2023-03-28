import 'dart:convert';

import 'package:drj/constants.dart';
import 'package:drj/controllers/dashboardController.dart';
import 'package:drj/screens/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drj/screens/subservices.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about.dart';
import 'appoinment.dart';
import 'notification.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

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

  sowNotification() {
    Get.to(Notifications());
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
          // backgroundColor: Colors.grey.shade300,
          body: GetBuilder<dashboardController>(
            builder: ((controller) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logos/bg9.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: RefreshIndicator(
                    color: themeBlueGrey,
                    onRefresh: () async {
                      return controller.fetchCategoruies();
                      print(" Refresh ");
                    },
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: themeBlueGrey,
                                    ),
                                    Text(
                                      "Hello ${controller.user?.name.toString()}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          color: themeBlueGrey,
                                          fontWeight: FontWeight.bold),
                                      // style: TextStyle(
                                      //     color: themeBlueGrey,
                                      //     fontSize: 18.0,
                                      //     fontWeight: FontWeight.bold),
                                      // textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => {sowNotification()},
                                  child: const Icon(
                                    size: 35,
                                    Icons.notifications,
                                    color: themeBlueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Find Your Medical Solution!",
                              style: GoogleFonts.poppins(
                                  fontSize: 30.0,
                                  color: themeBlueGrey,
                                  fontWeight: FontWeight.bold),
                              // style: TextStyle(
                              //     color: themeBlueGrey,
                              //     fontSize: 30.0,
                              //     fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset("assets/logos/banner1.jpeg"),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              "What do you need?",
                              style: GoogleFonts.poppins(
                                  fontSize: 23.0,
                                  color: themeBlueGrey,
                                  fontWeight: FontWeight.bold),
                              // style: TextStyle(
                              //     color: themeBlueGrey,
                              //     fontSize: 23.0,
                              //     fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.start,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: controller.categories!
                                        .where((e) => e?.parentId == 0)
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              controller.selectedCat = e?.id;
                                              Get.to(SubServices());
                                            },
                                            child: SizedBox(
                                              width: 120.0,
                                              height: 120.0,
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 17.0),
                                                        Image.network(
                                                          e?.iconLink
                                                                  .toString() ??
                                                              '',
                                                          fit: BoxFit.cover,
                                                          // width: 45,
                                                          height: 50,
                                                        ),
                                                        const SizedBox(
                                                            height: 8.0),
                                                        Text(
                                                            e?.title.toString() ??
                                                                '',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .brown,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    10.0)),
                                                        const SizedBox(
                                                            height: 5.0),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                )),
          )),
    );
  }
}
