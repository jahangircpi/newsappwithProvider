import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class SearchController extends ChangeNotifier {
  HomePageNewsModel searchDataLists = HomePageNewsModel();
  List<Article>? searchList = [];
  DataState searchDataState = DataState.initial;
  TextEditingController? searchTextController = TextEditingController();
  ScrollController sheetScrollController = ScrollController();

  getSearchData({required searchTexts}) async {
    searchDataState = DataState.loading;
    notifyListeners();
    try {
      Response searchdatas = await getHttp(
        path: Urls.search(searchText: searchTexts),
      );
      if (searchdatas.statusCode == 200) {
        searchDataLists = HomePageNewsModel.fromJson(searchdatas.data);
        searchDataState = DataState.loaded;
      }
    } catch (e) {
      searchDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }

  int homeImageIndex = 0;
  getHomeIndex({givenIndex}) {
    homeImageIndex = givenIndex;
    notifyListeners();
  }

  bool isTopBarShown = true;
  getTopBarShown({value}) {
    isTopBarShown = value;
    notifyListeners();
  }
}
