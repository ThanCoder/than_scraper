import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data.dart';

import '../services/fetcher_services.dart';
import '../types/fetcher_page_data.dart';
import '../types/fetcher_query.dart';

class FetcherDataContentLoaderDialog extends StatefulWidget {
  String url;
  String forwardProxy = '';
  FetcherPageData pageData;
  List<FetcherQuery> queryList;
  void Function(List<FetcherData> list) onLoaded;
  void Function(String msg) onError;
  FetcherDataContentLoaderDialog({
    super.key,
    required this.url,
    required this.pageData,
    required this.queryList,
    required this.onLoaded,
    required this.onError,
    this.forwardProxy = '',
  });

  @override
  State<FetcherDataContentLoaderDialog> createState() =>
      _FetcherDataContentLoaderDialogState();
}

class _FetcherDataContentLoaderDialogState
    extends State<FetcherDataContentLoaderDialog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      final list = await FetcherServices.getContentList(
        widget.url,
        pageData: widget.pageData,
        queryList: widget.queryList,
        forwardProxy: widget.forwardProxy,
      );
      if (!mounted) return;
      Navigator.pop(context);
      widget.onLoaded(list);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      widget.onError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        children: [
          TLoader(),
          Text('Please Wait...'),
        ],
      ),
    );
  }
}
