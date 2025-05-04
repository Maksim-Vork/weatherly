abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityFound extends CityState {}

class CityNotFound extends CityState {}

class CityError extends CityState {
  final String error;

  CityError(this.error);
}
