import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/app/bloc/app_bloc.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';
import 'package:recommender_saver/home/view/home_page.dart';
import 'package:recommender_saver/login/view/login_page.dart';

import '../../di/components/service_locator.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      HomeCubit().init();
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}

// List<Page<dynamic>> onGenerateAppViewPages(
//   AppStatus state,
//   List<Page<dynamic>> pages,
// ) {
//   final AppRouter router = AppRouter();

//   Route? route;
//   switch (state) {
//     case AppStatus.authenticated:
//       route = router.generateRoute(RouteSettings(name: "/"));
//       break;
//     case AppStatus.unauthenticated:
//       route = router.generateRoute(RouteSettings(name: "/login"));
//       break;
//   }

//   // Check if route is not null and convert it to a MaterialPage
//   if (route != null && route.settings is MaterialPageRoute) {
//     final MaterialPageRoute materialRoute = route as MaterialPageRoute;
//     return [
//       MaterialPage(
//         key: materialRoute.settings.name != null ? ValueKey(materialRoute.settings.name) : null,
//         child: materialRoute.builder(materialRoute.context),
//       )
//     ];
//   }

//   // Return an empty list if no route matches
//   return [];
// }

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: HomePage(
              isChange: true,
            ),
          ),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) =>
              LoginPage(), // Assuming LoginPage is a simple widget without BlocProvider
        );
      default:
        return null;
    }
  }
}
