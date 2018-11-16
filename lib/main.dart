import 'package:flutter/material.dart';
import 'package:livescore/uiapps/home_layout.dart';
import 'package:livescore/uiapps/login_layout.dart';


Future<void> main() async{

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeLayout(),
    initialRoute: '/',
    routes: {
      HomeLayout.tag: (ctx) => HomeLayout(),
      LoginLayout.tag: (ctx) => LoginLayout(),
    },
  ));
}