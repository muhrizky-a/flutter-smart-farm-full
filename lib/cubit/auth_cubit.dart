// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import '../exceptions/client_error.dart';
import '../use_case/auth_use_case.dart';
import 'state/cubit_state.dart';

class AuthCubit extends Cubit<CubitState> {
  AuthCubit(this._authUseCase) : super(CubitInitial());
  final AuthUseCase _authUseCase;

  void login(String email, String password) async {
    try {
      emit(CubitLoading());
      await _authUseCase.login(email, password);
      emit(AuthSuccess());
    } catch (e) {
      debugPrint(e is ClientError ? e.message : e.toString());
      emit(
        CubitFailed(
          e is ClientError ? e.message : e.toString(),
        ),
      );
    }
  }

  void register(
    String name,
    String email,
    String password,
  ) async {
    try {
      emit(CubitLoading());
      await _authUseCase.register(
        name,
        email,
        password,
      );
      emit(AuthSuccess());
    } catch (e) {
      debugPrint(e is ClientError ? e.message : e.toString());
      emit(CubitFailed(
        e is ClientError ? e.message : e.toString(),
      ));
    }
  }
}

class AuthSuccess extends CubitState {}
