import 'package:flutter/material.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/routes/routes_import.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            title: 'Flutter Assignment2',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            routerConfig: _appRouter.config(),
          );
        }
    );
  }
}
