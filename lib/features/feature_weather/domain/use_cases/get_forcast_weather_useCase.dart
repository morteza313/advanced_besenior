import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/core/usecase/use_case.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/repository/weather_repository.dart';

class GetForcastWeatherUsecase
    implements UseCase<DataState<ForecastDaysEntity>, ForcastParams> {
  final WeatherRepository weatherRepository;
  GetForcastWeatherUsecase(this.weatherRepository);
  @override
  Future<DataState<ForecastDaysEntity>> call(ForcastParams param) {
    return weatherRepository.fetchForecastWeatherData(param);
  }
}
