import 'package:advanced_besenior/core/widgets/app_bacground.dart';
import 'package:advanced_besenior/core/widgets/dot_loading_widget.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "Tehran";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName: cityName));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return const Expanded(
                  child: DotLoadingWidget(),
                );
              }
              if (state.cwStatus is CwCompleated) {
                final CwCompleated cwCompleated =
                    state.cwStatus as CwCompleated;
                final CurrentCityEntity currentCityEntity =
                    cwCompleated.currentCityEntity;
                return Expanded(
                    child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            currentCityEntity.name!,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            currentCityEntity.weather![0].description!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AppBackground.setIconForMain(
                              currentCityEntity.weather![0].description!),
                        )
                      ],
                    )
                  ],
                ));
              }
              if (state.cwStatus is CWError) {
                return const Center(
                  child: Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
