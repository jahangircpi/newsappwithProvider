import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/utilities/widgets/search_bar.dart';
import 'package:newsapp/views/saved_news/components/alldata.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../utilities/services/sharedpreference_service.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  List<Article> searchArticleLists = <Article>[];
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();

    callBack(() async {
      await StorageManager.readData('savedlists').then((value) {
        printer(value);
        context.read<FavoriteController>().saveArticle = Article.decode(value);
        searchArticleLists = context.read<FavoriteController>().saveArticle;
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FavoriteController>(
          builder: ((context, favoritecontroller, child) {
            return Column(
              children: [
                appBar(context),
                searchField(
                    hintText: 'Search',
                    onChanged: (v) {
                      searchArticleLists = favoritecontroller.saveArticle
                          .where((element) => element.title!
                              .toString()
                              .toLowerCase()
                              .contains(v))
                          .toList();
                      setState(() {});
                    }),
                Expanded(
                  child: AllSavedDataLists(listName: searchArticleLists),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Row appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            pop(context: context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Text(
          'Saved Articles',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: UdDesign.fontSize(20),
          ),
        ),
        const SizedBox()
      ],
    );
  }
}
