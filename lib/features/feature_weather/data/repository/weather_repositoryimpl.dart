import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/feature_weather/data/dataSource/remote/api_provider.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/current_city_model.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryimpl extends WeatherRepository {
  APiProvider aPiProvider;
  WeatherRepositoryimpl(this.aPiProvider);
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await aPiProvider.callCurrentWeather(cityName);

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed('Something went wron, try again ...');
      }
    } catch (e) {
      return const DataFailed('please check your connection ...');
    }
  }
}
