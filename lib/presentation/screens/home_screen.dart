import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/presentation/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: InputBorder.none,
          ),
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 15, top: 8),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  return state is WeatherBlocLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          onPressed: () {
                            context.read<WeatherBlocBloc>().add(
                                GetWeatherByCityEvent(
                                    searchController.text, context));
                          },
                        );
                },
              )),
        ],
      ),
      body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                const Align(
                  alignment: AlignmentDirectional(5, -.3),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-5, -.3),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
                Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 250,
                      width: 300,
                      decoration: const BoxDecoration(color: Colors.amber),
                    )),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 65, sigmaY: 65),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                state is WeatherBlocLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state is WeatherBlocSucces
                        ? ListView(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '📍 ${state.weather.city_name}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Good Morning',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              Image.asset(WeatherBlocBloc.weatherImage(
                                  state.weather.main)),
                              Text(
                                '${state.weather.temp.toString()} °C',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 40),
                              ),
                              Text(
                                state.weather.description,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                DateFormat('EEEE dd HH:mm a')
                                    .format(DateTime.now())
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/11.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Sunrise',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Text(
                                        state.weather.sunrise.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/12.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Text(
                                        state.weather.sunset.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 18),
                                child: const Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/13.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Temp Max',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Text(
                                        '${state.weather.temp_max}°C',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/14.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Temp Min',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Text(
                                        '${state.weather.temp_min}°C',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        : const Center(
                            child: Text('wait'),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
