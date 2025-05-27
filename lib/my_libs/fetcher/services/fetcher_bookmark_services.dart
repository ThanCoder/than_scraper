import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_content_data_model.dart';
import 'package:than_scraper/my_libs/setting/path_util.dart';


class FetcherBookmarkServices {
  static Future<void> add(FetcherContentDataModel contentData) async {
    final list = await getList();
    list.insert(0, contentData);

    await list.save();
  }

  static Future<void> remove(FetcherContentDataModel contentData) async {
    final list = await getList();
    final res = list.where((e) => e.title != contentData.title).toList();

    await res.save();
  }

  static Future<bool> isExists(FetcherContentDataModel contentData) async {
    final list = await getList();
    final res = list.where((e) => e.title == contentData.title);
    if (res.isNotEmpty) return true;
    return false;
  }

  static Future<List<FetcherContentDataModel>> getList() async {
    final path = FetcherBookmarkServices.getPath;
    final list = await Isolate.run<List<FetcherContentDataModel>>(() async {
      try {
        final file = File(path);
        if (!await file.exists()) return [];
        List<dynamic> resList = jsonDecode(await file.readAsString());
        return resList
            .map((map) => FetcherContentDataModel.fromMap(map))
            .toList();
      } catch (e) {
        debugPrint('getList: ${e.toString()}');
      }
      return [];
    });
    return list;
  }

  static String get getPath {
    return '${PathUtil.getLibaryPath()}/fetcher-offline-cache.db.json';
  }
}

extension FetcherContentDataSaver on List<FetcherContentDataModel> {
  Future<void> save() async {
    final path = FetcherBookmarkServices.getPath;
    await Isolate.run(() async {
      final file = File(path);
      final data = map((fcd) => fcd.toMap).toList();
      await file.writeAsString(jsonEncode(data));
    });
  }
}
