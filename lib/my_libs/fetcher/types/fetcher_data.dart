import 'package:than_scraper/my_libs/fetcher/types/fetcher_data_types.dart';

class FetcherData {
  String content;
  FetcherDataTypes type;
  String forwardProxy;
  FetcherData({
    required this.content,
    this.forwardProxy = '',
    this.type = FetcherDataTypes.text,
  });

  factory FetcherData.fromMap(Map<String, dynamic> map) {
    final type = FetcherDataTypes.getType(map['type']);
    return FetcherData(
      content: map['content'],
      type: type,
      forwardProxy: map['forwardProxy'],
    );
  }

  Map<String, dynamic> get toMap => {
        'content': content,
        'type': type.name,
        'forwardProxy': forwardProxy,
      };
}
