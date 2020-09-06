import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trader Tools',
      theme: ThemeData(
        // Toolbar color
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Trader Tools'),
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

class _MyHomePageState extends State<MyHomePage> {
  // static value
  Color activeColor = Color.fromARGB(1, 240, 185, 9);
  Color mainColor = Color.fromARGB(1, 30, 34, 38);

  // api value
  String pairValue = "BTC/USDT";
  double currentPrice = 11000;

  // master value
  double maxPositionAmount = 20;
  int stopLossRation = 20;

  // base value
  bool isLong = true;
  int margin = 20;
  double entryPrice = 0, exitPrice = 0;

  // calculate value
  double pnlPricePercent = 0, quantity = 0, roePrice = 0, roePricePercent = 0;

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
        // leading: GestureDetector(
        //   onTap: () {
        //       Navigator.pop(context);
        //   },
        //   child: Icon(
        //     Icons.menu,  // add custom icons also
        //   ),
        // ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          children: <Widget>[
            Row(children: [
              Expanded(
                child: DropdownButton<String>(
                    value: pairValue,
                    onChanged: (String newValue) {
                      setState(() {
                        pairValue = newValue;
                      });
                    },
                    items: <String>['BTC/USDT', 'ETH/USDT', 'ADA/USDT']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()), // pair value
              ),
              Expanded(
                child: Text(this.currentPrice.toString()),
              ),
              Expanded(
                child: Text("Margin"),
              ),
              Expanded(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = this.margin.toString(),
                      onChanged: (text) => {
                            this.setState(() {
                              this.margin = int.parse(text);
                            })
                          }))
            ]), // general info
            Row(children: [
              Expanded(
                  child: RaisedButton(
                      child: new Text("LONG"),
                      color: this.mainColor,
                      disabledColor: this.activeColor,
                      onPressed: this.isLong
                          ? null
                          : () {
                              setState(() {
                                isLong = true;
                              });
                            })),
              Expanded(
                  child: RaisedButton(
                      child: new Text("SHORT"),
                      color: this.mainColor,
                      disabledColor: this.activeColor,
                      onPressed: !this.isLong
                          ? null
                          : () {
                              setState(() {
                                isLong = false;
                              });
                            }))
            ]), // mode
            Row(children: [
              Expanded(
                child: Text("Amount"),
              ),
              Expanded(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = this.maxPositionAmount.toString(),
                      onChanged: (text) => {
                            this.setState(() {
                              this.maxPositionAmount = double.parse(text);
                            })
                          })),
              Expanded(
                child: Text("SL Ratio"),
              ),
              Expanded(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = this.stopLossRation.toString(),
                      onChanged: (text) => {
                            this.setState(() {
                              this.stopLossRation = int.parse(text);
                            })
                          }))
            ]),
            Row(children: [
              Expanded(
                child: Text("Entry Price"),
              ),
              Expanded(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = this.entryPrice.toString(),
                      onChanged: (text) => {
                            this.setState(() {
                              this.entryPrice = double.parse(text);
                            })
                          })),
              Expanded(
                child: Text("Exit Price"),
              ),
              Expanded(
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = this.exitPrice.toString(),
                      onChanged: (text) => {
                            this.setState(() {
                              this.exitPrice = double.parse(text);
                            })
                          }))
            ]),
            Expanded(
                child: Text(
              this.pnlPricePercent.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            Expanded(
                child: Text(
              this.quantity.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            Expanded(
                child: Text(
              "ROE",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            Row(
              children: [
                Expanded(
                    child: Text(
                  this.roePrice.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Expanded(
                    child: Text(
                  this.roePricePercent.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            Row(children: [
              Expanded(child:
                FlatButton(
                child: new Text("CALCULATE"),
                onPressed: (null),
              )),
              Expanded(child:
                FlatButton(
                child: new Text("PUBLISH"),
                onPressed: (null),
              ))
            ],)
          ],
        ),
      ),
    );
  }
}
