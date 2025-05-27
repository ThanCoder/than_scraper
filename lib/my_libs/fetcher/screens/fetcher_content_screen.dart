import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_scraper/my_libs/fetcher/components/fetcher_data_content_bookmark_button.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_content_data_model.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data_types.dart';
import 'package:than_scraper/my_libs/setting/app_services.dart';

import '../services/html_dom_services.dart';

class FetcherContentScreen extends StatefulWidget {
  FetcherContentDataModel contentData;
  FetcherContentScreen({
    super.key,
    required this.contentData,
  });

  @override
  State<FetcherContentScreen> createState() => _FetcherContentScreenState();
}

class _FetcherContentScreenState extends State<FetcherContentScreen> {
  bool isFullScreen = false;

  void _toggleFullScreen() {
    isFullScreen = !isFullScreen;
    ThanPkg.platform.toggleFullScreen(isFullScreen: isFullScreen);
    setState(() {});
  }

  Widget _getListItem(FetcherData data) {
    if (data.type == FetcherDataTypes.image) {
      return TCacheImage(url: data.content);
    }
    if (data.type == FetcherDataTypes.html) {
      var html = data.content;
      html = HtmlDomServices.cleanStyleTag(html);
      //  is use proxy
      if (data.forwardProxy.isNotEmpty) {
        final dom = HtmlDomServices.getHtmlDom(html);
        for (var img in dom.querySelectorAll('img')) {
          final src = img.attributes['src'];
          if (src == null) continue;
          img.attributes['src'] = '${data.forwardProxy}?url=$src';
          img.attributes['width'] = '100%';
          img.attributes.remove('height');
          // img.attributes['style'] = 'width:50%;'; // image width 100%
        }
        html = dom.outerHtml;
      }
      html =
          html.replaceAll('https://express-forward-proxy.vercel.app?url=', '');

      return Html(
        data: html,
        onLinkTap: (url, attributes, element) async {
          try {
            if (url == null) return;
            await ThanPkg.platform.launch(url);
          } catch (e) {
            if (!mounted) return;
            // TMessenger.instance.showDialogMessage(context, e.toString());
          }
        },
      );
    }

    return Text(
      data.content,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  void _onBackpress() {
    ThanPkg.platform.toggleFullScreen(isFullScreen: false);
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 150,
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.source_rounded),
                title: Text('Copy Source Url'),
                onTap: () {
                  Navigator.pop(context);
                  AppServices.copyText(widget.contentData.url);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        _onBackpress();
      },
      child: Scaffold(
        appBar: isFullScreen
            ? null
            : AppBar(
                title: Text(widget.contentData.title),
                actions: [
                  FetcherDataContentBookmarkButton(
                    contentData: widget.contentData,
                  ),
                  IconButton(
                    onPressed: _showMenu,
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
        body: GestureDetector(
          onDoubleTap: _toggleFullScreen,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: widget.contentData.list.length,
            itemBuilder: (context, index) {
              final data = widget.contentData.list[index];
              return _getListItem(data);
            },
          ),
        ),
      ),
    );
  }
}
