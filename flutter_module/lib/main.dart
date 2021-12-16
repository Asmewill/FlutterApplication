import 'package:flutter/material.dart';
import 'package:flutter_module/jdshop/provider/cart_provider.dart';
import 'package:flutter_module/jdshop/provider/checkout_provider.dart';
import 'package:flutter_module/widget/provider/count_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'jdshop/routes/routes.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: Size(750, 1334),
        builder: () {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => CountProvider()),
              ChangeNotifierProvider(create: (context) => CartProvider()),
              ChangeNotifierProvider(create: (context) => CheckoutProvider())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: true,
              title: "FirstFlutter",

              ///默认不配置抽取路由
              // home: ScaffoldBottomNavigationBar1(),
              // routes: {
              //   '/search':(context)=>SearchPage(),
              //   '/form':(context)=>FormPage(),
              // },
              ///抽取路由配置之后
              initialRoute: '/',
              onGenerateRoute: onGenerateRoute,
              theme: ThemeData(primaryColor: Colors.white),
            ),
          );
        });
  }
}
//
// class HomeContent extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return AddNumByElevatedButton();
//   }
// }
