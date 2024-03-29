import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import '../../../cross_features/authentication/presentation/pages/login_page.dart';
import '../../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';

class RouteGenerator {
  //final AuthenticationBloc _authBloc = AuthenticationBloc();
  final DashboardBloc _dashboardBloc = DashboardBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    print("PASO POR ACA");

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) =>
              const LoginPage(title: "Login page with overlay"),
        );

      case '/dashboard':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<DashboardBloc>.value(
              value: _dashboardBloc,
              child: Dashboard(title: "Dashboard", username: args),
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}
