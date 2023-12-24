import '../utils/db_helper.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
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

  Uint8List generateSalt() {
    final random = Random.secure();
    final salt = List<int>.generate(32, (_) => random.nextInt(256));
    return Uint8List.fromList(salt);
  }

  void hashPassword(String password) {
    final saltBytes = generateSalt();
    salt = base64.encode(saltBytes);

    final codec = Utf8Codec();
    final passwordBytes = codec.encode(password);

    final combinedBytes = Uint8List.fromList([...passwordBytes, ...saltBytes]);

    final hashedBytes = sha256.convert(combinedBytes).bytes;

    passwordHash = base64.encode(hashedBytes);
  }

  bool verifyEnteredPassword(String enteredPassword) {
    final codec = Utf8Codec();
    final passwordBytes = codec.encode(enteredPassword); 

    final combinedBytes = Uint8List.fromList([...passwordBytes, ...base64.decode(salt as String)]);

    // Hash the combined bytes using the same hashing algorithm and iterations
    final hashedBytes = sha256.convert(combinedBytes).bytes;

    // Encode the newly generated hash to compare with the stored hash
    final newHash = base64.encode(hashedBytes);
    
    // Compare the new hash with the stored hash
    return newHash == passwordHash;
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

  Future<bool> checkUserLoggedIn(String username, String password) async {
    final List<Map<String, dynamic>> result = await DBHelper().query(
      'user_data', 
      where: 'username = "$username"'
    );

    if (result.isNotEmpty) {
      final userData = UserDataModel(
      username: result[0]['username'],
      passwordHash: result[0]['password'],
      salt: result[0]['salt'],
    );
      return userData.verifyEnteredPassword(password);
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
      'loggedIn': isLoggedInValue,
    });
  }

  Future<void> dbUpdate() async {
    await DBHelper().updateData('user_data', {
      'username': username,
    }, id!);
  }

}