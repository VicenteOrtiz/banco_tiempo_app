import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/views/pending_messages_page.dart';
import 'package:banco_tiempo_app/features/profile/domain/profile_entity.dart';
import 'package:banco_tiempo_app/features/register/register_page.dart';
import 'package:banco_tiempo_app/features/registration/presentation/views/registration_page.dart';
import 'package:banco_tiempo_app/features/services/presentation/pages/service_report.dart';
import 'package:banco_tiempo_app/features/settings/presentation/pages/change_password_page.dart';
import 'package:banco_tiempo_app/features/settings/presentation/pages/contact_data_edit_page.dart';
import 'package:banco_tiempo_app/features/settings/presentation/pages/personal_data_edit_page.dart';
import 'package:banco_tiempo_app/features/settings/presentation/pages/settings_page.dart';

import '../../../cross_features/badges/domain/badges_entity.dart';
import '../../../features/messages_poc/presentation/views/chat_screen.dart';
import '../../../features/my_services/infraestructure/models/pending_services_dto.dart';
import '../../../features/my_services/presentation/pages/my_services_page.dart';
import '../../../features/my_services/presentation/pages/my_services_review_page.dart';
import '../../../features/poc/presentation/pages/post_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/publications/domain/publication_entity.dart';
import '../../../features/publications/presentation/pages/create_publication_page.dart';
import '../../../features/publications/presentation/pages/publication_page.dart';
import '../../../features/services/domain/service_entity.dart';
import '../../../features/services/presentation/pages/service_comment.dart';
import '../../../features/services/presentation/pages/service_detail.dart';
import '../../../features/services/presentation/pages/service_list_page.dart';
import '../../../features/services/presentation/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import '../../../cross_features/authentication/presentation/pages/login_page.dart';
import '../../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/my_services/presentation/pages/my_services_detail_page.dart';
import '../../../features/my_services/presentation/pages/my_services_requested_detail_page.dart';
import '../../../features/publications/presentation/pages/publication_detail_page.dart';

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

      case '/registration':
        return MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        );

      case '/change-password':
        return MaterialPageRoute(
          builder: (context) => ChangePasswordPagePage(),
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

      case '/service/comment':
        if (args is Service) {
          return MaterialPageRoute(
              builder: ((context) => CommentServicePage(
                    service: args,
                  )));
        }
        return _errorRoute();
      case '/service/report':
        if (args is Service) {
          return MaterialPageRoute(
              builder: ((context) => ReportServicePage(
                    service: args,
                  )));
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

      case '/my-services/requested-details':
        if (args is RequestedServiceDto) {
          return MaterialPageRoute(
              builder: ((context) => MyServicesRequestedDetailPage(
                    requestedService: args,
                  )));
        }
        return _errorRoute();

      //TODO: FALTO MAPEARLO A RUTA
      /* case '/my-services/review':
        if (args is List<Badge>) {
          return MaterialPageRoute(
              builder: ((context) => ServiceReviewPage(
                    badges: args,
                  )));
        }
        return _errorRoute(); */

      case '/publications':
        return MaterialPageRoute(
          builder: (context) => PublicationPage(),
        );

      case '/publications/details':
        if (args is Publication) {
          return MaterialPageRoute(
              builder: ((context) => PublicationDetailPage(
                    publication: args,
                  )));
        }
        return _errorRoute();

      case '/publications/create':
        if (args is List<Categoria>) {
          return MaterialPageRoute(
            builder: (context) => CreatePublicationPage(
              categories: args,
            ),
          );
        }
        return _errorRoute();

      case '/message':
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => ChatScreen(
              serviceId: args,
            ),
          );
        }
        return _errorRoute();

      case '/pending-messages':
        return MaterialPageRoute(
          builder: (context) => PendingMessagesPage(),
        );

      case '/profile/edit':
        if (args is Profile) {
          return MaterialPageRoute(
            builder: (context) => PersonalDataEditPage(
              profile: args,
            ),
          );
        }
        return _errorRoute();

      case '/contact/edit':
        if (args is Profile) {
          return MaterialPageRoute(
            builder: (context) => ContactDataEditPage(
              profile: args,
            ),
          );
        }
        return _errorRoute();

      //TODO: get this route working
      /* case '/settings':
        return MaterialPageRoute(builder: (context) => SettingsPage()); */

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
