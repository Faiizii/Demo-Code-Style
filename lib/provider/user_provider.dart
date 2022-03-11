import 'package:firebase_auth/firebase_auth.dart';
import 'package:upwork_assignment/model/user_model.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/repository/user_repository.dart';

class UserProvider {
  final _repo = UserRepository();

  Future<dynamic> loginWithFacebook() async {
    UserModel userModel = UserModel(); //use this model to return logged in user data
    if(FirebaseAuth.instance.currentUser != null){
      //in case user is already logged in fetch the detail and send to UI
      //instead of perform the login cycle again
      userModel.email = FirebaseAuth.instance.currentUser?.email;
      userModel.fullName = FirebaseAuth.instance.currentUser?.displayName;
      return userModel;
    }else{
      //perform facebook login
      var userResponse = await _repo.facebookLogin();
      if(userResponse is UserCredential){
        userModel.fullName = '${userResponse.user?.displayName}';
        userModel.email = '${userResponse.user?.email}';
        return userModel;
      }else{
        return userResponse; //unhandled response and returned as ErrorModel
      }
    }
  }
}