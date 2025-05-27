// ignore_for_file: public_member_api_docs, sort_constructors_first
class FetcherPageData {
  String title;
  String url;
  String coverUrl;
  FetcherPageData({
    required this.title,
    required this.url,
    required this.coverUrl,
  });

  @override
  String toString() {
    return title;
  }
}
