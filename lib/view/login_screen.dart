import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:upwork_assignment/view/hotel_list_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Login With Facebook'),
          onPressed: () {
            signInWithFacebook();
          },
        ),
      ),
    );
  }

  Future<void> signInWithFacebook() async {
    await FirebaseAuth.instance.signOut();
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.accessToken == null) {
      print('token is null');
    } else {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // Once signed in, return the UserCredential
      var userCredentials = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      print(userCredentials.additionalUserInfo);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HotelListingScreen(),),(route) => false,);

    }
  }


}
