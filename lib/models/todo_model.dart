class TodoModel {
  int? id;
  late String title;
  late String description;
  late String category;
  late int isFilled;

  //TO MAP DATA
  mapping() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['isFilled'] = isFilled;
    return map;
  }
}
