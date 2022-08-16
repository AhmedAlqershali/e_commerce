import 'package:e_commerce/utils/extension.dart';
import 'package:flutter/cupertino.dart';

class ProductsModel {
  late String   name, image, info, salary, sized;
  late Color color;


  late String path;


  ProductsModel();

  ProductsModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    image = map['image'];
    info = map['info'];
    salary = map['salary'];
    sized = map['sized'];

    color = HexColor.fromHex(map['color']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['info'] = info;
    map['salary'] = salary;
    map['sized'] = sized;
    map['color'] = color;


    return map;
  }
}
