

import 'package:dio_api_call/Models/Products.dart';
import 'package:flutter/material.dart';


class FeatureItems extends StatelessWidget {

  final Products products;


  const FeatureItems({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: (){
          //print(todo.id);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          Icons.account_balance_sharp,
          color: Colors.green,
        ),
        title: Text(
          products.name!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // trailing: Container(
        //   height: 35,
        //   width: 35,
        //   decoration: BoxDecoration(
        //     color: Colors.red,
        //     borderRadius: BorderRadius.circular(7),
        //   ),
        //   child: IconButton(
        //     color: Colors.white,
        //     icon: Icon(Icons.delete),
        //     iconSize: 18,
        //     onPressed: (){
        //       print("Deleted id => ${todo.id}");
        //       onDelete(todo.id.toString());
        //     },
        //   ),
        // ),

      ),
    );
  }
}
