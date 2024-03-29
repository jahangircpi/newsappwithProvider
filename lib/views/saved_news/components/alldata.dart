import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ud_design/ud_design.dart';
import '../../../inappviewscreen.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/functions/navigations.dart';
import '../../../utilities/widgets/netimagecalling.dart';

class AllSavedDataLists extends StatefulWidget {
  final List<Article>? listName;
  final FavoriteController? favoritecontroller;
  const AllSavedDataLists({
    Key? key,
    required this.listName,
    required this.favoritecontroller,
  }) : super(key: key);

  @override
  State<AllSavedDataLists> createState() => _AllSavedDataListsState();
}

class _AllSavedDataListsState extends State<AllSavedDataLists> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.listName!.isEmpty
        ? const Center(
            child: Text(
            'Saved List is empty',
            style: TextStyle(color: Colors.white),
          ))
        : ListView.builder(
            itemCount: widget.listName!.reversed.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var lists = widget.listName![index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: UdDesign.pt(4),
                  vertical: UdDesign.pt(4),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: UdDesign.pt(3),
                                    vertical: UdDesign.pt(3),
                                  ),
                                  child: Text(
                                    lists.source!.name!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              gapY(4),
                              Text(
                                "${lists.publishedAt!.year.toString()}-${lists.publishedAt!.month.toString().padLeft(2, '0')}-${lists.publishedAt!.day.toString().padLeft(2, '0')} ${lists.publishedAt!.hour.toString().padLeft(2, '0')}-${lists.publishedAt!.minute.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: UdDesign.fontSize(16),
                                ),
                              ),
                              gapY(4),
                              InkWell(
                                onTap: () {
                                  push(
                                    context: context,
                                    screen:
                                        InAppWebViewScreen(website: lists.url!),
                                  );
                                },
                                child: Text(
                                  lists.title!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: UdDesign.fontSize(16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Expanded(
                          flex: 0,
                          child: SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child:
                                    networkImagescall(src: lists.urlToImage!),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: UdDesign.pt(5),
                    ),
                    SizedBox(
                      height: UdDesign.pt(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Share.share(lists.url!);
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: UdDesign.pt(24),
                            ),
                          ),
                          gapX(10),
                          InkWell(
                            onTap: () {
                              widget.favoritecontroller!
                                  .deletefromthelist(newsItem: lists);
                              widget.favoritecontroller!.searchArticleLists =
                                  widget.favoritecontroller!.saveArticle;
                              setState(() {});
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: UdDesign.pt(24),
                              ),
                            ),
                          ),
                          gapX(10),
                        ],
                      ),
                    ),
                    gapY(10),
                    const Divider(
                      color: Colors.white,
                    ),
                    gapY(10),
                  ],
                ),
              );
            },
          );
  }
}
