import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/fetcher/services/fetcher_bookmark_services.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_content_data_model.dart';


class FetcherDataContentBookmarkButton extends StatefulWidget {
  FetcherContentDataModel contentData;
  FetcherDataContentBookmarkButton({super.key, required this.contentData});

  @override
  State<FetcherDataContentBookmarkButton> createState() =>
      _FetcherDataContentBookmarkButtonState();
}

class _FetcherDataContentBookmarkButtonState
    extends State<FetcherDataContentBookmarkButton> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool isLoading = false;
  bool isExists = false;

  void init() async {
    setState(() {
      isLoading = true;
    });
    isExists = await FetcherBookmarkServices.isExists(widget.contentData);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _toggle() async {
    setState(() {
      isLoading = true;
    });
    if (isExists) {
      await FetcherBookmarkServices.remove(widget.contentData);
    } else {
      await FetcherBookmarkServices.add(widget.contentData);
    }
    isExists = !isExists;
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return TLoader(size: 20);
    }
    return IconButton(
      color: isExists ? Colors.red : Colors.green,
      onPressed: _toggle,
      icon: Icon(isExists ? Icons.bookmark_remove : Icons.bookmark_add),
    );
  }
}
