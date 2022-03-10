import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class UserProvider extends BlocProvider{
  UserProvider({required Create<StateStreamableSource<Object?>> create}) : super(create: create);

}