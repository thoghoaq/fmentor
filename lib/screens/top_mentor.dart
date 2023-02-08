import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/specialty_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/widgets/loading.dart';

class TopMentors extends StatefulWidget {
  const TopMentors({super.key});

  @override
  State<TopMentors> createState() => _TopMentorsState();
}

class _TopMentorsState extends State<TopMentors> {
  List<Specialty>? _specialties;
  List<Mentor>? _mentors;
  List<String> _specialtiesName = [];
  late String _selectedSpecialty;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSpecialties();
  }

  void _fetchSpecialties() async {
    _specialties = await SpecialtyService().getSpecialties();
    _mentors = await MentorService().getMentors();
    _specialtiesName = _specialties!.map((s) => s.name).toList();
    //_specialtiesName.add("Others");
    _selectedSpecialty = _specialtiesName[0];
    if (_specialties != null && _mentors != null)
      setState(() {
        _isLoading = true;
      });
  }

  void _showSpecialtiesMenu(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topRight,
          child: Container(
            height: _specialties!.length * 50,
            width: 1000,
            decoration: BoxDecoration(
                color: AppColors.mBackground,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: _specialties!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(_specialties![index].specialtyId.toString() +
                        " : " +
                        _specialties![index].name);
                    setState(() {
                      _selectedSpecialty = _specialtiesName[index];
                      //_mentors = _mentors.where((element) => element.)
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: _selectedSpecialty == _specialtiesName[index]
                        ? AppColors.mLightPurple
                        : AppColors.mBackground,
                    child: Text(
                      _specialtiesName[index],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                InkWell(
                    onTap: () {
                      _showSpecialtiesMenu(context);
                    },
                    child: Icon(Icons.filter_alt_outlined,
                        color: Colors.black, size: 30)),
                SizedBox(
                  width: 10,
                )
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
              title: const Text(
                'Top Mentors',
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: GridView.count(
                  //physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  children: List.generate(
                    _mentors!.length,
                    (index) => ProfileCard(
                      company: _mentors![index].user.jobs![0].company,
                      job: _mentors![index].user.jobs![0].role,
                      name: _mentors![index].user.name,
                      image: _mentors![index].user.photo,
                    ),
                  )),
            ),
          );
  }
}
