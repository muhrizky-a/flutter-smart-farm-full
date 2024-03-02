// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

class BottomNavbarCubit extends Cubit<int> {
  BottomNavbarCubit() : super(0);

  int length = 5;

  void set(int page) {
    emit(page);
  }
}
