import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../bloc/messages_bloc.dart';
import '../widgets/chat_list.dart';
import '../widgets/message_composer.dart';

class ChatScreen extends StatelessWidget {
  final String serviceId;
  const ChatScreen({Key? key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //appBar: chatAppBarWidget(context),
      /* appBar: CustomAppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
          },
        ),
        title: Text("Chat"),
        centerTitle: true,
        customBack: () {
          /* print("GOLA");
          Navigator.of(context).pop();
          Navigator.of(context).pop(); */
        },
      ), */
      appBar: AppBar(
        backgroundColor: ColorPrimary.primaryColor,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
          },
        ),
        title: Text("Chat"),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.update),
            onTap: () {
              print("SE ACTUALIZA CHAT");
              BlocProvider.of<MessagesBloc>(context)
                ..add(GetMessages(serviceId: serviceId));
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
                  child: ChatList(),
                ),
              ),
            ),
            MessageComposer(
              serviceId: serviceId,
            ),
          ],
        ),
      ),
    );
  }
}
