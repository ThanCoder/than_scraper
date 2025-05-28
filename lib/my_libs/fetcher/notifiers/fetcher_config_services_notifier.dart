import 'package:flutter/material.dart';
import 'package:than_scraper/my_libs/fetcher/extensions/list_extensions.dart';
import 'package:than_scraper/my_libs/fetcher/services/fetcher_config_services.dart';

import '../types/page_query.dart';

class FetcherConfigServicesNotifier with ChangeNotifier {
  final List<PageQuery> _list = [];
  bool isLoading = false;

  List<PageQuery> get getList => _list;

  Future<void> initList() async {
    isLoading = true;
    notifyListeners();

    // await Future.delayed(Duration(seconds: 2));
    final res = await FetcherConfigServices.getList();
    _list.clear();
    _list.addAll(res);

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(PageQuery pageQuery) async {
    isLoading = true;
    notifyListeners();

    _list.add(pageQuery);
    _list.sortNewestDate();
    // save db
    await FetcherConfigServices.setList(_list);

    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(PageQuery pageQuery) async {
    final res = _list.where((e) => e.id != pageQuery.id).toList();
    _list.clear();
    _list.addAll(res);
    _list.sortNewestDate();

    // save db
    await FetcherConfigServices.setList(_list);

    notifyListeners();
  }

  Future<void> update(PageQuery pageQuery) async {
    final index = _list.indexWhere((e) => e.id == pageQuery.id);
    _list[index] = pageQuery;

    // save db
    await FetcherConfigServices.setList(_list);

    notifyListeners();
  }
}
