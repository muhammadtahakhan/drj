import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/categories.dart';
import '../models/login.dart';
import '../models/promotions.dart';

class dashboardController extends GetxController {
  User? user;
  final box = GetStorage();
  List<SingleCategory?>? categories = [];
  List<SinglePromotion?>? promotions = [];
  int? selectedCat = 0;
  String? selectedSubCatImg = '';
  String? selecctedTitle = '';

  String? selectedSubCatDescrtip = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    user = box.read('user');
  }

  @override
  void onReady() {
    user = box.read('user');
    print(user?.name.toString());
    fetchCategoruies();
// out: GetX is the best
  }

  updateUser() {
    user = box.read('user');
  }

  fetchCategoruies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    print(requestHeaders);
    var url = Uri.parse('https://capitechs.co/drj/api/get-category');
    var response = await http.get(url, headers: requestHeaders);

    print('statusCode : ${response.statusCode}');
    print('body ===>  : ${response.body}');
    if (response.statusCode == 200) {
      print('Categories : ${response.body}');
      var data = categoryFromJson(response.body);
      categories = data?.data;
      print("SingleCategory : ${categories}");
      update();
    } else {
      print('Res : ${response}');
    }
  }

  fetchPromotions() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var url = Uri.parse('https://capitechs.co/drj/api/get-promotion');
    var response = await http.get(url, headers: requestHeaders);

    print('statusCode : ${response.statusCode}');
    print('body ===>  : ${response.body}');
    if (response.statusCode == 200) {
      print('Promotions : ${response.body}');
      var data = promotionFromJson(response.body);
      promotions = data?.data;
      print("SinglePromotion : ${categories}");
      update();
    } else {
      print('Res : ${response}');
    }
  }

  void increment() {
    update();
  }

  void decrease() {
    update();
  }

  void incrementNew() {
    update();
  }
}
