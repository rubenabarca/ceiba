import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euler0001',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title:
              'Exercise: Euler0001-Find the sum of all multiples of three or five below one thousand'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Iterable<int> obtainMultiplesOf3Or5AndTheSum(int limit) sync* {
    int index = 3;
    int sum = 0;
    do {
      if (index % 3 == 0 || index % 5 == 0) {
        sum += index;
        yield index;
      }
      index++;
    } while (index < 1000);
    yield sum;
  }

  Iterable<Widget> generateTheListOfTextsFromMultiplesOf3Or5AndTheSum(
      int limit) sync* {
    for (var multiple in obtainMultiplesOf3Or5AndTheSum(limit)) {
      yield Text(multiple.toString());
    }
  }

  List<Widget> _textList = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: _textList.length,
              itemBuilder: (context, index) {
                return _textList[index];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _textList = List.from(
                generateTheListOfTextsFromMultiplesOf3Or5AndTheSum(1000));
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
