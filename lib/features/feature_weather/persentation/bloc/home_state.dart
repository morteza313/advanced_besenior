import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';

class HomeState {
  CwStatus cwStatus;
  HomeState({
    required this.cwStatus,
  });

  HomeState copyWith({CwStatus? newCwStatus}) {
    return HomeState(cwStatus: newCwStatus ?? cwStatus);
  }
}

// class HomeInitiallState extends HomeState {}
