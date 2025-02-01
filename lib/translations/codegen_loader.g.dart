// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "email": "Email Address",
  "password": "Password",
  "fullName": "Full Name",
  "phone": "Phone number",
  "cPassword": "Confirm Password",
  "login_have_account": "Don't have an account?",
  "login_text": "Login",
  "login_signup": "Signup",
  "password_required": "Password is required",
  "email_required": "Email is required",
  "email_invalid": "Invalid email address",
  "password_length": "Password must be at least 5 characters"
};
static const Map<String,dynamic> _fr = {
  "email": "Adresse email",
  "password": "Mot de passe",
  "fullName": "Nom et prénom",
  "phone": "Numéro de téléphone",
  "cPassword": "Confirmez le mot de passe",
  "login_have_account": "Vous n'avez pas de compte?",
  "login_text": "Se connecter",
  "login_signup": "S'inscrire",
  "password_required": "Le mot de passe est requis",
  "email_required": "L'e-mail est requis",
  "email_invalid": "Adresse e-mail invalide",
  "password_length": "Le mot de passe doit contenir au moins 5 caractères"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "fr": _fr};
}
