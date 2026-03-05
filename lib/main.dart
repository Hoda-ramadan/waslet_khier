import 'package:flutter/material.dart';
import 'package:waslet_khier/core/routing/routing_class.dart';

void main() {
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
