import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/state_lifecycle.dart';
import 'package:flutter_app/state_management.dart';
import 'package:flutter_app/listview.dart';
import 'package:flutter_app/file_test.dart';
import 'package:flutter_app/network_test.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Demo",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ), // 注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
      },
      home: new MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have pushed the button this many times:'),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) {
//                  return new NewRoute();
//                }));
              },
            ),
            RandomWordsWidget(),
            FlatButton(
                child: Text("State生命周期"),
                textColor: Colors.deepPurple,
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    return new CounterWidget(
                      initValue: 10,
                    );
                  }));
                }),
            FlatButton(
              child: Text("StatefulWidget状态管理"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new ParentWidgetC();
                }));
              },
            ),
            FlatButton(
              child: Text("列表"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new ScrollControllerTestRoute();
                }));
              },
            ),
            FlatButton(
              child: Text("文件操作"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                          return new FileOperationRoute();
                        }));
              },
            ),
            RaisedButton(
              child: Text("WebSocket"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                          return new WebSocketRoute();
                        }));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}
