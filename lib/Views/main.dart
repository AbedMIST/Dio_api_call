import 'package:dio_api_call/Networking/APICaller.dart';
import 'package:dio_api_call/Views/FeatureItems.dart';
import 'package:dio_api_call/Models/FeatureResponseModel.dart';
import 'package:dio_api_call/Models/Products.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../Controllers/Controller.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter DIO API_Call'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final FeatureController controller;

  @override
  void initState() {

    controller = FeatureController();
    APICaller(controller: controller).getReq();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            StreamBuilder(                         //second stream builder
              stream: controller.featureStream,    // listen to your stream
              builder: (BuildContext context,snapshot) {

                if (snapshot.hasData) {  // Stream has emitted data
                  var values = snapshot.data!;
                  // Build your UI based on the data
                  return Column(
                    children: values.map((e) => FeatureItems(
                      products: e,
                    ),
                    ).toList(),

                  ); //Update UI

                }
                else if (snapshot.hasError) {  // Stream has encountered an error
                  return Text('Error: ${snapshot.error}');
                }
                else {      // Stream is still loading
                  return const SizedBox.shrink();
                }
              },
            ),

            // Text(
            //   '$txt',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   //onPressed: _incrementCounter,
      //   onPressed: getReq,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
