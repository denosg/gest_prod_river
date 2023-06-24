import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

import '/theme/theme.dart';
import '/screens/listings_overview_screen.dart';
import '/screens/add_listing_screen.dart';

void main() async {
  //Makes it so the system is ready to work
  WidgetsFlutterBinding.ensureInitialized();
  //wait for firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Sets preffered orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //Runs the app on boot
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ListingsOverviewScreen(),
      routes: {
        //add listing screen
        AddListingScreen.routeName: (context) => const AddListingScreen(),
        //listing overview screen
        ListingsOverviewScreen.routeName: (context) =>
            const ListingsOverviewScreen(),
      },
    );
  }
}
