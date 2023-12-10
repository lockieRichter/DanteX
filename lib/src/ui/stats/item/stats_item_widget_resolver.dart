import 'package:dantex/src/data/stats/stats_item.dart';
import 'package:dantex/src/ui/stats/item/books_and_pages_stats_item_widget.dart';
import 'package:dantex/src/ui/stats/item/label_stats_item_widget.dart';
import 'package:dantex/src/ui/stats/item/language_stats_item_widget.dart';
import 'package:dantex/src/ui/stats/item/pages_per_month_stats_item_widget.dart';
import 'package:dantex/src/ui/stats/item/reading_time_stats_item_widget.dart';
import 'package:flutter/material.dart';

class StatsItemWidgetResolver {
  StatsItemWidgetResolver._();

  static Widget resolveItem(StatsItem item, {bool isMobile = false}) {
    return switch (item) {
      BooksAndPagesStatsItem() => BooksAndPagesStatsItemWidget(item),
      ReadingTimeStatsItem() => ReadingTimeStatsItemWidget(
          item,
          isMobile: isMobile,
        ),
      LanguageStatsItem() => LanguageStatsItemWidget(
          item,
          isMobile: isMobile,
        ),
      LabelStatsItem() => LabelStatsItemWidget(
          item,
          isMobile: isMobile,
        ),
      PagesPerMonthStatsItem() => PagesPerMonthStatsItemWidget(item),
      // TODO: Handle this case.
      FavoritesStatsItem() => Container(),
      // TODO: Handle this case.
      MiscStatsItem() => Container(),
      // TODO: Handle this case.
      BooksPerYearStatsItem() => Container(),
    };
  }
}
