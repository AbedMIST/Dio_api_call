

import 'dart:async';

import 'package:dio_api_call/Models/Products.dart';


class FeatureController{  //Update UI using StreamBuilder

  final List<Products> featureList = [
    // Products(name: "Abed", desc: "this is description", price: 12.00),
    // Products(name: "Macbook", desc: "this is .....", price: 26.00),
  ];
  final StreamController<List<Products>> _streamController = StreamController<List<Products>>();

  StreamSink<List<Products>> get featureSink => _streamController.sink;

  Stream<List<Products>> get featureStream => _streamController.stream;

  FeatureController(){
    featureSink.add(featureList);
  }

  addItem(Products newItem){

    featureList.add(newItem);
    featureSink.add(featureList);  //always observe the list
  }


}