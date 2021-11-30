class CategoryModel {
  int? id;
  late String name;
  late String description;

  categoryMapping() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    return mapping;
  }
}
