import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/widgets/loading/three_bounch.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ud_design/ud_design.dart';
import '../../inappviewscreen.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';
import '../functions/gap.dart';
import 'netimagecalling.dart';

containerwhite({
  required DataState dataStateEnum,
  listName,
  ScrollController? listController,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: UdDesign.pt(8),
    ),
    child: dataStateEnum == DataState.initial ||
            dataStateEnum == DataState.loading
        ? const Center(
            child: Loader(
              color: Colors.white,
            ),
          )
        : dataStateEnum == DataState.error
            ? const Center(
                child: Text(
                  "There is a Problem!",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                controller: listController,
                itemCount: listName.length,
                itemBuilder: (BuildContext context, int index) {
                  var lists = listName[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: UdDesign.pt(4)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: PColors.containerColor,
                        borderRadius: BorderRadius.circular(
                          UdDesign.pt(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 0,
                            child: SizedBox(
                              width: UdDesign.pt(100),
                              height: UdDesign.pt(100),
                              child: networkImagescall(
                                  src: lists.urlToImage ??
                                      "https://firebasestorage.googleapis.com/v0/b/portfolio-8523e.appspot.com/o/loading.png?alt=media&token=894ae105-847f-48e5-af95-7467dafa74e2"),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: gapX(5),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  gapY(5),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Colors.primaries[Random()
                                              .nextInt(
                                                  Colors.primaries.length)],
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: UdDesign.pt(8),
                                              vertical: UdDesign.pt(8),
                                            ),
                                            child: Text(
                                              lists.source!.name ?? "Source",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        gapX(10),
                                      ],
                                    ),
                                  ),
                                  gapY(5),
                                  Text(
                                      "${lists.publishedAt.year.toString()}-${lists.publishedAt.month.toString().padLeft(2, '0')}-${lists.publishedAt.day.toString().padLeft(2, '0')} ${lists.publishedAt.hour.toString().padLeft(2, '0')}-${lists.publishedAt.minute.toString().padLeft(2, '0')}"),
                                  gapY(5),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          screen: InAppWebViewScreen(
                                              website: lists.url),
                                          context: context);
                                    },
                                    child: Text(
                                      lists.title ?? "got error to load",
                                      style: TextStyle(
                                          fontSize: UdDesign.fontSize(18),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Share.share(lists.url);
                                        },
                                        child: const Icon(Icons.share),
                                      ),
                                      gapX(10),
                                      Consumer<FavoriteController>(
                                        builder: ((context, favoritecontroller,
                                            child) {
                                          return InkWell(
                                            onTap: () {
                                              favoritecontroller.addingtoLists(
                                                  newsItem: lists);
                                            },
                                            child: Icon(
                                              favoritecontroller.saveArticle
                                                      .indexWhere((element) =>
                                                          element.title ==
                                                          lists.title)
                                                      .isNegative
                                                  ? Icons.bookmark_border
                                                  : Icons.download_done,
                                              color: favoritecontroller
                                                      .saveArticle
                                                      .indexWhere((element) =>
                                                          element.title ==
                                                          lists.title)
                                                      .isNegative
                                                  ? Colors.black
                                                  : Colors.green,
                                            ),
                                          );
                                        }),
                                      ),
                                      gapX(10),
                                    ],
                                  ),
                                  gapY(10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
  );
}
