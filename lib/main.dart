import 'package:banco_tiempo_app/cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:banco_tiempo_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/routes/routes_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider(create: (_) => DashboardBloc())
      ],
      child: MaterialApp(
        title: 'Overlay Loader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
