import 'package:than_scraper/my_libs/fetcher/services/fetcher_query_services.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data_types.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_page_data.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query.dart';


import 'dio_services.dart';
import '../types/fetcher_query.dart';
import 'html_dom_services.dart';

class FetcherServices {
  static Future<FetcherServicePageResponse> getPageList(
    String url, {
    required PageQuery pageQuery,
    String forwardProxy = '',
  }) async {
    if (forwardProxy.isNotEmpty) {
      url = '$forwardProxy?url=$url';
    }
    final res = await DioServices.instance.getDio.get(url);
    final html = res.data.toString();
    List<FetcherPageData> list = [];

    for (var ele in HtmlDomServices.getHtmlDom(html)
        .querySelectorAll(pageQuery.mainLoopQuery.query)) {
      final title = FetcherQueryServices.getQuery(ele, pageQuery.titleQuery);
      final url = FetcherQueryServices.getQuery(
        ele,
        pageQuery.urlQuery,
        forwardProxy: forwardProxy,
      );
      final coverUrl = FetcherQueryServices.getQuery(
        ele,
        pageQuery.coverUrlQuery,
        forwardProxy: forwardProxy,
      );
      if (pageQuery.titleQuery.isNotEmptyAble && title.isEmpty) {
        continue;
      }
      if (pageQuery.coverUrlQuery.isNotEmptyAble && coverUrl.isEmpty) {
        continue;
      }
      if (pageQuery.urlQuery.isNotEmptyAble && url.isEmpty) {
        continue;
      }

      list.add(
        FetcherPageData(
          title: title,
          url: url,
          coverUrl: coverUrl,
        ),
      );
    }
    return FetcherServicePageResponse(
      list: list,
      nextUrl: getNextUrl(
        html,
        pageQuery.nextUrlQuery,
        forwardProxy: forwardProxy,
      ),
    );
  }

  static String getNextUrl(
    String html,
    FetcherQuery query, {
    String forwardProxy = '',
  }) {
    final ele = HtmlDomServices.getHtmlEle(html);
    if (ele == null) return '';
    final res =
        FetcherQueryServices.getQuery(ele, query, forwardProxy: forwardProxy);
    return res;
  }

  static Future<List<FetcherData>> getContentList(
    String url, {
    required FetcherPageData pageData,
    required List<FetcherQuery> queryList,
    String forwardProxy = '',
  }) async {
    List<FetcherData> list = [];
    if (forwardProxy.isNotEmpty) {
      url = '$forwardProxy?url=$url';
    }
    final res = await DioServices.instance.getDio.get(url);
    final html = res.data.toString();
    final ele = HtmlDomServices.getHtmlEle(html);
    for (var query in queryList) {
      if (query.dataType == FetcherDataTypes.dynamicTitleCoverUrl) {
        list.add(
          FetcherData(
            content: pageData.coverUrl,
            type: FetcherDataTypes.image,
            forwardProxy: forwardProxy,
          ),
        );
        continue;
      }
      if (query.dataType == FetcherDataTypes.dynamicTitle) {
        list.add(
          FetcherData(
            content: pageData.title,
            type: FetcherDataTypes.text,
          ),
        );
        continue;
      }
      // skip
      list.add(
        FetcherData(
          content: FetcherQueryServices.getQuery(
            ele,
            query,
            forwardProxy: forwardProxy,
          ),
          type: query.dataType,
          forwardProxy: forwardProxy,
        ),
      );
    }
    return list;
  }
}

class FetcherServicePageResponse {
  List<FetcherPageData> list;
  String nextUrl;
  FetcherServicePageResponse({
    required this.list,
    required this.nextUrl,
  });
}
