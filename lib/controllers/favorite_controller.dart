import 'package:flutter/material.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/constants/keys.dart';
import 'package:newsapp/utilities/services/sharedpreference_service.dart';
import 'package:newsapp/utilities/widgets/snack_bar.dart';

import '../utilities/functions/navigations.dart';

class FavoriteController extends ChangeNotifier {
  List<Article> saveArticle = <Article>[];
  List<Article> searchArticleLists = <Article>[];

  int selectIndexcat = 0;
  getSetelectdIndex({value}) {
    selectIndexcat = value;
    notifyListeners();
  }

  addingtoLists({required Article newsItem}) {
    if (saveArticle
        .indexWhere((element) => element.title == newsItem.title)
        .isNegative) {
      saveArticle.add(newsItem);
      final String encodedData = Article.encode(saveArticle);
      StorageManager.saveData(PKeys.savedlists, encodedData);
      snackBarProject(
          context: globalKey.currentContext!,
          title: 'This news has been saved',
          backgroundColor: Colors.green);
    }
    notifyListeners();
  }

  deletefromthelist({newsItem}) {
    if (saveArticle
            .indexWhere((element) => element.title == newsItem.title)
            .isNegative ==
        false) {
      saveArticle.remove(newsItem);
      final String encodedData = Article.encode(saveArticle);
      StorageManager.saveData(PKeys.savedlists, encodedData);
      snackBarProject(
          context: globalKey.currentContext!,
          title: 'This news has been Deleted',
          backgroundColor: Colors.red);
    }
    notifyListeners();
  }
}
