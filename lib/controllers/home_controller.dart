import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON data

class HomeController extends GetxController {
  var saved_order = [].obs;
  var day = "".obs;
  var month = "".obs;
  var year = "".obs;
  RxBool loading = false.obs;
  // Controllers for each item
  var dateController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var numberController = TextEditingController().obs;

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
    {"name": "شامیانہ", "price": 500},
    {"name": "قناعت", "price": 200},
    {"name": "دری", "price": 300},
    {"name": "ٹب", "price": 400},
    {"name": "ٹب اسٹیل", "price": 350},
    {"name": "جگ", "price": 150},
    {"name": "گلاس (اسٹیل یا شیشہ)", "price": 50},
    {"name": "پلیٹ (اسٹیل/پلاسٹک)", "price": 100},
    {"name": "چینی", "price": 60},
    {"name": "دیگ", "price": 700},
    {"name": "پرات", "price": 80},
    {"name": "پرات چمچ", "price": 30},
    {"name": "چولہے", "price": 500},
    {"name": "ٹینکی اسٹیل", "price": 250},
    {"name": "حمام اسٹیل", "price": 600},
    {"name": "جھالر/چادر سفید", "price": 150},
    {"name": "میز اسٹیج", "price": 800},
    {"name": "میز ڈائننگ", "price": 1000},
    {"name": "قالین", "price": 400},
    {"name": "صوفہ سیٹ", "price": 1500},
    {"name": "اسکرین پردہ", "price": 200},
    {"name": "کینوپی", "price": 350},
    {"name": "کرسی پیراشوٹ", "price": 120},
    {"name": "کرسی کور", "price": 150},
    {"name": "کرسی صدارت", "price": 300},
    {"name": "کڑھائی", "price": 500},
    {"name": "چمچ پلاؤ", "price": 25},
    {"name": "انگیٹھی", "price": 200},
    {"name": "سفینگ ڈش", "price": 350},
    {"name": "ڈونگے (پلاسٹک/اسٹیل)", "price": 100},
    {"name": "ڈش (پلاسٹک/اسٹیل)", "price": 75},
    {"name": "ڈونگے چمچ/ڈش چمچ", "price": 40},
    {"name": "پول کور", "price": 60},
    {"name": "کوپا/چوبہ", "price": 250},
    {"name": "شامیانہ جھالر", "price": 180},
    {"name": "پنڈال گیٹ", "price": 400},
    {"name": "انٹری گیٹ", "price": 450},
    {"name": "ویٹر", "price": 300},
    {"name": "قفیگر/دیگ چمچ", "price": 50},
    {"name": "بانس", "price": 120},
    {"name": "رسے", "price": 80},
    {"name": "قلعی", "price": 100},
    {"name": "لون", "price": 70},
  ].obs;

  var fetched = [].obs;

  // Save the order based on the new items format
  Future<void> saveOrder() async {
    loading.value = true;

    List<Map<String, dynamic>> itemDetails = [];

    // Loop through items to create order details

    if(fetched.isNotEmpty){
      for (var item in fetched) {
        TextEditingController controller = getControllerForItem(item["name"].toString());

        // Convert the quantity input to an integer and calculate the total price
        double quantity = double.tryParse(controller.text) ?? 0.0;
        double total = (quantity * double.parse(item["price"].toString())).toDouble();

        itemDetails.add({
          "itemName": item["name"],
          "quantity": quantity,
          "price": item["price"],
          "itemTotal": total,
        });
      }
    } else {
      for (var item in items) {
        TextEditingController controller = getControllerForItem(item["name"].toString());

        // Convert the quantity input to an integer and calculate the total price
        double quantity = double.tryParse(controller.text) ?? 0.0;
        double total = (quantity * double.parse(item["price"].toString())).toDouble();

        itemDetails.add({
          "itemName": item["name"],
          "quantity": quantity,
          "price": item["price"],
          "itemTotal": total,
        });
      }
    }

    // Get the customer details
    String customerName = nameController.value.text;
    String customerNumber = numberController.value.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Filter out items that have an empty or null 'itemTotal'
    List<Map<String, dynamic>> filteredItems = itemDetails
        .where((item) => item['itemTotal'] != null && item['quantity'] != 0.0)
        .toList();

    // Prepare the order map
    Map<String, dynamic> order = {
      "order_day": "${day.value}",
      "order_month": "${month.value}",
      "order_year": "${year.value}",
      "customerName": customerName,
      "customerNumber": customerNumber,
      "items": filteredItems,
    };

    // Convert the order map to JSON string
    String orderJson = jsonEncode(order);

    // Get existing orders from SharedPreferences
    List<String> existingOrders = prefs.getStringList('orders') ?? [];

    // Add the new order to the list of existing orders
    existingOrders.add(orderJson);

    // Save the updated list of orders
    await prefs.setStringList('orders', existingOrders);

    // Clear all text fields
    clearControllers();

    loading.value = false;
  }

  Future<void> orderPaid(Map data) async {
    try {
      loading.value = true;

      var map = data;
      map["paid_at"] = FieldValue.serverTimestamp();

      // Add order to Firebase Firestore
      await FirebaseFirestore.instance.collection("records").add({
        "paid_order": map,
      });

      // Remove the order from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get the stored orders from SharedPreferences
      List<String> storedOrders = prefs.getStringList('orders') ?? [];

      // Remove the order that matches both the customer name and the exact item names
      storedOrders.removeWhere((order) {
        // Decode the stored order string into a Map
        Map<String, dynamic> orderData = jsonDecode(order); // Decode the string into a Map

        // Check if the customer name and items match
        bool customerMatches = orderData['customerName'] == map['customerName'];
        bool itemsMatch = _areItemsEqual(orderData['items'], map['items']);

        // Return true if both the customer name and items match, so the order gets removed
        return customerMatches && itemsMatch;
      });

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('orders', storedOrders);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      debugPrint("Error posting data to firebase: $e");
    }
  }

