import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educalty_chat/modules/auth/data/user_model.dart';
import 'package:educalty_chat/modules/auth/view/login_screen.dart';
import 'package:educalty_chat/modules/chat/data/chat_model.dart';
import 'package:educalty_chat/modules/chat/view/chat_list_screen.dart';
import 'package:educalty_chat/core/go_to.dart';
import 'package:educalty_chat/utils/shared_widgets/tools.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth =
      FirebaseAuth.instance; // Firebase authentication instance

  // Text controllers for login and signup forms
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController signupName = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPass = TextEditingController();
  TextEditingController signupConfirmPass = TextEditingController();

  bool loginLoading = false; // Loading state for login
  bool signupLoading = false; // Loading state for signup

  /// Handles user login with email and password.
  Future<void> login(BuildContext context) async {
    try {
      loginLoading = true; // Set loading state
      notifyListeners(); // Notify listeners for UI update
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text,
      );
      if (credential.user != null) {
        AppConstants.userData = credential.user; // Store user data
        await getUser();
        await upDateOnline(status: true); // Update user online status
        clearControllers(); // Clear input fields
        GoTo.screenAndRemoveUntil(
            const ChatListScreen()); // Navigate to chat list
      }
    } catch (e) {
      Tools.showToast(
          message: e.toString(),
          isSuccess: false,
          context: context); // Show error message
      log(e.toString()); // Log error
    }
    loginLoading = false; // Reset loading state
    notifyListeners(); // Notify listeners for UI update
  }

  /// Listens to the user's authentication state changes.
  Future<void> checkUserState() async {
    firebaseAuth.authStateChanges().listen((user) {
      print(user);
      if (user != null) {
        AppConstants.userData = user; // Update user data on state change
      }
    });
  }

  /// Logs out the current user and updates their online status.
  Future<void> logout() async {
    await upDateOnline(status: false); // Update user offline status
    await firebaseAuth.signOut(); // Sign out from Firebase
    AppConstants.userData = null; // Clear user data
    AppConstants.userModel = null; // Clear user model
    GoTo.screenAndRemoveUntil(const LoginScreen()); // Navigate to login screen
  }

  /// Handles user signup with email and password.
  Future<void> signup(BuildContext context) async {
    try {
      signupLoading = true; // Set loading state
      notifyListeners(); // Notify listeners for UI update
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: signupEmail.text.trim(),
        password: signupPass.text,
      );
      if (credential.user != null) {
        AppConstants.userData = credential.user; // Store user data
        await setupCollection(); // Set up Firestore collections
        await createUser(); // Create user document in Firestore
        await getUser(); // Fetch user data
        GoTo.screenAndRemoveUntil(
            const ChatListScreen()); // Navigate to chat list
        clearControllers(); // Clear input fields
        print('success');
      } else {
        print('failed');
      }
      signupLoading = false; // Reset loading state
    } catch (e) {
      signupLoading = false; // Reset loading state on error
      Tools.showToast(
          message: e.toString(),
          isSuccess: false,
          context: context); // Show error message
      log(e.toString()); // Log error
    }
    notifyListeners(); // Notify listeners for UI update
  }

  /// Clears all text controllers to reset input fields.
  void clearControllers() {
    email.clear();
    pass.clear();
    signupName.clear();
    signupEmail.clear();
    signupPass.clear();
    signupConfirmPass.clear();
  }

  final FirebaseFirestore fireStore =
      FirebaseFirestore.instance; // Firestore instance
  CollectionReference? usersCollection; // Reference to users collection
  CollectionReference? chatCollection; // Reference to chat collection

  /// Sets up Firestore collections with type converters.
  Future<void> setupCollection() async {
    try {
      usersCollection = fireStore.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userProfile, _) => userProfile.toJson(),
          );
      chatCollection = fireStore.collection('chats').withConverter<ChatModel>(
            fromFirestore: (snapshot, _) =>
                ChatModel.fromJson(snapshot.data()!),
            toFirestore: (chatModel, _) => chatModel.toJson(),
          );
    } catch (e) {
      log("Error setting up collections: $e");
    }
  }

  /// Creates a user document in the Firestore users collection.
  Future<void> createUser() async {
    await usersCollection?.doc(AppConstants.userData?.uid).set(
          UserModel(
            uid: AppConstants.userData?.uid,
            name: signupName.text,
            online: true,
          ),
        );
  }

  /// Fetches the user document from Firestore.
  Future<void> getUser() async {
    var user = await usersCollection
        ?.where('uid', isEqualTo: AppConstants.userData?.uid)
        .get();
    AppConstants.userModel =
        user!.docs[0].data() as UserModel?; // Store fetched user data
  }

  /// Updates the user's online status in Firestore.
  Future<void> upDateOnline({required bool status}) async {
    await usersCollection?.doc(AppConstants.userData?.uid).update(
          UserModel(
            uid: AppConstants.userData?.uid,
            name: AppConstants.userModel?.name,
            avatar: AppConstants.userModel?.avatar,
            online: status,
          ).toJson(),
        );
  }
}
