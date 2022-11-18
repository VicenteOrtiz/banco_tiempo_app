import 'dart:async';

import 'package:banco_tiempo_app/cross_features/validators/is_me_validator.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/bloc/messages_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../messages_poc/domain/message_entity.dart';

/* import 'package:app_admision/src/providers/chat_messages.dart';
import 'package:app_admision/src/models/message.dart';
import 'package:url_launcher/url_launcher.dart';
 */

class HelpChatList extends StatefulWidget {
  @override
  _HelpChatListState createState() => _HelpChatListState();
}

class _HelpChatListState extends State<HelpChatList> {
  late NavigatorState _navigator;
  late BuildContext _context;
  //late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //final chatData = Provider.of<ChatMessages>(context);
    //final chatMessages = chatData.chats;

    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: ((context, state) {
        if (state is HelpMessagesLoaded) {
          /* timer = Timer.periodic(Duration(seconds: 5), (timer) {
            BlocProvider.of<MessagesBloc>(context)
              ..add(GetMessages(serviceId: state.messages.transaccion.id));
            print("Gik");
          }); */
          return ListView.builder(
              reverse: true,
              padding: EdgeInsets.only(top: 15.0),
              itemCount: state.messages.mensajesAyuda.length,
              itemBuilder: (BuildContext context, int index) {
                final mensaje = state.messages.mensajesAyuda[index];
                final Message message = Message(
                    authorName:
                        mensaje.autor.name + " " + mensaje.autor.lastName,
                    sender: 0,
                    time: mensaje.fecha.toString(),
                    text: mensaje.texto);
                //final bool isMe = message.sender == -1;
                //final bool isMe = ;
                print(message.text);
                return _buildMessage(message, isMe(context, mensaje.autor.id));
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );

    /* return ListView.builder(
        reverse: true,
        padding: EdgeInsets.only(top: 15.0),
        itemCount: chatMessages.length,
        itemBuilder: (BuildContext context, int index) {
          final Message message = chatMessages[index];
          final bool isMe = message.sender == -1;
          print(message.text);
          return _buildMessage(message, isMe);
        }); */
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 40.0,
            )
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: !isMe
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColorDark,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment:
            !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            message.authorName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          (message.text.split('https').length == 1)
              ? Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              :
              //Text("https" + message.text.split('https')[1].split(" ")[0]),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Te recomendamos revisar esta ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'información. ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          //_urlLauncher("https" + message.text.split('https')[1].split(" ")[0]);
                        },
                    ),
                    TextSpan(
                      text:
                          'Si no responde a tu pregunta, puedes hablar con nuestros/as monitores/as USACH, a continuación.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                )
        ],
      ),
    );

    return msg;
  }
}

/* _urlLauncher(String urlBase) async {
  print('URL LAUNCHER: ');
  print(urlBase);
  print(urlBase.split('"'));
  var url = urlBase.split('"')[0];
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
} */

chatTimer(Timer timer) {
  Timer.periodic(Duration(seconds: 5), (timer) {
    print("HOLA");
  });
}
