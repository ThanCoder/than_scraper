import 'package:flutter/material.dart';
import 'package:than_scraper/my_libs/fetcher/types/fetcher_data.dart';

class FetcherDataGridItem extends StatelessWidget {
  FetcherData data;
  void Function(FetcherData data) onClicked;
  FetcherDataGridItem({
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
            Column(
              children: [
                // Expanded(
                //   child: CacheImage(
                //     url: data.coverUrl,
                //     savedPath: '${PathUtil.getCachePath()}/${data.title}',
                //   ),
                // ),
              ],
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
                  'title',
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
