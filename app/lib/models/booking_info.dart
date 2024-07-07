import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_service.dart';
import '../pages/confirm.dart';
import '../pages/main_menu.dart';
import '../models/user.dart';

class BookingInfo {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String areas;
  final String username;
  final DateTime dateTime;
  final int quantity;
  final double totalPrice;
  final List<Map<String, dynamic>> additionalItems;

  BookingInfo({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.areas,
    required this.username,
    required this.dateTime,
    required this.quantity,
    required this.totalPrice,
    required this.additionalItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'areas': areas,
      'username': username,
      'dateTime': dateTime.toIso8601String(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'additionalItems': jsonEncode(additionalItems),
    };
  }

  static Future<void> createRegistration(
      BookingInfo register, User user, BuildContext context) async {
    final db = await BoothDB.connect();
    print('Connected to database');

    await db.insert(
      'booth_info',
      register.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Inserted registration to database: ${register.toMap()}');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmPage(
          user: user,
          register: register,
        ),
      ),
    );
    print('Navigated to ConfirmPage');
  }

  static Future<List<BookingInfo>> getAllRegistration(String username) async {
    final db = await BoothDB.connect();
    print('Fetching all registrations for username: $username');

    final List<Map<String, dynamic>> result = await db.query(
      'booth_info',
      where: "username = ?",
      whereArgs: [username],
    );
    print('Fetched registrations: $result');

    return List.generate(
      result.length,
      (index) {
        return BookingInfo(
          id: result[index]['id'],
          name: result[index]['name'],
          email: result[index]['email'],
          phone: result[index]['phone'],
          areas: result[index]['areas'],
          username: result[index]['username'],
          dateTime: result[index]['dateTime'] != null
              ? DateTime.parse(result[index]['dateTime'])
              : DateTime.now(),
          quantity: result[index]['quantity'],
          totalPrice: (result[index]['totalPrice'] as num).toDouble(),
          additionalItems: result[index]['additionalItems'] != null &&
                  result[index]['additionalItems'] != 'null'
              ? List<Map<String, dynamic>>.from(
                  jsonDecode(result[index]['additionalItems']))
              : [],
        );
      },
    );
  }

  static Future<void> deleteRegistration(
      int? id, BuildContext context, void Function() refreshFunction) async {
    final db = await BoothDB.connect();

    await db.delete(
      'booth_info',
      where: "id = ?",
      whereArgs: [id],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully deleted registration.')),
    );

    refreshFunction();
  }

  static Future<void> updateRegistration(
      BookingInfo registration, User user, BuildContext context) async {
    final db = await BoothDB.connect();

    await db.update(
      'booth_info',
      registration.toMap(),
      where: "id = ?",
      whereArgs: [registration.id],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully updated registration.')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainMenuPage(user: user, currentPage: 1),
      ),
      (route) => false,
    );
  }

  static Future<List<BookingInfo>> getBoothBooks() async {
    final db = await BoothDB.connect();

    final List<Map<String, dynamic>> maps = await db.query('booth_info');
    print('Fetched all booth books: $maps');

    return List.generate(maps.length, (i) {
      return BookingInfo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        areas: maps[i]['areas'],
        username: maps[i]['username'],
        dateTime: maps[i]['dateTime'] != null
            ? DateTime.parse(maps[i]['dateTime'])
            : DateTime.now(),
        quantity: maps[i]['quantity'],
        totalPrice: (maps[i]['totalPrice'] as num).toDouble(),
        additionalItems: maps[i]['additionalItems'] != null &&
                maps[i]['additionalItems'] != 'null'
            ? List<Map<String, dynamic>>.from(
                jsonDecode(maps[i]['additionalItems']))
            : [],
      );
    });
  }

  static Future<List<BookingInfo>> getUserBoothBooks(String username) async {
    final db = await BoothDB.connect();

    final List<Map<String, dynamic>> maps = await db.query(
      'booth_info',
      where: 'username = ?',
      whereArgs: [username],
    );
    print('Fetched user booth books: $maps');

    return List.generate(maps.length, (i) {
      return BookingInfo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        areas: maps[i]['areas'],
        username: maps[i]['username'],
        dateTime: maps[i]['dateTime'] != null
            ? DateTime.parse(maps[i]['dateTime'])
            : DateTime.now(),
        quantity: maps[i]['quantity'],
        totalPrice: (maps[i]['totalPrice'] as num).toDouble(),
        additionalItems: maps[i]['additionalItems'] != null &&
                maps[i]['additionalItems'] != 'null'
            ? List<Map<String, dynamic>>.from(
                jsonDecode(maps[i]['additionalItems']))
            : [],
      );
    });
  }
}
