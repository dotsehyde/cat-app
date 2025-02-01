import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/controller/auth.controller.dart';
import 'package:simpleapp/page/home.dart';
import 'package:simpleapp/page/signup.dart';
import 'package:simpleapp/translations/locale_keys.g.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final AuthController authState = AuthController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
                  color: Theme.of(context).cardColor,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          value: "en", child: Text("🏴󠁧󠁢󠁥󠁮󠁧󠁿 English")),
                      PopupMenuItem(value: "fr", child: Text("🇫🇷 Français")),
                    ];
                  },
                  onSelected: (String value) {
                    context.setLocale(Locale(value));
                  },
                  child: Icon(Icons.language,
                      color: Theme.of(context).primaryColor))
              .paddingRight(10)
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, size) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: size.maxWidth * 0.4,
                      height: size.maxHeight * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/login4.avif"),
                        ),
                      )),
                  Container(
                    width: size.maxWidth,
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.login_text.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.email_required.tr();
                      }
                      if (!val.validateEmail()) {
                        return LocaleKeys.email_invalid.tr();
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10),
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        hintText: LocaleKeys.email.tr(),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                    controller: authState.emailController,
                  ),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.password_required.tr();
                      }
                      if (val.length < 5) {
                        return LocaleKeys.password_length.tr();
                      }
                      return null;
                    },
                    obscureText: !authState.showPassword,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        suffix: IconButton(
                            onPressed: () {
                              authState.togglePassword();
                            },
                            icon: Icon(!authState.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        prefixIcon: Icon(Icons.lock),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        hintText: LocaleKeys.password.tr(),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                    controller: authState.passwordController,
                  ).paddingSymmetric(vertical: 20),
                  TextButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        authState.login().then((_) {
                          //Do other Ui checks
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }).catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              showCloseIcon: true,
                              content: Text(
                                e.toString(),
                              )));
                        });
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size(size.maxWidth, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        LocaleKeys.login_text.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )).paddingBottom(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.login_have_account.tr()),
                      TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(LocaleKeys.login_signup.tr())),
                    ],
                  ).withWidth(size.maxWidth),
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
          );
        }),
      ),
    );
  }
}
