import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final String nickname;
  Chat(this.nickname);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controllerMsg = TextEditingController();

  String formatarData(Timestamp timestamp) {
    var data = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

    if (DateTime.now().difference(data).inDays == 0)
      return DateFormat.Hm('pt_BR').format(data);
    else if (data.year == DateTime.now().year)
      return DateFormat.MMMd('pt_BR').format(data);
    else
      return DateFormat.yMd('pt_BR').format(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection('mensagens').orderBy('data', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data.documents[index].data;

                        return ListTile(
                          leading: Icon(Icons.account_circle, color: Colors.lightBlue, size: 42),
                          title: Text(data['usuario']),
                          subtitle: Text(data['texto'], style: TextStyle(color: Color(0xFF808080))),
                          trailing: Text(formatarData(data['data'])),
                        );
                      },
                    );
                }
              },
            ),
          ),
          Divider(height: 1, color: Color(0xFF808080)),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _controllerMsg,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Enviar uma mensagem',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: () async {
                  Firestore.instance.collection('mensagens').document().setData({
                    'usuario': widget.nickname,
                    'texto': _controllerMsg.text,
                    'data': DateTime.now(),
                  });
                  _controllerMsg.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
