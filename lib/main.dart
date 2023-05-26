import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'di/get_it.dart' as getIt;
import 'package:weather_app_with_clean_architecture/presentation/weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();
  runApp(WeatherApp());
}
