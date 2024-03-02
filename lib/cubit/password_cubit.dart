// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(false);

  void changeState() => emit(!state);
}
