import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_list.dart';
import '../widgets/message_composer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        //appBar: chatAppBarWidget(context),
        appBar: CustomAppBar(),
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
      ),
    );
  }
}
