import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/services/specialty_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';

class SpecialistMentors extends StatefulWidget {
  const SpecialistMentors({Key? key}) : super(key: key);

  @override
  State<SpecialistMentors> createState() => _SpecialistMentorsState();
}

class _SpecialistMentorsState extends State<SpecialistMentors> {
  List<Specialty>? _specialties;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _specialties = await SpecialtyService().getSpecialties();
    setState(() {
      if (_specialties != null) isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchAreaContainerWidth = AppCommon.screenWidthUnit(context) * 11;
    var searchAreaContainerHeight = AppCommon.screenHeightUnit(context) * 3;
    return !isLoaded
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed: () => Get.back(),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
              title: const Text(
                'Specialist Mentors',
              ),
            ),
            body: Padding(
              padding:
                  EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.2),
              child: GridView.count(
                  padding: EdgeInsets.zero,
                  primary: false,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  children: List.generate(
                    _specialties!.length,
                    (index) => Container(
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mLightPurple,
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            _specialties![index].picture,
                            fit: BoxFit.cover,
                            width: searchAreaContainerWidth * 0.50,
                            height: searchAreaContainerHeight * 0.35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _specialties![index].name,
                            style: AppFonts.medium(15, Colors.white),
                            maxLines: 2,
                          ),
                          // Text(
                          //   "Design",
                          //   style: AppFonts.medium(15, Colors.white),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${_specialties![index].numberMentor} Mentors",
                            style: AppFonts.regular(13, Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          );
  }
}
