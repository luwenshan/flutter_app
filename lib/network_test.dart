import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/// 使用WebSocket

class WebSocketRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WebSocketRouteState();
  }
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    super.initState();
    channel = new IOWebSocketChannel.connect("ws://echo.websocket.org");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("WebSocket(内容回显)"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Send a message"),
              ),
            ),
            new StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot){
                if(snapshot.hasError){
                  _text = "网络不通";
                } else if(snapshot.hasData){
                  _text = "echo:${snapshot.data}";
                }
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "Send message",
        child: new Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }
}
