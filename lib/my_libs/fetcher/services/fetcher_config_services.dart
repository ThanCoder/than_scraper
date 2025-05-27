import 'package:than_scraper/my_libs/fetcher/types/fetcher_data_types.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_query_attr_types.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_query_selector_types.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query.dart';

import '../types/fetcher_query.dart';

class FetcherConfigServices {
  static Future<List<PageQuery>> getList() async {
    return [
      //Dr Mg Nyo [အပြာစာပေ]
      PageQuery(
        id: '1',
        title: 'Dr Mg Nyo [အပြာစာပေ]',
        url: 'https://drmgnyo.com',
        desc: 'အပြာစာများ စုစည်းမှု',
        date: 1745984096334,
        mainLoopQuery: FetcherQuery(query: '.clean-grid-grid-post'),
        nextUrlQuery: FetcherQuery(
          query: '.wp-pagenavi .nextpostslink',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        titleQuery: FetcherQuery(query: '.clean-grid-grid-post-title a'),
        urlQuery: FetcherQuery(
          query: '.clean-grid-grid-post-title a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.clean-grid-grid-post-thumbnail img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        contentQueryList: [
          // image
          FetcherQuery(
            query: '.clean-grid-post-thumbnail-single',
            attr: 'src',
            attrType: FetcherQueryAttrTypes.attr,
            dataType: FetcherDataTypes.image,
          ),
          // text
          FetcherQuery(
            query: '.entry-content',
          ),
        ],
      ),
      // cm movie
      PageQuery(
        id: '2',
        title: 'CM Movie',
        date: 1745984096334,
        forwardProxy: 'https://express-forward-proxy.vercel.app',
        url: 'https://www.channelmyanmar.to/movies',
        desc: 'Channel Myanmar Website',
        mainLoopQuery: FetcherQuery(
          query: '.box_item .items .item',
          isUsedForwardProxy: true,
        ),
        nextUrlQuery: FetcherQuery(
          query: '.respo_pag .pag_b a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        titleQuery: FetcherQuery(query: '.fixyear h2'),
        urlQuery: FetcherQuery(
          query: 'a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.image img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
          isUsedForwardProxy: true,
        ),
        contentQueryList: [
          FetcherQuery(
            query: '.imagen img',
            attr: 'src',
            attrType: FetcherQueryAttrTypes.attr,
            dataType: FetcherDataTypes.image,
            isUsedForwardProxy: true,
          ),
          FetcherQuery(
            query: '',
            dataType: FetcherDataTypes.dynamicTitle,
          ),
          FetcherQuery(
            // query: '.entry-content',
            query: '#cap1',
            dataType: FetcherDataTypes.html,
            isUsedForwardProxy: true,
          ),
          FetcherQuery(
            query: '.enlaces_box',
            dataType: FetcherDataTypes.html,
          ),
        ],
      ),
      //series
      PageQuery(
        id: '3',
        title: 'CM Series',
        date: 1745984096334,
        forwardProxy: 'https://express-forward-proxy.vercel.app',
        url: 'https://www.channelmyanmar.to/tvshows',
        desc: 'Channel Myanmar Website',
        mainLoopQuery: FetcherQuery(
          query: '.box_item .items .item',
          isUsedForwardProxy: true,
        ),
        nextUrlQuery: FetcherQuery(
          query: '.respo_pag .pag_b a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        titleQuery: FetcherQuery(query: '.fixyear h2'),
        urlQuery: FetcherQuery(
          query: 'a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.image img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
          isUsedForwardProxy: true,
        ),
        contentQueryList: [
          // FetcherQuery(
          //   query: '.',
          //   dataType: FetcherDataTypes.dynamicTitle,
          // ),
          FetcherQuery(
            query: '.contenidotv',
            dataType: FetcherDataTypes.html,
          ),
        ],
      ),
      //Green Way Myanmar
      PageQuery(
        id: '4',
        title: 'Green Way Myanmar ကျန်းမာရေး',
        date: 1745984096334,
        forwardProxy: 'https://express-forward-proxy.vercel.app',
        url:
            'https://greenwaymyanmar.com/categories/%E1%80%80%E1%80%BB%E1%80%94%E1%80%BA%E1%80%B8%E1%80%99%E1%80%AC%E1%80%9B%E1%80%B1%E1%80%B8',
        mainLoopQuery: FetcherQuery(
          query: '.container-fluid .col-md-3',
          isUsedForwardProxy: true,
        ),
        nextUrlQuery: FetcherQuery(
          query: '.pagination .page-link',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
          selectorTypes: FetcherQuerySelectorTypes.listLast,
        ),
        titleQuery: FetcherQuery(
          query: 'a > .card > .card-body > .card-title',
          isNotEmptyAble: true,
        ),
        urlQuery: FetcherQuery(
          query: 'a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.card img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
          isUsedForwardProxy: true,
        ),
        contentQueryList: [
          FetcherQuery(
            query: '.page-cover img',
            attr: 'src',
            attrType: FetcherQueryAttrTypes.attr,
            dataType: FetcherDataTypes.image,
          ),
          FetcherQuery(
            query: '',
            dataType: FetcherDataTypes.dynamicTitle,
          ),
          FetcherQuery(
            query: '.page-content',
            dataType: FetcherDataTypes.html,
          ),
        ],
      ),

      PageQuery(
        id: '5',
        title: 'Green Way Myanmar အထွေထွေ',
        date: 1745984096334,
        forwardProxy: 'https://express-forward-proxy.vercel.app',
        url:
            'https://greenwaymyanmar.com/categories/%E1%80%A1%E1%80%91%E1%80%BD%E1%80%B1%E1%80%91%E1%80%BD%E1%80%B1',
        mainLoopQuery: FetcherQuery(
          query: '.container-fluid .col-md-3',
          isUsedForwardProxy: true,
        ),
        nextUrlQuery: FetcherQuery(
          query: '.pagination .page-link',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
          selectorTypes: FetcherQuerySelectorTypes.listLast,
        ),
        titleQuery: FetcherQuery(
          query: 'a > .card > .card-body > .card-title',
          isNotEmptyAble: true,
        ),
        urlQuery: FetcherQuery(
          query: 'a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.card img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
          isUsedForwardProxy: true,
        ),
        contentQueryList: [
          FetcherQuery(
            query: '.page-cover img',
            attr: 'src',
            attrType: FetcherQueryAttrTypes.attr,
            dataType: FetcherDataTypes.image,
          ),
          FetcherQuery(
            query: '',
            dataType: FetcherDataTypes.dynamicTitle,
          ),
          FetcherQuery(
            query: '.page-content',
            dataType: FetcherDataTypes.html,
          ),
        ],
      ),

      PageQuery(
        id: '6',
        title: 'Green Way Myanmar မိုးလေဝသသတင်း',
        date: 1745984096334,
        forwardProxy: 'https://express-forward-proxy.vercel.app',
        url:
            'https://greenwaymyanmar.com/categories/%E1%80%99%E1%80%AD%E1%80%AF%E1%80%B8%E1%80%9C%E1%80%B1%E1%80%9D%E1%80%9E%E1%80%9E%E1%80%90%E1%80%84%E1%80%BA%E1%80%B8',
        mainLoopQuery: FetcherQuery(
          query: '.container-fluid .col-md-3',
          isUsedForwardProxy: true,
        ),
        nextUrlQuery: FetcherQuery(
          query: '.pagination .page-link',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
          selectorTypes: FetcherQuerySelectorTypes.listLast,
        ),
        titleQuery: FetcherQuery(
          query: 'a > .card > .card-body > .card-title',
          isNotEmptyAble: true,
        ),
        urlQuery: FetcherQuery(
          query: 'a',
          attr: 'href',
          attrType: FetcherQueryAttrTypes.attr,
        ),
        coverUrlQuery: FetcherQuery(
          query: '.card img',
          attr: 'src',
          attrType: FetcherQueryAttrTypes.attr,
          isUsedForwardProxy: true,
        ),
        contentQueryList: [
          FetcherQuery(
            query: '.page-cover img',
            attr: 'src',
            attrType: FetcherQueryAttrTypes.attr,
            dataType: FetcherDataTypes.image,
          ),
          FetcherQuery(
            query: '',
            dataType: FetcherDataTypes.dynamicTitle,
          ),
          FetcherQuery(
            query: '.page-content',
            dataType: FetcherDataTypes.html,
          ),
        ],
      ),
    ];
  }
}
