class CategoryModel{
  late String name,image;

  CategoryModel(this.name, this.image);


  CategoryModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    image = map['image'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = image;

    return map;
  }
}