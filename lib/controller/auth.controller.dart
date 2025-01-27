import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/model/user.model.dart';
import "dart:developer";
import 'dart:convert';

class AuthController extends ChangeNotifier {
  static final AuthController _insatance = AuthController._internal();

  factory AuthController() => _insatance;

  AuthController._internal();

  UserModel? user;

  bool showPassword = false;

  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<bool> login() async {
//check if the email and password are correct
    List users =
        jsonDecode(getStringAsync("users", defaultValue: "[]")) as List;
    for (var user in users) {
      UserModel userData = UserModel.fromMap(jsonDecode(user));
      if (userData.email == emailController.text &&
          userData.password == passwordController.text) {
        user = userData;
        emailController.clear();
        passwordController.clear();
        log("UserFound: ${user.toString()}");
        return true;
      } else {
        continue;
      }
    }
    return Future.error("Invalid credentials");
  }

  Future<bool> signup() async {
    List users =
        jsonDecode(getStringAsync("users", defaultValue: "[]")) as List;
    UserModel userData = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    users.add(userData.toJson());
    await setValue("users", jsonEncode(users));
    user = userData;
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
    return true;
  }

  Future<bool> signout() async {
    user = null;
    notifyListeners();
    return true;
  }
}
