import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/routing/routing_class.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: appcolor,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const WasletKhier());
}

class WasletKhier extends StatelessWidget {
  const WasletKhier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
