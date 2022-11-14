import 'package:banco_tiempo_app/features/messages_poc/infrastructure/messages_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../bloc/messages_bloc.dart';

class MessageComposer extends StatefulWidget {
  final String serviceId;

  const MessageComposer({Key? key, required this.serviceId}) : super(key: key);
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
            onPressed: () async {
              /* print("se quiere enviar un mensaje");

              await MessagesRepository()
                  .sendMessage(_msgcontroller.text, widget.serviceId);
              /* BlocConsumer
              
              print(context.read<MessagesBloc>().state); */
              BlocProvider.of<MessagesBloc>(context)
                ..add(GetMessages(serviceId: widget.serviceId)); */

              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    String msgAux = _msgcontroller.text;
    _msgcontroller.text = "";
    //final chatData = Provider.of<ChatMessages>(context, listen: false);
    if (msgAux.isEmpty) return;

    print("se quiere enviar un mensaje");

    await MessagesRepository().sendMessage(msgAux, widget.serviceId);
    /* BlocConsumer
              
              print(context.read<MessagesBloc>().state); */
    BlocProvider.of<MessagesBloc>(context)
      ..add(GetMessages(serviceId: widget.serviceId));
  }
}
