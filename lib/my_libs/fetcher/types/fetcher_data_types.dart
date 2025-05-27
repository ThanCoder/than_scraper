enum FetcherDataTypes {
  text,
  image,
  html,
  dynamicTitleCoverUrl,
  dynamicTitle;

  static FetcherDataTypes getType(String typeName) {
    return FetcherDataTypes.values.firstWhere(
      (type) => type.name == typeName,
      orElse: () => text,
    );
  }
}
