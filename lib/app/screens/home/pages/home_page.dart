import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/app/screens/home/home_drawer.dart';
import 'package:than_scraper/my_libs/fetcher/screens/forms/fetcher_content_form.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query.dart';
import '../../../../my_libs/fetcher/services/fetcher_config_services.dart';

import '../../../constants.dart';
import '../../../../my_libs/fetcher/screens/fetcher_home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  List<PageQuery> list = [];

  void init() async {
    list = await FetcherConfigServices.getList();
    setState(() {});
  }

  void _onClicked(PageQuery data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FetcherHomeScreen(
          pageQuery: data,
        ),
      ),
    );
  }

  void _showMenu(PageQuery query) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 150),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FetcherContentForm(
                        pageQuery: query,
                        onResult: (pageQuery) {},
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Create With this'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FetcherContentForm(
                        pageQuery: query,
                        onResult: (pageQuery) {},
                      ),
                    ),
                  );
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
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          // GeneralServerNotiButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final data = list[index];
                return GestureDetector(
                  onLongPress: () => _showMenu(data),
                  onSecondaryTap: () => _showMenu(data),
                  child: TListTileWithDesc(
                    title: data.title,
                    desc: data.desc,
                    onClick: () => _onClicked(data),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FetcherContentForm(
                onResult: (pageQuery) {},
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
