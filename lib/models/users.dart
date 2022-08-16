class Users {
  late String name;
  late String email;
  late String path;

  Users();

  Users.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;

    return map;
  }
}
