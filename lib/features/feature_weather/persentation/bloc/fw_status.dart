import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FwStatus extends Equatable {}

//loading state
class FwLoading extends FwStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//loaded state
class FwCompleated extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;
  FwCompleated(this.forecastDaysEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [forecastDaysEntity];
}

//error state
class FwError extends FwStatus {
  final String? message;
  FwError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
