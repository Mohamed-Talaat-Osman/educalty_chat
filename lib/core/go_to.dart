import 'package:flutter/material.dart';

class GoTo {
  // A GlobalKey for managing the Navigator state
  static final GlobalKey<NavigatorState> _navigationKey =
      GlobalKey<NavigatorState>();

  // Getter to access the navigation key
  static GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  // Method to navigate to a new screen
  static Future<dynamic>? screen(Widget screen, [BuildContext? context]) {
    return context != null
        // If a context is provided, use it to push the new screen
        ? Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen))
        :
        // Otherwise, use the global navigation key
        _navigationKey.currentState
            ?.push(MaterialPageRoute(builder: (context) => screen));
  }

  // Method to navigate to a new screen and remove all previous routes
  static Future<dynamic>? screenAndRemoveUntil(dynamic screen,
      [BuildContext? context]) {
    return context != null
        // If a context is provided, use it to push the new screen and remove all previous routes
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false)
        : // Otherwise, use the global navigation key
        _navigationKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false);
  }

  // Method to replace the current screen with a new one
  static Future<dynamic>? screenAndReplacement(dynamic screen,
      [BuildContext? context]) {
    return context != null
        // If a context is provided, use it to replace the current screen
        ? Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => screen))
        : // Otherwise, use the global navigation key
        _navigationKey.currentState
            ?.pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  // Method to go back to the previous screen
  static void goBack() {
    // Pops the current screen off the navigator stack
    return _navigationKey.currentState?.pop();
  }
}
