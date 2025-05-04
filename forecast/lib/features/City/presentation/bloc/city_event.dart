class CityEvent {}

class AddCityEvent extends CityEvent {
  final String nameCity;

  AddCityEvent(this.nameCity);
}

class CheckCityEvent extends CityEvent {}
