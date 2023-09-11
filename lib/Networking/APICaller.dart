import 'dart:convert';

import 'package:dio/dio.dart';
import '../Controllers/Controller.dart';
import '../Models/FeatureResponseModel.dart';
import '../Models/Products.dart';
import '../Networking/exception_handlers.dart';

class APICaller {

  static const url = "https://test460.nop-station.com/api/home/featureproducts";
  var headers = {
    'DeviceId': '44b4d8cd-7a2d-4a5f-a0e2-798021f1e294',
    'Content-Type': 'application/json',
  };

  final FeatureController controller;

  APICaller({
    required this.controller,
  });



  Future<void> getReq() async {
    final Dio _dio = Dio();
    try{

      var response = await _dio.get(url , options: Options(headers: headers));

      print(response.statusCode);
      print(response.data);
      // print(response.data);



      Map<String, dynamic> jsonData = _processResponse(response);
      FeatureResponseModel myModel = FeatureResponseModel.fromJson(jsonData);

      print(myModel.data.length);
      for(var i=0;i<myModel.data.length;i++){
        print(myModel.data[i].name);
        controller.addItem(
            Products(name: myModel.data[i].name, desc: myModel.data[i].shortDescription,
                price: myModel.data[i].productPrice.priceValue)
        );
      }

    }
    catch(e){
      print(e);
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  //----------------------ERROR STATUS CODES----------------------

  dynamic _processResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.data)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.data)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.data)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.data)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }
}