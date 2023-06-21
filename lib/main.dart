import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  //Makes it so SystemChrome.setPreferredOrientations works
  WidgetsFlutterBinding.ensureInitialized();
  //Sets preffered orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //Runs the app on boot
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
