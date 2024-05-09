import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketok/core/dependency_injection/locator.dart';
import 'package:poketok/core/routes/app_routes.dart' as router;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setupLocator();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
  await Future.delayed(
    const Duration(seconds: 6),
    () {
      FlutterNativeSplash.remove();
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Poketok',
      debugShowCheckedModeBanner: false,
      initialRoute: router.Router.pokemon,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
