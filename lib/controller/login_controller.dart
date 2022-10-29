import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/models/user_model.dart';
import 'package:mochigo/presentation/login_screen.dart';

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
          userType: "user",
        );

        //adding new user data
        final UserProvider userProvider = Get.find<UserProvider>();
        await userProvider.addUser(userData);

        Get.snackbar('Logged in successfully', '');
        return true;
      }
      return false;
    } catch (platFormException) {
      Get.snackbar(platFormException.toString(), '');

      return false;
    }
  }

//facebook logout
  Future<bool> logoutFacebook() async {
    try {
      await FacebookAuth.instance.logOut();

      await FirebaseAuth.instance.signOut();

      await Get.offAll(() => LoginScreen());

      return true;
    } catch (platFormException) {
      Get.snackbar(platFormException.toString(), '');

      return false;
    }
  }

//google sign in
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      //sign in with google
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        userData = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: userCredential.user!.displayName as String,
          photoUrl: userCredential.user!.photoURL as String,
          mochiAdvertiseId: '',
          userType: "user",
          provider: 'Google',
        );
      }
      //adding new user data to database
      final UserProvider userProvider = Get.find<UserProvider>();
      await userProvider.addUser(userData);
      Get.snackbar('Logged in successfully', '');

      return true;
    } catch (platFormException) {
      Get.snackbar(platFormException.toString(), '');

      return false;
    }
  }

//google signout
  Future<bool> signOutGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await FirebaseAuth.instance.signOut();

      await googleSignIn.signOut();

      await Get.offAll(() => LoginScreen());

      return true;
    } catch (platFormException) {
      Get.snackbar('Error', platFormException.toString());

      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = FirebaseAuth.instance.currentUser;
      final UserProvider userProvider = Get.find<UserProvider>();
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('user')
              .where('email', isEqualTo: email)
              .get();

      if (user != null) {
        userData = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: userCredential.user!.email as String,
          photoUrl:
              "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
          mochiAdvertiseId: '',
          userType: snapshot.docs[0].data()['userType'],
          provider: 'Email',
        );
      }
      //adding new user data to database
      await userProvider.addUser(userData);
      Get.snackbar('Sign in user successfully', '');

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'User was not found.',
          'Check if you used the right email address.',
          colorText: const Color.fromARGB(255, 255, 0, 0),
        );
        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Wrong password provided for that user.',
          'Verify the password and try again.',
          colorText: const Color.fromARGB(255, 255, 0, 0),
        );
        return false;
      }
      return false;
    }
  }

  String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
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

      if (username.isEmpty) {
        Get.snackbar(
          'You must provide a username!',
          'Please check again and retry',
          colorText: const Color.fromARGB(255, 255, 0, 0),
        );

        return false;
      }

      if (user != null) {
        userData = UserModel(
          userId: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: username,
          photoUrl:
              'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
          mochiAdvertiseId: '',
          userType: "user",
          provider: 'Email',
        );
      }
      //adding new user data to database
      final UserProvider userProvider = Get.find<UserProvider>();
      await userProvider.addUser(userData);
      Get.snackbar('Created user successfully', '');

      return true;
    } on FirebaseAuthException catch (e) {
      final String exception = getExceptionText(e);
      Get.snackbar(
        'Creating an account failed',
        exception,
        colorText: const Color.fromARGB(255, 255, 0, 0),
      );

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
    } catch (platFormException) {
      Get.snackbar(platFormException.toString(), '');

      return false;
    }
  }
}
