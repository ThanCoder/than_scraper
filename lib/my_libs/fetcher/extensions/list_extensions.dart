import '../types/page_query.dart';

extension ListExtensions on List<PageQuery> {
  void sortNewestDate() {
    sort((a, b) {
      if (a.date > b.date) return -1;
      if (a.date < b.date) return 1;
      return 0;
    });
  }
}
