import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleapp/controller/auth.controller.dart';
import 'package:simpleapp/controller/home.controller.dart';
import 'package:simpleapp/model/cat.model.dart';
import 'package:simpleapp/page/login.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeState = HomeController();
  final AuthController authState = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, size) {
          return AnimatedBuilder(
            animation: authState,
            builder: (context, child) {
              return Column(
                children: [
                  child!,
                  Text(
                    "Welcome, ${authState.user?.name ?? "N/A"}.\nToday's cat image is ready!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!,
                  ).paddingTop(20),
                  TextButton(
                      onPressed: () {
                        authState.signout().then((_) {
                          //Do other Ui checks
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: Text("Log out"),
                                  content:
                                      Text("Are you sure you want to log out?"),
                                  actions: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          authState.signout().then((_) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          }).catchError((e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 2),
                                                    showCloseIcon: true,
                                                    content: Text(
                                                      e.toString(),
                                                    )));
                                          });
                                        },
                                        child: Text("Yes")),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"))
                                  ],
                                );
                              });
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
                        "Log out",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )).paddingTop(10).paddingSymmetric(horizontal: 15),
                ],
              );
            },
            child: FutureBuilder<CatImage>(
                future: homeState.getCatImg(),
                builder: (context, snap) {
                  if (snap.hasError) {
                    return Text("Error: ${snap.error}");
                  }
                  if (snap.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator.adaptive();
                  }
                  return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: size.maxWidth,
                          height: size.maxHeight * 0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(snap.requireData.url),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200]),
                          child: null)
                      .paddingTop(50);
                }),
          );
        }),
      ),
    );
  }
}
