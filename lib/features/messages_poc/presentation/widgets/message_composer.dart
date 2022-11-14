import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../bloc/messages_bloc.dart';

class MessageComposer extends StatefulWidget {
  /* final String serviceId;

  const MessageComposer({Key? key, required this.serviceId}) : super(key: key); */
  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  var _msgcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _msgcontroller,
              onSubmitted: (String text) {
                print("se quiere enviar un mensaje");
                //_sendMessage();
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar Mensaje...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print("se quiere enviar un mensaje");

              /* BlocConsumer

              print(context.read<MessagesBloc>().state); */
              BlocProvider.of<MessagesBloc>(context)
                ..add(GetMessages(serviceId: "623a07ba2df2cf35b733ba0d"));
              //_sendMessage();
            },
          ),
        ],
      ),
    );
  }

  /* void _sendMessage() async {
    String msgAux = _msgcontroller.text;
    _msgcontroller.text = "";
    final chatData = Provider.of<ChatMessages>(context, listen: false);
    if (msgAux.isEmpty) return;

    String session = await storage.read(key: "session");

    final f = new DateFormat('dd-MM-yyyy hh:mm');
    var message = Message(
        sender: -1, text: msgAux, time: f.format(DateTime.now()));
    chatData.addChatMessage(message);

    await http.post("$API_SERVER/conversation/message-in",
        body: {"content": msgAux, "session": session});

    
  } */
}
