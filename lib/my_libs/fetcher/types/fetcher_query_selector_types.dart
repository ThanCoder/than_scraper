enum FetcherQuerySelectorTypes {
  single,
  listFirst,
  listLast;

  static FetcherQuerySelectorTypes getType(String typeName) {
    return FetcherQuerySelectorTypes.values.firstWhere(
      (type) => type.name == typeName,
      orElse: () => single,
    );
  }
}
