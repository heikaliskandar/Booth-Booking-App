import '../pages/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_service.dart';

class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String phone;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
    };
  }

  static Future<void> register(User user, BuildContext context) async {
    final db = await BoothDB.connect();
    final List<Map<String, dynamic>> result = await db.query(
      'login',
      where: 'username = ? OR email = ?',
      whereArgs: [user.username, user.email],
    );

    if (result.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username or Email already exists.')),
      );
    } else {
      await db.insert(
        'login',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered.')),
      );
      Navigator.pop(context);
    }
  }

  static Future<void> login(User user, BuildContext context) async {
    final db = await BoothDB.connect();
    final List<Map<String, dynamic>> result = await db.query(
      'login',
      where: 'username = ? and password = ?',
      whereArgs: [user.username, user.password],
    );

    if (result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful. Hi, ' + user.username + '.')),
      );
      User loggedInUser = User(
        id: result[0]['id'],
        username: result[0]['username'],
        password: result[0]['password'],
        email: result[0]['email'],
        phone: result[0]['phone'].toString(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainMenuPage(user: loggedInUser)),
      );
    }
  }

  static Future<User?> getUserDetails(String username) async {
    final db = await BoothDB.connect();
    final List<Map<String, dynamic>> result = await db.query(
      'login',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return User(
        id: result[0]['id'] as int?,
        username: result[0]['username'],
        password: result[0]['password'],
        email: result[0]['email'],
        phone: result[0]['phone'].toString(),
      );
    }

    return null;
  }

  static Future<User?> getUserDetailsById(String id) async {
    final db = await BoothDB.connect();
    final List<Map<String, dynamic>> result = await db.query(
      'login',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return User(
        id: result[0]['id'] as int?,
        username: result[0]['username'],
        password: result[0]['password'],
        email: result[0]['email'],
        phone: result[0]['phone'].toString(),
      );
    }

    return null;
  }

  static Future<List<User>> getUsers() async {
    final db = await BoothDB.connect();
    final List<Map<String, dynamic>> maps = await db.query('login');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'] as int?,
        username: maps[i]['username'],
        password: maps[i]['password'],
        email: maps[i]['email'],
        phone: maps[i]['phone'].toString(),
      );
    });
  }

  static Future<int> updateUser(User user) async {
    final db = await BoothDB.connect();
    return await db.update(
      'login',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteUser(String userId) async {
    final db = await BoothDB.connect();
    return await db.delete('login', where: 'id = ?', whereArgs: [userId]);
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'],
      password: map['password'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
