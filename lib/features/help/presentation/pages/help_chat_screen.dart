import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../../messages_poc/presentation/bloc/messages_bloc.dart';
import '../widgets/help_chat_list.dart';
import '../widgets/help_message_composer.dart';

class HelpChatScreen extends StatelessWidget {
  const HelpChatScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPrimary.primaryColor,
        /* leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
          },
        ), */
        title: Text("Chat"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.update),
            onTap: () {
              print("SE ACTUALIZA CHAT");
              BlocProvider.of<MessagesBloc>(context)..add(GetHelpMessages());
            },
          ),
          horizontalSpace10
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            /* SizedBox(
              height: 30.0,
            ), */
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  /* borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ), */
                ),
                child: ClipRRect(
                  /* borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ), */
                  child: HelpChatList(),
                ),
              ),
            ),
            HelpMessageComposer(),
          ],
        ),
      ),
    );
  }
}
