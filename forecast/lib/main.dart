import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/features/AppStart/data/datasource/local_data_source.dart';
import 'package:forecast/features/AppStart/data/repository/city_repository.dart';
import 'package:forecast/features/AppStart/domain/usecase/get_city_usecase.dart';
import 'package:forecast/features/AppStart/domain/usecase/save_city_usecase.dart';
import 'package:forecast/features/AppStart/presentation/bloc/city_bloc.dart';
import 'package:forecast/features/AppStart/presentation/bloc/city_event.dart';
import 'package:forecast/features/AppStart/presentation/pages/login_page/login_screen.dart';

// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final localDataSource = LocalDataSource(prefs: prefs);
  final repository = CityRepository(localDataSource);
  final saveCityUseCase = SaveCityUsecase(repository);
  final getCityUseCase = GetCityUsecase(repository);

  runApp(
    BlocProvider(
      create:
          (context) =>
              CityBloc(saveCityUseCase, getCityUseCase)..add(CheckCityEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ),
  );
}
