// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_service.dart';

class AdminLogin {
  final int? id;
  final String username;
  final String password;

  AdminLogin({
    this.id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  static Future<void> register(AdminLogin admin, BuildContext context) async {
    final db = await BoothDB.connect();

    final List<Map<String, dynamic>> result = await db.query(
      'admin',
      where: 'username = ?',
      whereArgs: [admin.username],
    );

    db.insert(
      'admin',
      admin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> admin(AdminLogin admin, BuildContext context) async {
    final db = await BoothDB.connect();

    final List<Map<String, dynamic>> result = await db.query(
      'admin',
      where: 'username = ? and password = ?',
      whereArgs: [admin.username, admin.password],
    );
  }
}
