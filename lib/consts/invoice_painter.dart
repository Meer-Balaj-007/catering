import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InvoicePainter extends CustomPainter {
  final Map orderData;
  final String totalAmount;

  InvoicePainter({required this.orderData, required this.totalAmount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final textStyle = TextStyle(fontSize: 18, color: Colors.black);
    final textPainter = TextPainter(textDirection: TextDirection.rtl);

    double yPosition = 20;

    void drawText(String text, double x, double y, {double fontSize = 18}) {
      textPainter.text = TextSpan(text: text, style: textStyle.copyWith(fontSize: fontSize));
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }

    // Title
    drawText("مشتاق ٹینٹ سروس", size.width / 2 - 60, yPosition, fontSize: 24);
    yPosition += 40;

    drawText("03003307863 - 03027312235", size.width / 2 - 100, yPosition);
    yPosition += 30;

    drawText("سیداں والی کھوئی، نواب پور روڈ، ملتان", size.width / 2 - 120, yPosition);
    yPosition += 40;

    // Line
    canvas.drawLine(Offset(20, yPosition), Offset(size.width - 20, yPosition), paint);
    yPosition += 20;

    // Customer Details
    drawText("تاریخ: ${orderData['day']} - ${orderData['month']} - ${orderData['year']}", 20, yPosition);
    drawText("نمبر: ${orderData['customerNumber']}", size.width - 180, yPosition);
    yPosition += 30;

    drawText("گاہک کا نام: ${orderData['customerName']}", 20, yPosition);
    yPosition += 40;

    // Table Headers
    drawText("روپے", size.width - 50, yPosition, fontSize: 16);
    drawText("ریٹ", size.width - 120, yPosition, fontSize: 16);
    drawText("نام / آئٹم", size.width - 220, yPosition, fontSize: 16);
    drawText("تعداد", size.width - 300, yPosition, fontSize: 16);
    yPosition += 30;

    // Table Data
    for (var item in orderData['items']) {
      drawText(item["itemTotal"].toString(), size.width - 50, yPosition);
      drawText(item["price"].toString(), size.width - 120, yPosition);
      drawText(item["itemName"].toString(), size.width - 220, yPosition);
      drawText(item["quantity"].toString(), size.width - 300, yPosition);
      yPosition += 30;
    }

    yPosition += 40;

    // Total Amount
    drawText("روپے: $totalAmount", size.width - 150, yPosition, fontSize: 20);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
