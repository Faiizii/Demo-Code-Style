import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/model/user_model.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/provider/user_provider.dart';

abstract class UserEvent{}

class LoginWithFacebookEvent extends UserEvent{}

abstract class AccountState extends Equatable{
  const AccountState();

  @override
  List<Object> get props => [];
}
class WaitingForLoggedIn extends AccountState{}

class LoggingAccount extends AccountState{}

class LoggedSuccessfully extends AccountState{
  final UserModel userModel;
  const LoggedSuccessfully(this.userModel);
}

class LoggedFailure extends AccountState {
  final String message;
  const LoggedFailure(this.message);
}

class UserBloc extends Bloc<UserEvent,AccountState>{
  UserBloc() : super(WaitingForLoggedIn()){
    final _provider = UserProvider();
    on<LoginWithFacebookEvent>((event, emit) async {
      emit(LoggingAccount());
      var userData = await _provider.loginWithFacebook();
      if(userData is ErrorModel){
        emit(LoggedFailure(userData.message));
      }else if(userData is UserModel){
        emit(LoggedSuccessfully(userData));
      }else{
        emit(const LoggedFailure('Unknown error occurred while login with Facebook'));
      }
    },);
  }
}