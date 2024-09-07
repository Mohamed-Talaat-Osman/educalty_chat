import 'package:educalty_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/// A helper class for initializing Firebase in the application.
class FirebaseHelper {
  /// Initializes Firebase with the default options for the current platform.
  ///
  /// This method must be called before using any Firebase services.
  Future<void> initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
