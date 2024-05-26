import 'package:advanced_besenior/core/params/forcast_params.dart';

abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;

  LoadCwEvent({required this.cityName});
}

class LoadFwEvent extends HomeEvent {
  final ForcastParams forcastParams;
  LoadFwEvent({required this.forcastParams});
}
