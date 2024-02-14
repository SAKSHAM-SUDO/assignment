import 'package:assignment/model/age_group.dart';
import 'package:assignment/screens/auth/auth.dart';
import 'package:assignment/screens/auth/bloc/auth_bloc.dart';
import 'package:assignment/screens/home/bloc/home_bloc.dart';
import 'package:assignment/screens/home/components/filter_screen.dart';
import 'package:assignment/screens/home/home.dart';
import 'package:assignment/utils/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':

      case Screens.login:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => AuthBloc(),
            child: const AuthScreen(),
          );
        });

      case Screens.home:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: const HomeScreen(),
          );
        });

      case Screens.filter:
        Map<String, dynamic> data = args as Map<String, dynamic>;
        List<AgeGroup> ageGroup = data["ageGroup"];
        AgeGroup? selectedAgeGroup = data["selectedAgeGroup"];
        return MaterialPageRoute(builder: (_) {
          return FilterScreen(selectedAgeGroup: selectedAgeGroup, ageGroups: ageGroup,);
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => AuthBloc(),
            child: const AuthScreen(),
          );
        });
    }
  }
}
