import 'package:educalty_chat/core/firebase_helper.dart';
import 'package:educalty_chat/core/go_to.dart';
import 'package:educalty_chat/core/providers_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'modules/splash/view/splash_screen.dart';

main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FirebaseHelper().initFirebase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: GoTo.navigationKey,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Inter',
            ),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }
}
