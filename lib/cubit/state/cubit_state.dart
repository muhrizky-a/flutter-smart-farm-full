abstract class CubitState {}

class CubitInitial extends CubitState {}

class CubitLoading extends CubitState {}

class CubitSuccess extends CubitState {}

class CubitFinish extends CubitState {}

class CubitFailed extends CubitState {
  final String error;
  CubitFailed(this.error);
}

class AddDataSuccess extends CubitSuccess {}

class UpdateDataSuccess extends CubitSuccess {}

class DeleteDataSuccess extends CubitSuccess {}
