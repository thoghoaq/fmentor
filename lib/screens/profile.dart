import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppCommon.screenWidthUnit(context) * 0.5),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: CustomScrollView(
            controller: ScrollController(initialScrollOffset: 0),
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: CustomSliverAppBarDelegate(expandedHeight: 400),
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                title: Text(
                  "Profile",
                  style: TextStyle(color: AppColors.mLightPurple),
                ),
                centerTitle: true,
                elevation: 0,
                bottom: TabBar(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    indicatorColor: AppColors.mLightPurple,
                    labelColor: AppColors.mLightPurple,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelColor: AppColors.mGrayStroke,
                    tabs: [
                      Tab(
                        text: "Profile",
                      ),
                      Tab(
                        text: "Reviews",
                      ),
                      Tab(
                        text: "Cetificates",
                      ),
                    ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      margin: EdgeInsets.only(top: 0),
                      height: 2000,
                      child: TabBarView(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "More...",
                              style: TextStyle(color: AppColors.mGrayStroke),
                            ),
                            Center(
                              child: SizedBox(
                                width: 250,
                                child: Divider(
                                  thickness: 2,
                                  height: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.adjust_rounded,
                                        size: 30,
                                        color: AppColors.mLightPurple,
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.mGrayStroke),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Marketer",
                                            style: AppFonts.medium(
                                                18, Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Shoppe",
                                            style: AppFonts.medium(
                                                14, AppColors.mGrayStroke),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "August 2019 - Now",
                                            style: AppFonts.regular(
                                                12, AppColors.mGrayStroke),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 43),
                                    child: DottedLine(
                                      lineLength: 50,
                                      dashColor: AppColors.mDarkPurple,
                                      direction: Axis.vertical,
                                      lineThickness: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.adjust_rounded,
                                        size: 30,
                                        color: AppColors.mLightPurple,
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.mGrayStroke),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Marketer",
                                            style: AppFonts.medium(
                                                18, Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Shoppe",
                                            style: AppFonts.medium(
                                                14, AppColors.mGrayStroke),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "August 2019 - Now",
                                            style: AppFonts.regular(
                                                12, AppColors.mGrayStroke),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 43),
                                    child: DottedLine(
                                      lineLength: 50,
                                      dashColor: AppColors.mDarkPurple,
                                      direction: Axis.vertical,
                                      lineThickness: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.adjust_rounded,
                                        size: 30,
                                        color: AppColors.mLightPurple,
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.mGrayStroke),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Marketer",
                                            style: AppFonts.medium(
                                                18, Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Shoppe",
                                            style: AppFonts.medium(
                                                14, AppColors.mGrayStroke),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "August 2019 - Now",
                                            style: AppFonts.regular(
                                                12, AppColors.mGrayStroke),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 43),
                                    child: DottedLine(
                                      lineLength: 50,
                                      dashColor: AppColors.mDarkPurple,
                                      direction: Axis.vertical,
                                      lineThickness: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.adjust_rounded,
                                        size: 30,
                                        color: AppColors.mLightPurple,
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.mGrayStroke),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Marketer",
                                            style: AppFonts.medium(
                                                18, Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Shoppe",
                                            style: AppFonts.medium(
                                                14, AppColors.mGrayStroke),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "August 2019 - Now",
                                            style: AppFonts.regular(
                                                12, AppColors.mGrayStroke),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 43),
                                    child: DottedLine(
                                      lineLength: 50,
                                      dashColor: AppColors.mDarkPurple,
                                      direction: Axis.vertical,
                                      lineThickness: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.adjust_rounded,
                                        size: 30,
                                        color: AppColors.mLightPurple,
                                      ),
                                      SizedBox(width: 30),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.mGrayStroke),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Marketer",
                                            style: AppFonts.medium(
                                                18, Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Shoppe",
                                            style: AppFonts.medium(
                                                14, AppColors.mGrayStroke),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "August 2019 - Now",
                                            style: AppFonts.regular(
                                                12, AppColors.mGrayStroke),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text("Comming soon"),
                        Text("Comming soon"),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final int index;

  const ImageWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 150,
        width: double.infinity,
        child: Card(
          child: Image.network(
            'https://source.unsplash.com/random?sig=$index',
            fit: BoxFit.cover,
          ),
        ),
      );
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 300;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      //overflow: Overflow.visible,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.cover,
        ),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 150,
            width: 500,
            padding: const EdgeInsets.only(
              top: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              Text(
                "Hoang Michael 31",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Intern Java, FPT Software",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
              )
            ]),
          ),
          Positioned(
            top: -25,
            left: 170,
            child: Container(
              alignment: Alignment.topCenter,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Center(
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.mLightPurple,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -28,
            left: 95,
            child: Container(
              alignment: Alignment.topCenter,
              width: 200,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mLightPurple,
              ),
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edit profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
            ),
          ),
        ]),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
