import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crater/consts/colors.dart';
import 'package:crater/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateController extends GetxController {
  final HomeController homeVM = Get.put(HomeController());
  var loading = false.obs;

  var shamianaController = TextEditingController().obs;
  var kanaatController = TextEditingController().obs;
  var dariController = TextEditingController().obs;
  var tubController = TextEditingController().obs;
  var tubSteelController = TextEditingController().obs;
  var jugController = TextEditingController().obs;
  var glassController = TextEditingController().obs;
  var plateController = TextEditingController().obs;
  var cheeniController = TextEditingController().obs;
  var deigController = TextEditingController().obs;
  var paratController = TextEditingController().obs;
  var paratChamachController = TextEditingController().obs;
  var choolayController = TextEditingController().obs;
  var tinkiSteelController = TextEditingController().obs;
  var hamamSteelController = TextEditingController().obs;
  var jhalarChadarController = TextEditingController().obs;
  var maizStageController = TextEditingController().obs;
  var maizDiningController = TextEditingController().obs;
  var qaleenController = TextEditingController().obs;
  var sofaSetController = TextEditingController().obs;
  var screenPardaController = TextEditingController().obs;
  var canopyController = TextEditingController().obs;
  var kursiParashootController = TextEditingController().obs;
  var kursiKorController = TextEditingController().obs;
  var kursiSadartiController = TextEditingController().obs;
  var kerhaiController = TextEditingController().obs;
  var chamchayPulaoController = TextEditingController().obs;
  var ingheethiController = TextEditingController().obs;
  var sfeengDishController = TextEditingController().obs;
  var dongayPlasticSteelController = TextEditingController().obs;
  var dishPlasticSteelController = TextEditingController().obs;
  var dongayChamachDishChamachController = TextEditingController().obs;
  var pollKorController = TextEditingController().obs;
  var kopaChobaController = TextEditingController().obs;
  var shamianaJhalarController = TextEditingController().obs;
  var pindalGateController = TextEditingController().obs;
  var entryGateController = TextEditingController().obs;
  var waiterController = TextEditingController().obs;
  var qafgeerDaigChamchaController = TextEditingController().obs;
  var baansController = TextEditingController().obs;
  var raasayController = TextEditingController().obs;
  var qlaayController = TextEditingController().obs;
  var loonController = TextEditingController().obs;

  // Updated items list as a list of maps
  var items = [
    {"_id": 1, "name": "شامیانہ", "price": 500},
    {"_id": 2, "name": "قناعت", "price": 200},
    {"_id": 3, "name": "دری", "price": 300},
    {"_id": 4, "name": "ٹب", "price": 400},
    {"_id": 5, "name": "ٹب اسٹیل", "price": 350},
    {"_id": 6, "name": "جگ", "price": 150},
    {"_id": 7, "name": "گلاس (اسٹیل یا شیشہ)", "price": 50},
    {"_id": 8, "name": "پلیٹ (اسٹیل/پلاسٹک)", "price": 100},
    {"_id": 9, "name": "چینی", "price": 60},
    {"_id": 10, "name": "دیگ", "price": 700},
    {"_id": 11, "name": "پرات", "price": 80},
    {"_id": 12, "name": "پرات چمچ", "price": 30},
    {"_id": 13, "name": "چولہے", "price": 500},
    {"_id": 14, "name": "ٹینکی اسٹیل", "price": 250},
    {"_id": 15, "name": "حمام اسٹیل", "price": 600},
    {"_id": 16, "name": "جھالر/چادر سفید", "price": 150},
    {"_id": 17, "name": "میز اسٹیج", "price": 800},
    {"_id": 18, "name": "میز ڈائننگ", "price": 1000},
    {"_id": 19, "name": "قالین", "price": 400},
    {"_id": 20, "name": "صوفہ سیٹ", "price": 1500},
    {"_id": 21, "name": "اسکرین پردہ", "price": 200},
    {"_id": 22, "name": "کینوپی", "price": 350},
    {"_id": 23, "name": "کرسی پیراشوٹ", "price": 120},
    {"_id": 24, "name": "کرسی کور", "price": 150},
    {"_id": 25, "name": "کرسی صدارت", "price": 300},
    {"_id": 26, "name": "کڑھائی", "price": 500},
    {"_id": 27, "name": "چمچ پلاؤ", "price": 25},
    {"_id": 28, "name": "انگیٹھی", "price": 200},
    {"_id": 29, "name": "سفینگ ڈش", "price": 350},
    {"_id": 30, "name": "ڈونگے (پلاسٹک/اسٹیل)", "price": 100},
    {"_id": 31, "name": "ڈش (پلاسٹک/اسٹیل)", "price": 75},
    {"_id": 32, "name": "ڈونگے چمچ/ڈش چمچ", "price": 40},
    {"_id": 33, "name": "پول کور", "price": 60},
    {"_id": 34, "name": "کوپا/چوبہ", "price": 250},
    {"_id": 35, "name": "شامیانہ جھالر", "price": 180},
    {"_id": 36, "name": "پنڈال گیٹ", "price": 400},
    {"_id": 37, "name": "انٹری گیٹ", "price": 450},
    {"_id": 38, "name": "ویٹر", "price": 300},
    {"_id": 39, "name": "قفیگر/دیگ چمچ", "price": 50},
    {"_id": 40, "name": "بانس", "price": 120},
    {"_id": 41, "name": "رسے", "price": 80},
    {"_id": 42, "name": "قلعی", "price": 100},
    {"_id": 43, "name": "لون", "price": 70},
  ].obs;


  void updateItemName(String itemId, String newName) {
    int index = items.indexWhere((item) => item["_id"] == double.parse(itemId).toInt());
      items[index]["name"] = newName;
    debugPrint("${items[index]["name"]}");
  }

  void removeItem(String itemId) {
    items.removeWhere((item) => item["_id"] == double.parse(itemId).toInt());
  }


  Future<void> savePrices() async {
    loading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Collect updated prices from text controllers
      List<Map<String, dynamic>> updatedPrices = items.map((item) {
        String name = item["name"] as String;
        String id = item["_id"] as String;
        TextEditingController controller = getControllerForItem(name);
        int newPrice = int.tryParse(controller.text) ?? (item["price"] as int);

        return {"name": name, "price": newPrice, "_id": id};
      }).toList();

      String jsonString = jsonEncode(updatedPrices);
      await prefs.setString("prices", jsonString);

      // Update the observable list
      items.assignAll(updatedPrices.map((e) => e.cast<String, Object>()));
      homeVM.fetched.value = items;

      // Save to Firebase Firestore
      await firestore.collection("prices").doc("items").set({"items": updatedPrices});

      Get.snackbar("Success", "Prices updated successfully!", colorText: AppColors.primary, backgroundColor: AppColors.secondary);
    } catch (e) {
      Get.snackbar("Error", "Failed to save prices: $e", );
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchPrices() async {
    loading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Try fetching from SharedPreferences first
      String? jsonString = prefs.getString("prices");
      List<Map<String, Object>> fetchedItems = [];

      if (jsonString != null) {
        List<dynamic> savedPrices = jsonDecode(jsonString);
        fetchedItems = savedPrices.map((e) => (e as Map<String, dynamic>).cast<String, Object>()).toList();
      } else {
        // If SharedPreferences is empty, fetch from Firebase
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("prices").doc("items").get();

        if (snapshot.exists && snapshot.data() != null) {
          List<dynamic> firebasePrices = snapshot.data()!["items"];
          fetchedItems = firebasePrices.map((e) => (e as Map<String, dynamic>).cast<String, Object>()).toList();

          // Save to SharedPreferences for faster access next time
          String firebaseJsonString = jsonEncode(firebasePrices);
          await prefs.setString("prices", firebaseJsonString);
        }
      }

      // Assign fetched items to the observable list
      items.assignAll(fetchedItems);

      // **Assign prices to controllers**
      for (var item in fetchedItems) {
        String name = item["name"] as String;
        int price = (item["price"] ?? 0) as int; // Ensure default value to avoid null issues

        // Get the corresponding controller
        TextEditingController controller = getControllerForItem(name);

        // Update the controller with the fetched price
        controller.text = price.toString();
      }

    } catch (e) {
      debugPrint("Error fetching prices: $e",);
    } finally {
      loading.value = false;
    }
  }


  TextEditingController getControllerForItem(String itemName) {
    switch (itemName) {
      case "شامیانہ":
        return shamianaController.value;
      case "قناعت":
        return kanaatController.value;
      case "دری":
        return dariController.value;
      case "ٹب":
        return tubController.value;
      case "ٹب اسٹیل":
        return tubSteelController.value;
      case "جگ":
        return jugController.value;
      case "گلاس (اسٹیل یا شیشہ)":
        return glassController.value;
      case "پلیٹ (اسٹیل/پلاسٹک)":
        return plateController.value;
      case "چینی":
        return cheeniController.value;
      case "دیگ":
        return deigController.value;
      case "پرات":
        return paratController.value;
      case "پرات چمچ":
        return paratChamachController.value;
      case "چولہے":
        return choolayController.value;
      case "ٹینکی اسٹیل":
        return tinkiSteelController.value;
      case "حمام اسٹیل":
        return hamamSteelController.value;
      case "جھالر/چادر سفید":
        return jhalarChadarController.value;
      case "میز اسٹیج":
        return maizStageController.value;
      case "میز ڈائننگ":
        return maizDiningController.value;
      case "قالین":
        return qaleenController.value;
      case "صوفہ سیٹ":
        return sofaSetController.value;
      case "اسکرین پردہ":
        return screenPardaController.value;
      case "کینوپی":
        return canopyController.value;
      case "کرسی پیراشوٹ":
        return kursiParashootController.value;
      case "کرسی کور":
        return kursiKorController.value;
      case "کرسی صدارت":
        return kursiSadartiController.value;
      case "کڑھائی":
        return kerhaiController.value;
      case "چمچ پلاؤ":
        return chamchayPulaoController.value;
      case "انگیٹھی":
        return ingheethiController.value;
      case "سفینگ ڈش":
        return sfeengDishController.value;
      case "ڈونگے (پلاسٹک/اسٹیل)":
        return dongayPlasticSteelController.value;
      case "ڈش (پلاسٹک/اسٹیل)":
        return dishPlasticSteelController.value;
      case "ڈونگے چمچ/ڈش چمچ":
        return dongayChamachDishChamachController.value;
      case "پول کور":
        return pollKorController.value;
      case "کوپا/چوبہ":
        return kopaChobaController.value;
      case "شامیانہ جھالر":
        return shamianaJhalarController.value;
      case "پنڈال گیٹ":
        return pindalGateController.value;
      case "انٹری گیٹ":
        return entryGateController.value;
      case "ویٹر":
        return waiterController.value;
      case "قفیگر/دیگ چمچ":
        return qafgeerDaigChamchaController.value;
      case "بانس":
        return baansController.value;
      case "رسے":
        return raasayController.value;
      case "قلعی":
        return qlaayController.value;
      case "لون":
        return loonController.value;
      default:
        return TextEditingController();
    }
  }

}