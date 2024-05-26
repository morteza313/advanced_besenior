import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/widgets/app_bacground.dart';
import 'package:advanced_besenior/core/widgets/dot_loading_widget.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/forcastDaysModel.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/fw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_state.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/widgets/days_weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "Tehran";
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
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
            buildWhen: (previous, current) {
              //rebuild just when cw status changed
              if (previous.cwStatus == current.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return const Expanded(
                  child: DotLoadingWidget(),
                );
              }
              if (state.cwStatus is CwCompleated) {
                //cast
                final CwCompleated cwCompleated =
                    state.cwStatus as CwCompleated;
                final CurrentCityEntity currentCityEntity =
                    cwCompleated.currentCityEntity;

                //create params for api call
                final ForcastParams forcastParams = ForcastParams(
                    currentCityEntity.coord!.lat!,
                    currentCityEntity.coord!.lon!);

                //start load Fw event
                BlocProvider.of<HomeBloc>(context)
                    .add(LoadFwEvent(forcastParams: forcastParams));
                return Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: SizedBox(
                          width: width,
                          height: 400,
                          child: PageView.builder(
                            itemCount: 2,
                            physics: const AlwaysScrollableScrollPhysics(),
                            allowImplicitScrolling: true,
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
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
                                        currentCityEntity
                                            .weather![0].description!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: AppBackground.setIconForMain(
                                          currentCityEntity
                                              .weather![0].description!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        " ${currentCityEntity.main!.temp!.round()}\u00B0",
                                        style: const TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //max temp
                                        Column(
                                          children: [
                                            const Text(
                                              'max',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              " ${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),

                                        //divider
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Container(
                                            color: Colors.grey,
                                            width: 2,
                                            height: 40,
                                          ),
                                        ),

                                        //min temp
                                        Column(
                                          children: [
                                            const Text(
                                              'min',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              " ${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                return Container(
                                  color: Colors.amber,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //indicator
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 2,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (index) =>
                              _pageController.animateToPage(
                            index,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.bounceOut,
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: width,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.only(left: 19),
                            child: Center(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  //show loading state for Fw
                                  if (state.fwStatus is FwLoading) {
                                    return const DotLoadingWidget();
                                  }

                                  //show completed state foe Fw
                                  if (state.fwStatus is FwCompleated) {
                                    //casting
                                    final FwCompleated fwCompleated =
                                        state.fwStatus as FwCompleated;
                                    final ForecastDaysEntity
                                        forecastDaysEntity =
                                        fwCompleated.forecastDaysEntity;
                                    final List<Daily> mainDaily =
                                        forecastDaysEntity.daily!;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        return DaysWeatherView(
                                          daily: mainDaily[index],
                                        );
                                      },
                                    );
                                  }

                                  if (state.fwStatus is FwError) {
                                    final FwError fwError =
                                        state.fwStatus as FwError;
                                    return Center(
                                        child: Text(fwError.message!));
                                  }

                                  //show default state fow fw
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                    ],
                  ),
                );
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
