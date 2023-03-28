import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drj/screens/promotion.dart';
import 'package:drj/screens/servicedescription.dart';
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

class SubServices extends StatefulWidget {
  SubServices({Key? key}) : super(key: key);

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
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

  openDetails() {
    Get.to(Servicedescription());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 3),
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
                  height: MediaQuery.of(context).size.height,
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
                        Padding(
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
                                        // openAppoinment();
                                        controller.selectedSubCatImg =
                                            e?.Image.toString();
                                        controller.selecctedTitle =
                                            e?.title.toString();
                                        controller.selectedSubCatDescrtip =
                                            e?.description;
                                        print("===> Image <====");
                                        // print(e?.imageLink);
                                        print(controller.selectedSubCatImg);
                                        openDetails();
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.5,
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  e?.iconLink.toString() ?? '',
                                                  fit: BoxFit.cover,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                ),
                                                // Badge(
                                                //   badgeColor: Color.fromARGB(
                                                //       255, 105, 11, 24),
                                                //   child: Image.network(
                                                //     e?.iconLink.toString() ??
                                                //         '',
                                                //     fit: BoxFit.cover,
                                                //     height:
                                                //         MediaQuery.of(context)
                                                //                 .size
                                                //                 .height /
                                                //             5.3,
                                                //     width:
                                                //         MediaQuery.of(context)
                                                //                 .size
                                                //                 .width /
                                                //             4,
                                                //   ),
                                                //   badgeContent: Text(
                                                //       "${e?.discount ?? ''}%",
                                                //       style: const TextStyle(
                                                //         fontSize: 12.0,
                                                //         color: Color.fromARGB(
                                                //             255, 255, 255, 255),
                                                //       )),
                                                // ),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Column(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 200,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              22,
                                                      child: AutoSizeText(
                                                          maxLines: 3,
                                                          e?.title.toString() ??
                                                              '0',
                                                          style: TextStyle(
                                                              color:
                                                                  themeBlueGrey,
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: AutoSizeText(
                                                          maxLines: 3,
                                                          "Discount: ${e?.discount ?? ''}%",
                                                          style: TextStyle(
                                                              color:
                                                                  themeBlueGrey,
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    SizedBox(
                                                        width: 200,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                          ],
                                                        )),

                                                    // Container(
                                                    //   alignment:
                                                    //       Alignment.topLeft,
                                                    //   child: Row(
                                                    //     children: [
                                                    // Icon(
                                                    //   Icons.star,
                                                    //   color:
                                                    //       Colors.amberAccent,
                                                    // ),
                                                    //       Icon(Icons.star,
                                                    //           color: Colors
                                                    //               .amberAccent),
                                                    //       Icon(
                                                    //         Icons.star,
                                                    //         color: Colors
                                                    //             .amberAccent,
                                                    //       ),
                                                    //       Icon(
                                                    //         Icons.star,
                                                    //         color: Colors
                                                    //             .amberAccent,
                                                    //       ),
                                                    //       Icon(
                                                    //         Icons.star,
                                                    //         color: Colors
                                                    //             .amberAccent,
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        )
                      ],
                    ),
                  ),
                )),
          )),
    );
  }
}
