import 'package:ajiledakarv/services/apiService.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool choosing = false;
  int step = -1;
  int type = 0;
  int zone = 0;

  getMess(path) async {
    print(path);
    var response;
    List msg = [];

    await ApiService().getData(path).then((value) => {response = value});
    if (step < 2) {
      msg = response["data"];
      if (msg.length > 0) {
        setState(() {
          step = step + 1;
        });
      }
    }

    msg.forEach((e) {
      setState(() {
        messages.add(Message(
          text: step == 0
              ? e["type"]
              : (step == 1 ? e["zone_name"] : "${e["name"]}-${e["phone"]}"),
          isUser: false,
          id: e["id"],
        ));
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    setState(() {
      choosing = false;
    });
  }

  final List<Message> messages = [
    Message(
      text: 'Bonjour ! Comment puis-je vous aider ?',
      isUser: false,
      id: 0,
    ),
  ];

  final TextEditingController _textController = TextEditingController();

  void _sendMessage(String text) {
    /*  setState(() {
      _textController.clear();
      _messages.add(Message(
        text: 'Je suis un chatbot. Désolé, je ne sais pas comment vous aider pour cela.',
        isUser: false,
      ));
    });

      // simulate chatbot response after a short delay
      Future.delayed(Duration(seconds: 1), () {
        _messages.add(Message(text: text, isUser: true));
    });*/
  }
  userMessage(id, msg) async {
    var path = "";

    if (!choosing) {
      setState(() {
        messages.add(Message(
          text: msg,
          isUser: true,
          id: id,
        ));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      setState(() {
        choosing = true;
      });
      if (step == 0) {
        path = "centres/zone/list/${id}/";
        setState(() {
          type = id;
        });
      } else if (step == 1) {
        path = "places/search/${type}/${id}";
        setState(() {
          zone = id;
        });
      } else if (step == 2) {
        path = "places/show/${id}";
        setState(() {
          zone = id;
        });
      }

      await getMess(path);
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    getMess("centres/list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Retour',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (_, int index) => messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _sendMessage,
                decoration:
                    InputDecoration.collapsed(hintText: 'Envoyer un message'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _sendMessage(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final int id;
  final bool isUser;

  Message({required this.text, required this.isUser, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (!isUser) {
            print(id);
            ChatScreenState? state =
                context.findAncestorStateOfType<ChatScreenState>()!;
            state.userMessage(id, text);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft:
                          isUser ? Radius.circular(20.0) : Radius.circular(0.0),
                      bottomRight:
                          isUser ? Radius.circular(0.0) : Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (!isUser)
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/messager.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(text, style: TextStyle(fontSize: 16.0))
                    ],
                  )),
            ],
          ),
        ));
  }
}
