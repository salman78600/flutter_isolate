import 'dart:isolate';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 500,
                  height: 500,
                  child: Image.asset("assets/gif/ball.gif")),

              // once you click on the task 1 button, the heavy calculations will be done in the background and UI will be blocked
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ThemeData.dark().colorScheme.inversePrimary,
                      ),
                      onPressed: () async {
                        var total = await task1();
                        debugPrint(total.toString());
                      },
                      child: Text(
                        "Task 1",
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),

              // once you click on the task 2 button, the heavy calculations will be done in the background and UI will not be blocked due to
              // the use of Isolate.
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ThemeData.dark().colorScheme.inversePrimary,
                      ),
                      onPressed: () async {
                        final receivePort = ReceivePort();
                        await Isolate.spawn(task2, receivePort.sendPort);
                        receivePort.listen((total) {
                          debugPrint(total.toString());
                        });
                      },
                      child: Text(
                        "Task 2",
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // heavy calculations
  Future<double> task1() async {
    double result = 0.0;
    for (var i = 0; i < 1000000000; i++) {
      // do nothing
      result += i;
    }
    return result;
  }
}

task2(SendPort sendPort) {
  double total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    // do nothing
    total += i;
  }
  sendPort.send(total);
}
