import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_page_data.dart';
import 'package:than_scraper/my_libs/setting/path_util.dart';


class FetcherPageDataGridItem extends StatelessWidget {
  FetcherPageData data;
  void Function(FetcherPageData data) onClicked;
  FetcherPageDataGridItem({
    super.key,
    required this.data,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(data),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          children: [
            Positioned.fill(
              child: TCacheImage(
                url: data.coverUrl,
                cachePath: '${PathUtil.getCachePath()}/${data.title}',
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(174, 37, 37, 37),
                ),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
