

class CartProductsModel {
  late String total,name, image,  salary;


  late String path;

  CartProductsModel();

  CartProductsModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    image = map['image'];
    salary = map['salary'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['salary'] = salary;

    return map;
  }
}
