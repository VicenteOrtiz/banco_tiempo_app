import '../../../../app/assets_manager.dart';
import '../../../../app/presentation/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/image_builder.dart';
import '../../../../app/presentation/shared_widgets/loader.dart';
import '../Widgets/text_data_widget.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/input_field.dart';
import '../widgets/login_button_widget.dart';
import '../widgets/social_signin_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        //backgroundColor: ColorPrimary.primaryColor,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationError) {
              buildErrorLayout(state.message);
            } else if (state is AuthenticationLoaded) {
              clearTextData();
              Navigator.of(context)
                  .pushNamed('/dashboard', arguments: state.name);
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return LoadingWidget(child: buildInitialInput());
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorGradient.leftColor,
                ColorGradient.rightColor,
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace80,
              //ImageBuilder(imagePath: loginImages[1]),
              ImageBuilder(imagePath: AssetsManager.logoBanco),
              verticalSpace24,
              //const TextData(message: "User"),
              Text(
                "INICIA SESIÓN",
                style: TextStyle(
                    fontSize: 25.00, color: ColorNeutral.neutralWhite),
              ),
              verticalSpace40,
              InputField(
                focusNode: usernameFocus,
                textController: userName,
                label: "Correo",
                icons:
                    const Icon(Icons.person, color: ColorNeutral.neutralWhite),
                isPassword: false,
              ),
              verticalSpace24,
              InputField(
                focusNode: passwordFocus,
                textController: password,
                label: "Contraseña",
                icons: const Icon(Icons.lock, color: ColorNeutral.neutralWhite),
                isPassword: true,
              ),
              verticalSpace40,
              LoginButton(
                focusNode: loginBtnFocus,
                userName: userName,
                password: password,
              ),
              InkWell(
                child: Text(
                  "Si no tienes cuenta, haz click AQUÍ",
                  style: labels.copyWith(color: ColorNeutral.neutralWhite),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/registration');
                  print("SE QUIERE REGISTRAR");
                },
              ),
              verticalSpace24,
              ImageBuilder(imagePath: AssetsManager.logoCitiaps),
              //const SocialSignIn(),
            ],
          ),
        ),
      );

  ScaffoldFeatureController buildErrorLayout(String? error) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error no controlado'),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
