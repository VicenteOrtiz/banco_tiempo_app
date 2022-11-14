import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_list.dart';
import '../widgets/message_composer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //appBar: chatAppBarWidget(context),
      appBar: CustomAppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            print("ALGO PASA CON LAS NOTIFICACIONES");
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
            MessageComposer(),
          ],
        ),
      ),
    );
  }
}
