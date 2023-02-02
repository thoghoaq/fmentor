import 'package:flutter/material.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _specialties = [];
  String _selectedSpecialty = "Graphic Design";

  @override
  void initState() {
    super.initState();
    _fetchSpecialties();
  }

  void _fetchSpecialties() async {
    setState(() {
      _specialties = [
        "Graphic Design",
        "Marketing",
        "Software Engineering",
        "Others"
      ];
    });
  }

  void _showSpecialtiesMenu(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topRight,
          child: Container(
            height: _specialties.length * 50,
            width: 1000,
            decoration: BoxDecoration(
                color: AppColors.m_background,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: _specialties.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(index);
                    setState(() {
                      _selectedSpecialty = _specialties[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: _selectedSpecialty == _specialties[index]
                        ? AppColors.mLightPurple
                        : AppColors.m_background,
                    child: Text(
                      _specialties[index],
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
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
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
          titleTextStyle: AppFonts.medium(20, Colors.black),
          title: Container(
              //width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.mDarkPurple,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20),
                    filled: true,
                    fillColor: Colors.white,
                    // focusColor: AppColors.grayColor,
                    // hoverColor: AppColors.grayColor,
                    //labelText: "Search for mentor ",
                    labelStyle: AppFonts.medium(16, AppColors.mText),
                    //errorText: 'Error message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: AppColors.mDarkPurple),
                    ),
                  ),
                ),
              ))),
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
              10,
              (index) => const ProfileCard(),
            )),
      ),
    );
  }
}

class DumyModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text("Choose Wisely",
              style: TextStyle(color: Colors.teal, fontSize: 20),
              textAlign: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: OutlinedButton(
                  child: Column(
                    children: [
                      FlutterLogo(
                        size: MediaQuery.of(context).size.height * .15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text("CF Cruz Azul"),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("CF Cruz Azul");
                  },
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: OutlinedButton(
                  child: Column(
                    children: [
                      FlutterLogo(
                        size: MediaQuery.of(context).size.height * .15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text("Monarcas FC"),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("Monarcas FC");
                  },
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}