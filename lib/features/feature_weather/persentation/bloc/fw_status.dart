import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FwStatus {}

//loading state
class FwLoading extends FwStatus {}

//loaded state
class FwCompleated extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;
  FwCompleated(this.forecastDaysEntity);
}

//error state
class FwError extends FwStatus {
  final String? message;
  FwError(this.message);
}
