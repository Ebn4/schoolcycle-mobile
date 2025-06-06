import 'package:flutter/material.dart';
import 'package:schoolcycle_mobile/business/service/schoolCycleLocalService.dart';
import 'package:schoolcycle_mobile/business/service/schoolCycleNetworkService.dart';
import 'package:schoolcycle_mobile/framework/schoolCycleLocalImpl.dart';
import 'package:schoolcycle_mobile/framework/schoolCycleNetworkImpl.dart';
import 'package:schoolcycle_mobile/pages/home/homePage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

setup() {
  getIt.registerLazySingleton<SchoolcycleNetworkService>(() {
    return Schoolcyclenetworkimpl();
  });

  getIt.registerLazySingleton<SchoolCycleLocalService>(() {
    return Schoolcyclelocalimpl();
  });
}

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchoolCycle',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
