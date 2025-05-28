import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/app/screens/home/home_drawer.dart';
import 'package:than_scraper/my_libs/fetcher/notifiers/fetcher_config_services_notifier.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {
    context.read<FetcherConfigServicesNotifier>().initList();
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

  void _showMenu(PageQuery query, {bool isBuildinList = false}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100),
          child: Column(
            children: [
              isBuildinList
                  ? SizedBox.shrink()
                  : ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FetcherContentForm(
                              pageQuery: query,
                              onResult: (pageQuery) {
                                final provider = context
                                    .read<FetcherConfigServicesNotifier>();
                                provider.update(pageQuery);
                              },
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
                        onResult: (pageQuery) {
                          final provider =
                              context.read<FetcherConfigServicesNotifier>();
                          provider.add(pageQuery);
                        },
                      ),
                    ),
                  );
                },
              ),
              // delete
              isBuildinList
                  ? SizedBox.shrink()
                  : ListTile(
                      iconColor: Colors.red,
                      leading: Icon(Icons.delete_forever),
                      title: Text('Delete'),
                      onTap: () {
                        Navigator.pop(context);
                        final provider =
                            context.read<FetcherConfigServicesNotifier>();
                        provider.delete(query);
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
    final buildInList = FetcherConfigServices.getBuildInList();
    final provider = context.watch<FetcherConfigServicesNotifier>();
    final isLoading = provider.isLoading;
    final customList = provider.getList;

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
        child: RefreshIndicator.adaptive(
          onRefresh: init,
          child: CustomScrollView(
            slivers: [
              // build in
              SliverToBoxAdapter(
                child: Text(
                  'BuildIn List',
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
              SliverList.builder(
                itemCount: buildInList.length,
                itemBuilder: (context, index) {
                  final data = buildInList[index];
                  return GestureDetector(
                    onLongPress: () => _showMenu(data, isBuildinList: true),
                    onSecondaryTap: () => _showMenu(data, isBuildinList: true),
                    child: TListTileWithDesc(
                      title: data.title,
                      desc: data.desc,
                      onClick: () => _onClicked(data),
                    ),
                  );
                },
              ),
              // custom list
              SliverToBoxAdapter(child: const Divider()),

              SliverToBoxAdapter(
                child: Text(
                  'Custom List',
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
              SliverToBoxAdapter(
                  child: isLoading ? TLoader() : SizedBox.shrink()),
              SliverList.builder(
                itemCount: customList.length,
                itemBuilder: (context, index) {
                  final data = customList[index];
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FetcherContentForm(
                onResult: (pageQuery) {
                  final provider =
                      context.read<FetcherConfigServicesNotifier>();
                  provider.add(pageQuery);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
