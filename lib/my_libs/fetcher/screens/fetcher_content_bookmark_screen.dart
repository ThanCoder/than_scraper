import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/fetcher/components/fetcher_content_data_grid_item.dart';
import 'package:than_scraper/my_libs/fetcher/services/fetcher_bookmark_services.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_content_data_model.dart';
import 'fetcher_content_screen.dart';

class FetcherContentBookmarkScreen extends StatefulWidget {
  const FetcherContentBookmarkScreen({super.key});

  @override
  State<FetcherContentBookmarkScreen> createState() =>
      _FetcherContentBookmarkScreenState();
}

class _FetcherContentBookmarkScreenState
    extends State<FetcherContentBookmarkScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool isLoading = false;
  List<FetcherContentDataModel> list = [];

  void init() async {
    setState(() {
      isLoading = true;
    });

    list = await FetcherBookmarkServices.getList();

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _goContent(FetcherContentDataModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FetcherContentScreen(
            //gen id
            contentData: data),
      ),
    );
  }

  void _remove(FetcherContentDataModel data) async {
    await FetcherBookmarkServices.remove(data);
    list = list.where((e) => e.title != data.title).toList();
    setState(() {});
  }

  void _showMenu(FetcherContentDataModel data) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 150),
          child: Column(
            children: [
              ListTile(
                iconColor: Colors.red,
                leading: Icon(Icons.delete_forever),
                title: Text('Remove'),
                onTap: () {
                  Navigator.pop(context);
                  _remove(data);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Mark'),
      ),
      body: isLoading
          ? TLoader()
          : GridView.builder(
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                mainAxisExtent: 220,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final data = list[index];

                return GestureDetector(
                  onLongPress: () => _showMenu(data),
                  onSecondaryTap: () => _showMenu(data),
                  child: FetcherContentDataGridItem(
                    data: data,
                    onClicked: _goContent,
                  ),
                );
              },
            ),
    );
  }
}
