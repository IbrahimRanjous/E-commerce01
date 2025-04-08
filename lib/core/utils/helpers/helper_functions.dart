import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    // Normalize the input: convert to uppercase and replace spaces with underscores.
    final normalizedValue = value.toUpperCase().replaceAll(' ', '_');

    // Map of all standard Material colors.
    const Map<String, Color> colorMap = {
      'RED': Colors.red,
      'PINK': Colors.pink,
      'PURPLE': Colors.purple,
      'DEEP_PURPLE': Colors.deepPurple,
      'INDIGO': Colors.indigo,
      'BLUE': Colors.blue,
      'LIGHT_BLUE': Colors.lightBlue,
      'CYAN': Colors.cyan,
      'TEAL': Colors.teal,
      'GREEN': Colors.green,
      'LIGHT_GREEN': Colors.lightGreen,
      'LIME': Colors.lime,
      'YELLOW': Colors.yellow,
      'AMBER': Colors.amber,
      'ORANGE': Colors.orange,
      'DEEP_ORANGE': Colors.deepOrange,
      'BROWN': Colors.brown,
      'GREY': Colors.grey,
      'BLUE_GREY': Colors.blueGrey,
      'BLACK': Colors.black,
      'WHITE': Colors.white,
    };

    return colorMap[normalizedValue];
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
