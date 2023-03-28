import 'dart:convert';

import 'package:drj/screens/about.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:drj/screens/subservices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../controllers/dashboardController.dart';
import 'appoinment.dart';
import 'dashboard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Promotion extends StatefulWidget {
  Promotion({Key? key}) : super(key: key);

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final dashboardController controller =
      Get.put(dashboardController(), permanent: true);

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
// TODO: implement initState
    controller.fetchPromotions();
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

  Widget _buildPromotion(String title, String description, String imgUrl) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context, builder: (_) => ImageDialog(imgUrl));
            },
            child: Center(
              child: Image.network(
                imgUrl,
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 124, 20, 20),
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0),
                  // style: TextStyle(
                  //     color: themeBlueGrey,
                  //     fontSize: 23.0,
                  //     fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: SingleChildScrollView(
                            child: Text(
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  height: 2,
                                ),
                                // style: TextStyle(
                                //     fontSize: 16,
                                //     height: 2,
                                //     color: Colors.black),
                                description)))),
              ],
            ),
          ),
        ],
      ),
    );
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
                currentIndex: 1,
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
            builder: ((controller) => GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/logos/bg9.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: CarouselSlider(
                        items: controller.promotions!
                            .map((p) => _buildPromotion(p!.title.toString(),
                                p.description, p.imageLink))
                            .toList(),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ),
                  ),
                )),
          )),
    );
  }
}

class ImageDialog extends StatelessWidget {
  ImageDialog(this.imgUrl);

  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
          child: Image.network(
            fit: BoxFit.fill,
            imgUrl,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
