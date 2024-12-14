import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/password_states.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  PasswordCubit():super(InitialState());
  bool passwordStates = true;
  changePasswordState(){
    passwordStates = !passwordStates;
    emit(ChangePasswordState());
  }
}