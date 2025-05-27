enum PageQueryTypes {
  grid,
  list;

  static PageQueryTypes getType(String typeName) {
    return PageQueryTypes.values.firstWhere(
      (type) => type.name == typeName,
      orElse: () => list,
    );
  }
}
