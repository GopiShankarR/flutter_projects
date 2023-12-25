// ignore_for_file: unrelated_type_equality_checks

import '../utils/db_helper.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserDataModel {
  int? id;
  String? email;
  String? username;
  String? airline;
  bool? isLoggedIn = false;
  String? passwordHash;
  String? salt;

  UserDataModel({
    this.id,
    this.email,
    this.username,
    this.airline,
    this.isLoggedIn,
    this.passwordHash,
    this.salt,
  });

  String hashPassword(String password) {
    const codec = Utf8Codec();
    final passwordBytes = codec.encode(password);

    final hashedBytes = sha256.convert(passwordBytes).bytes;

    return base64.encode(hashedBytes);
  }

  Future<bool?> getLoggedInStatus(String loggedInUsername) async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> result = await DBHelper().query(
      'user_data',
      where: 'username = $username'
    );

    isLoggedIn = result[0]['loggedIn'] ?? result[0]['loggedIn'];
    return isLoggedIn;
  }

  Future<bool> checkUserLoggedIn(String username, String enteredPassword) async {
    final List<Map<String, dynamic>> result = await DBHelper().query(
      'user_data', 
      where: 'username = "$username"'
    );

    if (result.isNotEmpty) {
      final storedEncryptedPassword = result[0]['password_hash'];
      final enteredHashedPassword = hashPassword(enteredPassword);

      return enteredHashedPassword == storedEncryptedPassword;
    } else {
      return false;
    }
  }

  Future<void> dbSave() async {
    int isLoggedInValue = isLoggedIn != null && isLoggedIn == true ? 1 : 0;
    id = await DBHelper().insertData('user_data', {
      'email': email,
      'username': username,
      'password_hash': passwordHash,
      'airline': airline,
      'isLoggedIn': isLoggedInValue,
    });
  }

  Future<void> dbUpdate() async {
    await DBHelper().updateData('user_data', {
      'username': username,
    }, id!);
  }

}