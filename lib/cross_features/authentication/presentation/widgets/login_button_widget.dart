import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../bloc/authentication_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
      required this.focusNode,
      required this.userName,
      required this.password})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kHPadding,
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: ColorNeutral.neutralWhite, width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor: Colors.blue[50]),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(Login(userName.text, password.text));
        },
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorPrimary.primaryColor),
        ),
      ),
    );
  }
}
