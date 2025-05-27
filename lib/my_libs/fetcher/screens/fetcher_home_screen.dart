import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/fetcher/components/fetcher_page_data_grid_item.dart';
import 'package:than_scraper/my_libs/fetcher/dialogs/fetcher_data_content_loader_dialog.dart';
import 'package:than_scraper/my_libs/fetcher/screens/fetcher_content_screen.dart';
import 'package:than_scraper/my_libs/fetcher/services/fetcher_services.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_content_data_model.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query.dart';
import 'package:than_scraper/my_libs/setting/t_messenger.dart';
import 'package:uuid/uuid.dart';
import '../types/fetcher_page_data.dart';

class FetcherHomeScreen extends StatefulWidget {
  PageQuery pageQuery;
  FetcherHomeScreen({
    super.key,
    required this.pageQuery,
  });

  @override
  State<FetcherHomeScreen> createState() => _FetcherHomeScreenState();
}

class _FetcherHomeScreenState extends State<FetcherHomeScreen> {
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
    init();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }

  List<FetcherPageData> list = [];
  String nextUrl = '';
  bool isLoading = false;
  bool isNextLoading = false;
  double lastScroll = 0;

  Future<void> init() async {
    try {
      setState(() {
        isLoading = true;
      });

      final res = await FetcherServices.getPageList(
        widget.pageQuery.url,
        pageQuery: widget.pageQuery,
        forwardProxy: widget.pageQuery.forwardProxy,
      );
      list = res.list;
      nextUrl = res.nextUrl;

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      // TMessenger.instance.showDialogMessage(context, e.toString());
    }
  }

  void _onScroll() {
    final pos = scrollController.position.pixels;
    final max = scrollController.position.maxScrollExtent;
    if (!isNextLoading && lastScroll != max && pos == max) {
      lastScroll = max;
      _loadPage();
    }
  }

  void _loadPage() async {
    try {
      if (nextUrl.isEmpty || nextUrl == '#') return;
      setState(() {
        isNextLoading = true;
      });

      final res = await FetcherServices.getPageList(
        nextUrl,
        pageQuery: widget.pageQuery,
        forwardProxy: widget.pageQuery.forwardProxy,
      );
      list.addAll(res.list);
      nextUrl = res.nextUrl;

      if (!mounted) return;
      setState(() {
        isNextLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isNextLoading = false;
      });
      TMessenger.instance.showDialogMessage(context, e.toString());
    }
  }

  void _goContent(FetcherPageData data) {
    if (widget.pageQuery.contentQueryList.isEmpty) {
      TMessenger.instance.showDialogMessage(context, '`Content Query List` မထည့်ရသေးပါ');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FetcherDataContentLoaderDialog(
        url: data.url,
        pageData: data,
        queryList: widget.pageQuery.contentQueryList,
        forwardProxy: widget.pageQuery.forwardProxy,
        onLoaded: (list) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FetcherContentScreen(
                //gen id
                contentData: FetcherContentDataModel(
                  id: Uuid().v4(),
                  title: data.title,
                  url: data.url,
                  coverUrl: data.coverUrl,
                  list: list,
                  date: DateTime.now().millisecondsSinceEpoch,
                ),
              ),
            ),
          );
        },
        onError: (msg) {
          TMessenger.instance.showDialogMessage(context, msg);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(list.first.coverUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageQuery.title),
      ),
      body: isLoading
          ? TLoader()
          : CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverGrid.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final data = list[index];

                    return FetcherPageDataGridItem(
                      data: data,
                      onClicked: _goContent,
                    );
                  },
                ),
                SliverToBoxAdapter(
                    child: isNextLoading ? TLoader() : SizedBox.shrink()),
              ],
            ),
    );
  }
}
