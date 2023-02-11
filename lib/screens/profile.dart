import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/models/mentor.dart' as mentors;
import 'package:mentoo/models/request/user_request_model.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/screens/edit_profile.dart';
import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/alert_dialog.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final int? userId;
  final int? mentorId;
  final bool? isViewMentor;
  final int? menteeId;
  const Profile(
      {Key? key, this.mentorId, this.isViewMentor, this.menteeId, this.userId})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  mentors.Mentor? _mentor;
  User? _user;
  bool _loading = true;
  String imageUrl = "";

  _ProfileState();

  @override
  void initState() {
    super.initState();
    if (widget.isViewMentor == true && widget.mentorId != null) {
      _getData();
    } else if (widget.isViewMentor == null && widget.userId != null) {
      _getUserData();
    }
  }

  void _getData() async {
    _mentor = await MentorService().getMentorById(widget.mentorId!);
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  void _getUserData() async {
    _user = await UserService().getUser();
    _user ??= await UserService().getUserById(widget.userId);
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _loading
            ? const Loading()
            : CustomScrollView(
                controller: ScrollController(initialScrollOffset: 0),
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: CustomSliverAppBarDelegate(
                        expandedHeight: 485,
                        isViewMentor: widget.isViewMentor,
                        mentor: _mentor,
                        user: _user,
                        imageUrl: imageUrl),
                  ),
                  const SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    // title: Text(
                    //   "Profile",
                    //   style: TextStyle(color: AppColors.mLightPurple),
                    // ),
                    centerTitle: true,
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0.0),
                      child: TabBar(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          indicatorColor: AppColors.mLightPurple,
                          labelColor: AppColors.mLightPurple,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppCommon.screenWidthUnit(context),
                              right: AppCommon.screenWidthUnit(context)),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            margin: const EdgeInsets.only(top: 0),
                            height: 2000,
                            child: TabBarView(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.isViewMentor == null
                                      ? _user != null
                                          ? Text(_user!.description)
                                          : const Text("No data")
                                      : widget.isViewMentor == true
                                          ? _mentor != null
                                              ? Text(_mentor!.user.description)
                                              : const Text("No data")
                                          : const Text("No data"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "More...",
                                    style:
                                        TextStyle(color: AppColors.mGrayStroke),
                                  ),
                                  const Center(
                                    child: SizedBox(
                                      width: 250,
                                      child: Divider(
                                        thickness: 2,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  _user!.jobs != null
                                      ? SizedBox(
                                          height: 130 *
                                              _user!.jobs!.length.toDouble(),
                                          child: ListView.builder(
                                            itemCount: _user!.jobs!.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(width: 30),
                                                      Icon(
                                                        Icons.adjust_rounded,
                                                        size: 30,
                                                        color: AppColors
                                                            .mLightPurple,
                                                      ),
                                                      SizedBox(width: 30),
                                                      // Container(
                                                      //   width: 40,
                                                      //   height: 40,
                                                      //   decoration: BoxDecoration(
                                                      //       border: Border.all(
                                                      //           color: AppColors
                                                      //               .mGrayStroke),
                                                      //       borderRadius:
                                                      //           BorderRadius
                                                      //               .circular(
                                                      //                   7)),
                                                      //   child: Image.asset(
                                                      //     'assets/images/apple.png',
                                                      //   ),
                                                      // ),
                                                      //SizedBox(width: 20),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            _user!.jobs![index]
                                                                .role,
                                                            style:
                                                                AppFonts.medium(
                                                                    18,
                                                                    Colors
                                                                        .black),
                                                          ),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                          Text(
                                                            _user!.jobs![index]
                                                                .company,
                                                            style: AppFonts.medium(
                                                                14,
                                                                AppColors
                                                                    .mGrayStroke),
                                                          ),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                          Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            DateFormat("MMMM yyyy")
                                                                    .format(_user!
                                                                        .jobs![
                                                                            index]
                                                                        .startDate) +
                                                                " - " +
                                                                (_user!.jobs![index].endDate ==
                                                                        null
                                                                    ? "Now"
                                                                    : DateFormat(
                                                                            "MMMM yyyy")
                                                                        .format(_user!
                                                                            .jobs![index]
                                                                            .endDate!)),
                                                            style: AppFonts.regular(
                                                                12,
                                                                AppColors
                                                                    .mGrayStroke),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  index !=
                                                          _user!.jobs!.length -
                                                              1
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 43),
                                                          child: DottedLine(
                                                            lineLength: 50,
                                                            dashColor: AppColors
                                                                .mDarkPurple,
                                                            direction:
                                                                Axis.vertical,
                                                            lineThickness: 2,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              const Text("Comming soon"),
                              const Text("Comming soon"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

void showDialogWidget(BuildContext context, String error) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertPopup(
            icon: Icon(
              Icons.error,
              size: 200,
              color: Colors.red,
            ),
            title: "Opps, Failed",
            message: error,
            buttons: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(
                  'Try again',
                  style: AppFonts.medium(18, Colors.white),
                ),
              ),
            ],
          ));
}

class ImageWidget extends StatelessWidget {
  final int index;

  const ImageWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
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
  mentors.Mentor? mentor;
  User? user;
  final bool? isViewMentor;
  final double expandedHeight;
  String imageUrl;

  CustomSliverAppBarDelegate(
      {this.user,
      this.mentor,
      this.isViewMentor,
      required this.expandedHeight,
      required this.imageUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      //overflow: Overflow.visible,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: 400,
          right: 0,
          child: Visibility(
            visible: shrinkOffset > 0 ? false : true,
            child: Container(
              height: 85,
              width: 500,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: buildFloating(context, shrinkOffset, user!.name, user!.userId),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset * 0.01 / expandedHeight;

  double disappear(double shrinkOffset) =>
      1 - (shrinkOffset / expandedHeight * 10) * 0.01;

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: isViewMentor == null
            ? user != null
                ? user!.photo.replaceAll(" ", "").isNotEmpty
                    ? Image.network(
                        user!.photo,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      )
                : Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  )
            : isViewMentor == true
                ? mentor != null
                    ? mentor!.user.photo.replaceAll(" ", "").isNotEmpty
                        ? Image.network(
                            mentor!.user.photo,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          )
                    : Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      )
                : Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
      );

  Widget buildFloating(
          BuildContext context, double shrinkOffset, String name, int id) =>
      Visibility(
        visible: shrinkOffset > 0 ? false : true,
        child: Padding(
          padding: EdgeInsets.only(
              left: AppCommon.screenWidthUnit(context) * 0.5,
              right: AppCommon.screenWidthUnit(context) * 0.5),
          child: Stack(clipBehavior: Clip.none, children: [
            Center(
              child: Container(
                height: 140,
                width: AppCommon.screenWidth(context),
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: [
                  Text(
                    isViewMentor == null
                        ? user != null
                            ? user!.name
                            : "No name data"
                        : isViewMentor == true
                            ? mentor != null
                                ? mentor!.user.name
                                : "No name data"
                            : "No name data",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    isViewMentor == null
                        ? user != null
                            ? user!.jobs != null
                                ? "${user!.jobs![0].role}, ${user!.jobs![0].company}"
                                : "No job data"
                            : "No job data"
                        : isViewMentor == true
                            ? mentor != null
                                ? "${mentor!.user.jobs![0].role}, ${mentor!.user.jobs![0].company}"
                                : "No job data"
                            : "No job data",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ]),
              ),
            ),
            Positioned(
              top: -25,
              left: 50,
              right: 50,
              child: InkWell(
                onTap: () async {
                  print("click");
                  /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                  /*Step 1:Pick image*/
                  //Install image_picker
                  //Import the corresponding library
                  try {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file;

                    file = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    //print('${file?.path}');

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors/success

                    //Store the file
                    await referenceImageToUpload.putFile(File(file.path));
                    //Success: get the download URL
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    UserRequestModel user =
                        UserRequestModel(name: name, photo: imageUrl);
                    await UserService().updateUser(user, id);
                    var user1 = await UserService().getUserById(id);
                    await UserService().saveUser(user1!);
                    await UserService().getUser();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(
                                isMentor: 0,
                                initialPage: 2,
                                userId: user1.userId,
                              )),
                    );
                  } on PlatformException catch (e) {
                    if (e.code == 'invalid_image') {
                      //print('Invalid image format');
                      showDialogWidget(context,
                          'Invalid image format! Do not support type .jpeg');
                    }
                  } catch (error) {
                    showDialogWidget(context, error.toString());
                  }
                },
                child: Center(
                  child: isViewMentor == null
                      ? Container(
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
                        )
                      : isViewMentor!
                          ? Container(
                              alignment: Alignment.topCenter,
                              height: 50,
                              width: 90,
                              child: Center(
                                  child: Container(
                                width: 90,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: isViewMentor == true
                                        ? AppColors.mLightRed
                                        : AppColors.mLightPurple,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all()),
                                child: Center(
                                  child: isViewMentor == true
                                      ? Text(
                                          'Mentor',
                                          style:
                                              AppFonts.medium(16, Colors.black),
                                        )
                                      : Text(
                                          'Mentee',
                                          style:
                                              AppFonts.medium(16, Colors.black),
                                        ),
                                ),
                              )),
                            )
                          : Container(
                              alignment: Alignment.topCenter,
                              width: 90,
                              child: Center(
                                  child: Container(
                                width: 90,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: AppColors.mLightPurple,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all()),
                                child: Center(
                                  child: Text(
                                    'Mentee',
                                    style: AppFonts.medium(16, Colors.black),
                                  ),
                                ),
                              )),
                            ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 115, left: 10),
              child: InkWell(
                onTap: () => Get.to(EditProfile()),
                child: Center(
                  child: isViewMentor == null
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          width: 160,
                          height: 50,
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
                        )
                      : isViewMentor == true
                          ? InkWell(
                              onTap: () => Get.to(BookAppointment(
                                  menteeId: 1, mentor: mentor!)),
                              child: Container(
                                alignment: Alignment.topCenter,
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.mLightPurple,
                                ),
                                child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      Icon(
                                        Icons.calendar_month_sharp,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Book Appointment",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                              ),
                            )
                          : Container(
                              alignment: Alignment.topCenter,
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.mLightPurple,
                              ),
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                    Icon(
                                      Icons.calendar_month_sharp,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Book Appointments",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])),
                            ),
                ),
              ),
            ),
          ]),
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
