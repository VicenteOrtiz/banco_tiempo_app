import 'package:banco_tiempo_app/features/my_services/infraestructure/models/pending_services_dto.dart';
import 'package:banco_tiempo_app/features/my_services/presentation/pages/my_services_page.dart';
import 'package:banco_tiempo_app/features/poc/presentation/pages/post_page.dart';
import 'package:banco_tiempo_app/features/profile/presentation/pages/profile_page.dart';
import 'package:banco_tiempo_app/features/publications/presentation/pages/publication_page.dart';
import 'package:banco_tiempo_app/features/services/domain/service_entity.dart';
import 'package:banco_tiempo_app/features/services/presentation/pages/service_detail.dart';
import 'package:banco_tiempo_app/features/services/presentation/pages/service_list_page.dart';
import 'package:banco_tiempo_app/features/services/presentation/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import '../../../cross_features/authentication/presentation/pages/login_page.dart';
import '../../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/my_services/presentation/pages/my_services_detail_page.dart';

class RouteGenerator {
  //final AuthenticationBloc _authBloc = AuthenticationBloc();
  final DashboardBloc _dashboardBloc = DashboardBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) =>
              const LoginPage(title: "Login page with overlay"),
        );

      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => Dashboard(),
        );

      //return _errorRoute();
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());

      case '/services-list':
        return MaterialPageRoute(builder: (context) => ServiceListPage());

      case '/poc':
        return MaterialPageRoute(builder: (context) => PostPage());

      case '/service':
        return MaterialPageRoute(builder: ((context) => ServicePage()));

      case '/service/details':
        if (args is Service) {
          return MaterialPageRoute(
              builder: ((context) => ServiceDetail(service: args)));
        }
        return _errorRoute();

      case '/my-services':
        return MaterialPageRoute(builder: (((context) => MyServicesPage())));

      case '/my-services/details':
        if (args is RequestedServiceDto) {
          return MaterialPageRoute(
              builder: ((context) => MyServicesDetailPage(
                    requestedService: args,
                  )));
        }
        return _errorRoute();

      case '/publications':
        return MaterialPageRoute(
          builder: (context) => PublicationPage(),
        );

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
