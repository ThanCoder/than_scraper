enum FetcherQueryAttrTypes {
  text,
  attr;

  static FetcherQueryAttrTypes getType(String typeName) {
    return FetcherQueryAttrTypes.values.firstWhere(
      (type) => type.name == typeName,
      orElse: () => text,
    );
  }
}
