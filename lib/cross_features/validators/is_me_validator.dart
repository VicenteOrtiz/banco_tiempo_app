import '../authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isMe(BuildContext context, String userId) {
  var localUserId = context.read<AuthenticationBloc>().state.id;

  print(localUserId);

  return userId == localUserId;
}
