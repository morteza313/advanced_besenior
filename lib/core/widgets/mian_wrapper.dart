import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName: 'tehran'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: const Text('MainWrapper'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Center(
                child: Text('Loading ...'),
              );
            }
            if (state.cwStatus is CwCompleated) {
              return const Center(
                child: Text('Compleated'),
              );
            }
            if (state.cwStatus is CWError) {
              return const Center(
                child: Text('Error'),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
