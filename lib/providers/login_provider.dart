import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mochigo/core/models/user_model.dart';
import 'package:mochigo/presentation/login_screen.dart';
import 'package:mochigo/providers/user_provider.dart';

class LoginProvider extends GetxController {
  late UserModel _user;

  //getter for userdata
  UserModel get userData => _user;

  //setter for user data
  set userData(UserModel user) {
    _user = user;
    update();
  }

//facebook login
  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        print(result.status.toString());
        final AccessToken accessToken = result.accessToken!;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        userData = UserModel(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email as String,
            name: userCredential.user!.displayName as String,
            photoUrl: userCredential.user!.photoURL as String,
            mochiAdvertiseId: '',
            provider: 'Facebook',
            favouritList: []);

        //adding new user data
        final UserProvider _userProvider = Get.find<UserProvider>();
        await _userProvider.addUser(userData);

        Get.snackbar('Logged in successfully', '');
        return true;
      }
      return false;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//facebook logout
  Future<bool> logoutFacebook() async {
    try {
      await FacebookAuth.instance.logOut();

      await FirebaseAuth.instance.signOut();

      Get.offAll(() => LoginScreen());

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//google sign in
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      //sign in with google
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        userData = UserModel(
            userId: userCredential.user!.uid,
            email: userCredential.user!.email as String,
            name: userCredential.user!.displayName as String,
            photoUrl: userCredential.user!.photoURL as String,
            mochiAdvertiseId: '',
            favouritList: ['x', 'y', 'z'],
            provider: 'Google');
      }
      //adding new user data to database
      final UserProvider _userProvider = Get.find<UserProvider>();
      await _userProvider.addUser(userData);
      Get.snackbar('Logged in successfully', '');

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

//google signout
  Future<bool> signOutGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      await FirebaseAuth.instance.signOut();

      await _googleSignIn.signOut();

      Get.offAll(() => LoginScreen());

      return true;
    } catch (PlatFormException) {
      Get.snackbar('Error', PlatFormException.toString());

      return false;
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userData = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: userCredential.user!.email as String,
          photoUrl:
              "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
          mochiAdvertiseId: '',
          favouritList: ['x', 'y', 'z'],
          provider: 'Email',
        );
      }
      //adding new user data to database
      final UserProvider _userProvider = Get.find<UserProvider>();
      await _userProvider.addUser(userData);
      Get.snackbar('Sign in user successfully', '');

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Wrong password provided for that user.', '',
            colorText: Color.fromARGB(255, 255, 0, 0));
        print('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userData = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: username,
          photoUrl:
              "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
          mochiAdvertiseId: '',
          favouritList: ['x', 'y', 'z'],
          provider: 'Email',
        );
      }
      //adding new user data to database
      final UserProvider _userProvider = Get.find<UserProvider>();
      await _userProvider.addUser(userData);
      Get.snackbar('Created user successfully', '');

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }

  //facebook logout
  Future<bool> logoutEmail() async {
    try {
      await FirebaseAuth.instance.signOut();

      await Get.offAll(() => LoginScreen());
      Get.snackbar('You just logged out.', '');

      return true;
    } catch (PlatFormException) {
      print(PlatFormException.toString());

      Get.snackbar(PlatFormException.toString(), '');

      return false;
    }
  }
}
