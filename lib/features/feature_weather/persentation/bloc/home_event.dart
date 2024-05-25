abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;

  LoadCwEvent({required this.cityName});
}
