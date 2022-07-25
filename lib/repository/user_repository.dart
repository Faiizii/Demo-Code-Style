// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/utils/app_utils.dart';

class UserRepository {
  Future<dynamic> facebookLogin() async {

    bool isNetwork = await AppUtils.isNetworkAvailable();
    if(!isNetwork){
      return ErrorModel(message: 'No Internet Connection');
    }

    // Trigger the sign-in flow from Facebook SDK
    // final LoginResult loginResult = await FacebookAuth.instance.login();
    // if (loginResult.accessToken == null) {
    //   return ErrorModel(message: 'Unable to continue with facebook');
    // } else {
    //   // Create a credential from the access token
    //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //   // Once signed in, return the UserCredential
    //   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    // }
  }
}