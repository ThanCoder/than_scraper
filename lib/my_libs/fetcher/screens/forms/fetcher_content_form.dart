import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/t_text_field.dart';
import 'package:than_scraper/my_libs/fetcher/screens/forms/fetcher_query_form.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_query.dart';
import 'package:than_scraper/my_libs/fetcher/types/page_query.dart';

class FetcherContentForm extends StatefulWidget {
  PageQuery? pageQuery;
  void Function(PageQuery pageQuery) onResult;
  FetcherContentForm({
    super.key,
    this.pageQuery,
    required this.onResult,
  });

  @override
  State<FetcherContentForm> createState() => _FetcherContentFormState();
}

class _FetcherContentFormState extends State<FetcherContentForm> {
  final titleController = TextEditingController();
  final urlController = TextEditingController();
  final descController = TextEditingController();

  late PageQuery page;

  @override
  void initState() {
    if (widget.pageQuery == null) {
      page = PageQuery.create();
    } else {
      page = widget.pageQuery!;
    }
    super.initState();
    init();
  }

  void init() {
    titleController.text = page.title;
    urlController.text = page.url;
    descController.text = page.desc;
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _save() {
    page.title = titleController.text;
    page.url = urlController.text;
    page.desc = descController.text;

    widget.onResult(page);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // app bar
          SliverAppBar(
            title: Text('Form'),
            snap: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TTextField(
                    label: Text('Title'),
                    maxLines: 1,
                    controller: titleController,
                  ),
                  TTextField(
                    label: Text('Url'),
                    maxLines: 1,
                    controller: urlController,
                  ),
                  TTextField(
                    label: Text('description'),
                    maxLines: null,
                    controller: descController,
                  ),
                  const Divider(),
                  // query
                  Text('Fetch Query'),
                  FetcherQueryForm(
                    title: 'Main Loop Query',
                    query: page.mainLoopQuery,
                    onChanged: (query) {
                      page.mainLoopQuery = query;
                      setState(() {});
                    },
                  ),
                  FetcherQueryForm(
                    title: 'Title Query',
                    query: page.titleQuery,
                    onChanged: (query) {
                      page.titleQuery = query;
                      setState(() {});
                    },
                  ),
                  FetcherQueryForm(
                    title: 'Url Query',
                    query: page.urlQuery,
                    onChanged: (query) {
                      page.urlQuery = query;
                      setState(() {});
                    },
                  ),
                  FetcherQueryForm(
                    title: 'Cover Url Query',
                    query: page.coverUrlQuery,
                    onChanged: (query) {
                      page.coverUrlQuery = query;
                      setState(() {});
                    },
                  ),
                  FetcherQueryForm(
                    title: 'Next Url Query',
                    query: page.nextUrlQuery,
                    onChanged: (query) {
                      page.nextUrlQuery = query;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          // content list
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Content Query List'),
                  IconButton(
                    color: Colors.green,
                    onPressed: () {
                      final newQuery = FetcherQuery.create('');
                      page.contentQueryList.add(newQuery);
                      setState(() {});
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                  // SizedBox(width: 20),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: page.contentQueryList.length,
            itemBuilder: (context, index) {
              final contentQuery = page.contentQueryList[index];
              return FetcherQueryForm(
                title: contentQuery.title,
                query: contentQuery,
                onChanged: (query) {
                  page.contentQueryList[index] = query;
                  setState(() {});
                },
                onDeleted: (query) {
                  page.contentQueryList.removeAt(index);
                  setState(() {});
                },
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 90),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _save();
        },
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
