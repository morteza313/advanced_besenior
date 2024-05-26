import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_current_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_forcast_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/fw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  GetForcastWeatherUsecase getForcastWeatherUsecase;
  HomeBloc(
    this.getCurrentWeatherUsecase,
    this.getForcastWeatherUsecase,
  ) : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));

      DataState dataState = await getCurrentWeatherUsecase(event.cityName);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleated(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CWError(dataState.error!)));
      }
    });

    //load 7 days forecast event for city event
    on<LoadFwEvent>((event, emit) async {
      //emit staet to loadin gfoe just fw
      emit(state.copyWith(newFwStatus: FwLoading()));

      DataState dataState = await getForcastWeatherUsecase(event.forcastParams);

      //emit state to compleated for just Fw
      if (dataState is DataSuccess) {
        emit(state.copyWith(newFwStatus: FwCompleated(dataState.data)));
      }

      //emit state to error for just fw
      if (dataState is DataFailed) {
        emit(state.copyWith(newFwStatus: FwError(dataState.error)));
      }
    });
  }
}
