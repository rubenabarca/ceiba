import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCG Ruben',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Memory Card Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MemoryCard {
  int index;
  int targetNumber;
  bool isSelected = false;
  bool isCompleted = false;
  MemoryCard(this.index, this.targetNumber);
} //Se estableció el estado de MemoryCard en falso, tanto en isCompleted como en isSelected

class _MyHomePageState extends State<MyHomePage> {
  int cardCount = 20;
  List<int> list1 = List.generate(10, (index) => index);
  List<int> list2 = List.generate(10, (index) => index);
  List<MemoryCard> memoryCardList = List.empty();
  bool isGameCompleted =
      false; //Se establecieron dos listas, cada una con números del 1 al 10, y un total de cartas en lista de 20

  _MyHomePageState() {
    list1.shuffle();
    list2.shuffle();
    memoryCardList = List.generate(
      cardCount,
      (index) => MemoryCard(
          index, ((index < 10) ? (list1[index]) : list2[index - 10])),
    );
  } //Se generó que la lista establezca los valores a mostrar en la página con la memoryCardList sea Random

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: isGameCompleted
            ? Text("Felicidades, juego completado!",
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0)
                    .apply(color: Color.fromRGBO(0, 0, 128, 0.75)))
            //Todo lo referido a la estética del juego
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 79,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: cardCount,
                itemBuilder: (BuildContext context, index) {
                  //Todo lo referido al formato del juego
                  var randomNumber =
                      ((index < 10) ? (list1[index]) : list2[index - 10]);
                  return Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          {_memoryCardPressed(memoryCardList[index])},
                      child: memoryCardList[index].isSelected ||
                              memoryCardList[index].isCompleted
                          ? Text(randomNumber.toString(),
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 2.0)
                                  .apply(
                                      color: Color.fromRGBO(0, 0, 128, 0.75)))
                          : Image(
                              image: AssetImage('assets/images/card-back.png')),
                    ), //Formato de la memoryCard
                  );
                }),
      ),
    );
  }

  _memoryCardPressed(MemoryCard memoryCard) {
    setState(() {
      // Creando una nueva variable
      // usando el metodo where para filtrar la lista
      // y extrayendo los elementos seleccionados.
      // luego, creamos una copia y el resultado
      // lo asignamos a la nueva variable.
      var memoryCardSelectedElements =
          memoryCardList.where((memoryCard) => memoryCard.isSelected).toList();
      if (memoryCardSelectedElements.length == 2) {
        memoryCardSelectedElements[0].isSelected = false;
        memoryCardSelectedElements[1].isSelected = false;
      }
      memoryCard.isSelected = true;
      memoryCardSelectedElements =
          memoryCardList.where((memoryCard) => memoryCard.isSelected).toList();
      if (memoryCardSelectedElements.length == 2) {
        var firstNumber = memoryCardSelectedElements[0].targetNumber;
        var secondNumber = memoryCardSelectedElements[1].targetNumber;
        if (secondNumber == firstNumber) {
          memoryCardSelectedElements[0].isCompleted = true;
          memoryCardSelectedElements[1].isCompleted = true;
        }
      }
      var notCompletedCards = memoryCardList
          .where((memoryCard) => memoryCard.isCompleted == false)
          .toList();
      if (notCompletedCards.isEmpty) {
        isGameCompleted = true;
      }
    });
  }
}
