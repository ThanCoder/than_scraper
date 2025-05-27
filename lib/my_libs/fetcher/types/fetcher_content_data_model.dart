

import '../services/map_services.dart';
import 'fetcher_data.dart';

class FetcherContentDataModel {
  String id;
  String title;
  String url;
  String coverUrl;
  List<FetcherData> list;
  int date;
  FetcherContentDataModel({
    required this.id,
    required this.title,
    required this.url,
    required this.coverUrl,
    required this.list,
    required this.date,
  });

  factory FetcherContentDataModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> mapList = map['list'] ?? [];
    final list = mapList.map((map) => FetcherData.fromMap(map)).toList();

    return FetcherContentDataModel(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      coverUrl: MapServices.get<String>(map, ['coverUrl'], defaultValue: ''),
      list: list,
      date: map['date'],
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'url': url,
        'coverUrl': coverUrl,
        'list': list.map((fd) => fd.toMap).toList(),
        'date': date,
      };

  @override
  String toString() {
    return title;
  }
}
