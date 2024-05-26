import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/fw_status.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final CwStatus cwStatus;
  final FwStatus fwStatus;
  const HomeState({
    required this.cwStatus,
    required this.fwStatus,
  });

  HomeState copyWith({
    CwStatus? newCwStatus,
    FwStatus? newFwStatus,
  }) {
    return HomeState(
      cwStatus: newCwStatus ?? cwStatus,
      fwStatus: newFwStatus ?? fwStatus,
    );
  }

  @override
  List<Object?> get props => [cwStatus, fwStatus];
}
