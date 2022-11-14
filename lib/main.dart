import 'features/messages_poc/presentation/bloc/messages_bloc.dart';

import 'features/publications/presentation/bloc/publication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/routes/routes_generator.dart';
import 'core/config/shared_preferences/app_preferences.dart';
import 'cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/my_services/presentation/bloc/my_services_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appPreferences = AppPreferences();
  await appPreferences.initPrefs();
  print(appPreferences.isFirstTime);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //var appPreferences = AppPreferences();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (_) => DashboardBloc(),
        ),
        BlocProvider(
          create: (_) => MyServicesBloc(),
        ),
        BlocProvider(
          create: (_) => PublicationBloc(),
        ),
        BlocProvider(
          create: (_) => MessagesBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Overlay Loader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //initialRoute: appPreferences.isFirstTime ? "/" : "/dashboard",
        // TODO: revisar el initialRoute, falta crear una revisión del token y ver si cierra sesión o no.
        initialRoute: "/",
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
