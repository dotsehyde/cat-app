import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/controller/auth.controller.dart';
import 'package:simpleapp/page/home.dart';
import 'package:simpleapp/page/login.dart';
import 'package:simpleapp/translations/locale_keys.g.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final authState = AuthController();

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
          return AnimatedBuilder(
              animation: authState,
              builder: (context, child) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: size.maxWidth * 0.4,
                            height: size.maxHeight * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/signup.webp"),
                              ),
                            )),
                        Container(
                          width: size.maxWidth,
                          padding: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            LocaleKeys.login_signup.tr(),
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              prefixIcon: Icon(Icons.person),
                              hintText: LocaleKeys.fullName.tr(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          controller: authState.nameController,
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!val.validateEmail()) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black),
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
                        ).paddingTop(20),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Phone number is required';
                            }
                            if (val.length != 10) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              prefixIcon: Icon(Icons.phone),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              hintText: 'Phone',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          controller: authState.phoneController,
                        ).paddingTop(20),
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
                          textInputAction: TextInputAction.next,
                          obscureText: !authState.showPassword,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              suffix: IconButton(
                                  onPressed: () {
                                    authState.togglePassword();
                                  },
                                  icon: Icon(authState.showPassword
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
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if (val.length < 5) {
                              return 'Password must be at least 5 characters';
                            }
                            if (val != authState.passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          obscureText: !authState.showPassword,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              prefixIcon: Icon(Icons.lock),
                              suffix: IconButton(
                                  onPressed: () {
                                    authState.togglePassword();
                                  },
                                  icon: Icon(authState.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              hintText: 'Confirm Password',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          controller: authState.confirmPasswordController,
                        ).paddingBottom(20),
                        TextButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              authState.signup().then((_) {
                                //Do other Ui checks
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }).catchError((e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                              "Signup",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )).paddingBottom(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  "Login",
                                )),
                          ],
                        ).withWidth(size.maxWidth),
                      ],
                    ).paddingSymmetric(horizontal: 15),
                  ),
                );
              });
        }),
      ),
    );
  }
}
