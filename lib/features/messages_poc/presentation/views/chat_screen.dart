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
        title: Text("Chat"),
        centerTitle: true,
        //customBack: () => Navigator.of(context).pop(true),
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
