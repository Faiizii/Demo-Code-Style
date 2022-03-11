import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/bloc/user_bloc.dart';
import 'package:upwork_assignment/view/hotel_list_screen.dart';


class LoginScreen extends StatelessWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = UserBloc();
    return Scaffold(
      body:BlocConsumer(
        bloc: _bloc,
        listener: (_, state) {
          //when logged successful move to listing screen
          if (state is LoggedSuccessfully) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HotelListingScreen(state.userModel),), (
                route) => false,);
          }
        },
        builder: (context, state) {
          if (state is LoggingAccount) {
            return _buildUI(message: 'Logging');
          } else if (state is LoggedFailure) {
            return _buildUI(
                message: state.message, color: Colors.red,
                onPressed: () {
                  _bloc.add(LoginWithFacebookEvent());
                });
          }else if(state is LoggedSuccessfully){
            return _buildUI(message: 'Opening Listing');
          } else {
            return _buildUI(
                message: 'This is a demo app for an assignment to demonstrate BLoC',
                onPressed: () {
                  _bloc.add(LoginWithFacebookEvent());
                }
            );
          }
        },)
    );
  }
  Widget _buildUI({required String message, VoidCallback? onPressed, Color color = Colors.black}) {
    return Center(
      // we can also use axis alignment to align the content.
      //but in our case it is creating issue so used center with min size of column
      //with wrap content
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Text(message,textAlign: TextAlign.center,style: TextStyle(color: color),),
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: ElevatedButton(
              child: const Text('Login With Facebook'),
              onPressed: onPressed
          ),
        )
      ],),
    );
  }
}