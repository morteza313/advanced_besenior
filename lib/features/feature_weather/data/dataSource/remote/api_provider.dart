import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/utils/constants.dart';
import 'package:dio/dio.dart';

class APiProvider {
  final Dio dio = Dio();
  var apiKey = Constants.apiKey;

// current weather api call
  Future<dynamic> callCurrentWeather(cityName) async {
    var respone = await dio.get(
      '${Constants.baseUrl}/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        "appid": apiKey,
        "units": 'metric',
      },
    );
    return respone;
  }

//7 days forecast api
  Future<dynamic> sendRequest7DaysForcast(ForcastParams params) async {
    var response = await dio
        .get("${Constants.baseUrl}/data/2.5/onecall", queryParameters: {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutely,hourly',
      'appid': apiKey,
      'units': 'metric'
    });
    return response;
  }
}
