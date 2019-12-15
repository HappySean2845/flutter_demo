import 'package:flutter/material.dart';
// import 'dart:async';
import 'counter_bloc.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new MyHomePage(title: "I'am Title"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState(CounterBloc());
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  final CounterBloc bloc;
  _MyHomePageState(this.bloc);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementCounterBloc(){
    bloc.increment(_counter);
  }
  
  @override
  void initState() {
    bloc.counter.listen((_returnedCount) {
      setState(() {
        _counter = _returnedCount;
      });
    });
    super.initState();
  }

  // @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                //导航到新路由
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RouterTestRoute();
                }));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounterBloc,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shawn's App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('images/diamond.png'),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("提示"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              // 打开`TipRoute`，并等待返回结果
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TipRoute(
                      // 路由参数
                      text: "我是提示xxxx",
                    );
                  },
                ),
              );
              //输出`TipRoute`路由返回结果
              print("路由返回值: $result");
            },
            child: Text("打开提示页"),
          ),
        ));
  }
}
