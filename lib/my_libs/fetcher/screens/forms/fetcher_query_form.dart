import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

import '../../types/fetcher_data_types.dart';
import '../../types/fetcher_query.dart';
import '../../types/fetcher_query_attr_types.dart';
import '../../types/fetcher_query_selector_types.dart';

class FetcherQueryForm extends StatefulWidget {
  String title;
  FetcherQuery query;
  void Function(FetcherQuery query) onChanged;
  void Function(FetcherQuery query)? onDeleted;
  FetcherQueryForm({
    super.key,
    required this.title,
    required this.query,
    required this.onChanged,
    this.onDeleted,
  });

  @override
  State<FetcherQueryForm> createState() => _FetcherQueryFormState();
}

class _FetcherQueryFormState extends State<FetcherQueryForm> {
  final titleController = TextEditingController();
  final queryController = TextEditingController();
  final attrController = TextEditingController();

  late FetcherQuery query;

  @override
  void initState() {
    query = widget.query;
    super.initState();
    init();
  }

  void init() {
    titleController.text = query.title;
    queryController.text = query.query;
    attrController.text = query.attr;
  }

  void update() {
    query.title = titleController.text;
    query.query = queryController.text;
    query.attr = attrController.text;
    widget.onChanged(query);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: Text(widget.title),
          onExpansionChanged: (value) {
            if (value == false) {
              update();
            }
          },
          children: [
            Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.onDeleted == null
                        ? SizedBox.shrink()
                        : IconButton(
                            color: Colors.red,
                            onPressed: () {
                              widget.onDeleted!(query);
                            },
                            icon: Icon(Icons.delete),
                          ),
                    ElevatedButton(
                      onPressed: update,
                      child: Text('Save'),
                    ),
                  ],
                ),

                TTextField(
                  label: Text('Title'),
                  controller: titleController,
                  maxLines: 1,
                  isSelectedAll: true,
                ),
                TTextField(
                  label: Text('Query'),
                  controller: queryController,
                  maxLines: 1,
                ),
                //not empty
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    Text('isNotEmptyAble'),
                    Switch.adaptive(
                      value: query.isNotEmptyAble,
                      onChanged: (value) {
                        query.isNotEmptyAble = value;
                        setState(() {});
                      },
                    ),
                    Text('isUsedForwardProxy'),
                    Switch.adaptive(
                      value: query.isUsedForwardProxy,
                      onChanged: (value) {
                        query.isUsedForwardProxy = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                // types
                Text('FetcherQueryAttrTypes'),
                DropdownButton<FetcherQueryAttrTypes>(
                  value: query.attrType,
                  items: FetcherQueryAttrTypes.values
                      .map((e) => DropdownMenuItem<FetcherQueryAttrTypes>(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    query.attrType = value!;
                    setState(() {});
                  },
                ),
                Text('FetcherQuerySelectorTypes'),
                DropdownButton<FetcherQuerySelectorTypes>(
                  value: query.selectorTypes,
                  items: FetcherQuerySelectorTypes.values
                      .map((e) => DropdownMenuItem<FetcherQuerySelectorTypes>(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    query.selectorTypes = value!;
                    setState(() {});
                  },
                ),
                Text('FetcherDataTypes'),
                DropdownButton<FetcherDataTypes>(
                  value: query.dataType,
                  items: FetcherDataTypes.values
                      .map((e) => DropdownMenuItem<FetcherDataTypes>(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    query.dataType = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