// Helper function to compare items of the order
  bool _areItemsEqual(List<dynamic> items1, List<dynamic> items2) {
    // If both lists are of different lengths, they cannot be equal
    if (items1.length != items2.length) return false;

    // Check if each item in the list is the same (itemName, quantity, etc.)
    for (int i = 0; i < items1.length; i++) {
      var item1 = items1[i];
      var item2 = items2[i];

      // Compare item names and quantities (you can add other fields if necessary)
      if (item1['itemName'] != item2['itemName'] || item1['quantity'] != item2['quantity']) {
        return false;
      }
    }

    return true;
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

      debugPrint("fetched items: $fetchedItems");
      // Assign fetched items to the observable list
      items.assignAll(fetchedItems);
      items.value = fetchedItems;
      fetched.value = fetchedItems;
      update();

    } catch (e) {
      debugPrint("Error fetching prices: $e",);
    } finally {
      loading.value = false;
    }
  }


  // Get the controller for the item
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

  // Clear all text controllers
  void clearControllers() {
    shamianaController.value.clear();
    kanaatController.value.clear();
    dariController.value.clear();
    tubController.value.clear();
    tubSteelController.value.clear();
    jugController.value.clear();
    glassController.value.clear();
    plateController.value.clear();
    cheeniController.value.clear();
    deigController.value.clear();
    paratController.value.clear();
    paratChamachController.value.clear();
    choolayController.value.clear();
    tinkiSteelController.value.clear();
    hamamSteelController.value.clear();
    jhalarChadarController.value.clear();
    maizStageController.value.clear();
    maizDiningController.value.clear();
    qaleenController.value.clear();
    sofaSetController.value.clear();
    screenPardaController.value.clear();
    canopyController.value.clear();
    kursiParashootController.value.clear();
    kursiKorController.value.clear();
    kursiSadartiController.value.clear();
    kerhaiController.value.clear();
    chamchayPulaoController.value.clear();
    ingheethiController.value.clear();
    sfeengDishController.value.clear();
    dongayPlasticSteelController.value.clear();
    dishPlasticSteelController.value.clear();
    dongayChamachDishChamachController.value.clear();
    pollKorController.value.clear();
    kopaChobaController.value.clear();
    shamianaJhalarController.value.clear();
    pindalGateController.value.clear();
    entryGateController.value.clear();
    waiterController.value.clear();
    qafgeerDaigChamchaController.value.clear();
    baansController.value.clear();
    raasayController.value.clear();
    qlaayController.value.clear();
    loonController.value.clear();
  }
}
