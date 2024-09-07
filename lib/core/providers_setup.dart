import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../modules/auth/controller/auth_provider.dart';
import '../modules/chat/controller/chat_provider.dart';
import '../modules/splash/controller/splash_provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
  ChangeNotifierProvider<SplashProvider>(create: (context) => SplashProvider()),
];
