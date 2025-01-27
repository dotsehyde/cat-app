import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/controller/auth.controller.dart';
import 'package:simpleapp/page/home.dart';
import 'package:simpleapp/page/signup.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final AuthController authState = AuthController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      "Login",
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
                        return 'Email is required';
                      }
                      if (!val.validateEmail()) {
                        return 'Invalid email';
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
                        hintText: 'Email',
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                    controller: authState.emailController,
                  ),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is required';
                      }
                      if (val.length < 5) {
                        return 'Password must be at least 5 characters';
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
                        hintText: 'Password',
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
                        "Login",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )).paddingBottom(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
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
                          child: Text("Signup")),
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
