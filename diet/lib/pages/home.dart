import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diet/models/category_model.dart';
import 'package:diet/models/diet_model.dart';
import 'package:diet/models/popular_model.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appbar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 40),
          _categorySelection(),
          const SizedBox(height: 40),
          _dietSection(),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Popular Diets',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            popularDiets[index].iconPath,
                            width: 65,
                            height: 65,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularDiets[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 7),
                              Text(
                                  popularDiets[index].level +
                                      ' | ' +
                                      popularDiets[index].duration +
                                      ' | ' +
                                      popularDiets[index].calorie,
                                  style: const TextStyle(
                                      color: Color(0xff7B6F72),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Popular section button clicked!!");
                            },
                            child: SvgPicture.asset(
                              'assets/icons/button.svg',
                              height: 30,
                              width: 30,
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: popularDiets[index].boxIsSelected
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: popularDiets[index].boxIsSelected
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      offset: Offset(0, 10),
                                      blurRadius: 40,
                                      spreadRadius: 0),
                                ]
                              : []),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 15,
                      ),
                  shrinkWrap: true,
                  itemCount: popularDiets.length),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 250,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(diets[index].iconPath),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            diets[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            diets[index].level +
                                ' | ' +
                                diets[index].duration +
                                ' | ' +
                                diets[index].calorie,
                            style: const TextStyle(
                                color: Color(0xff7B6F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            print("View Clicked");
                            //diets[index].viewIsSelected = true;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  diets[index].viewIsSelected
                                      ? const Color(0xff9DCEFF)
                                      : Colors.transparent,
                                  diets[index].viewIsSelected
                                      ? const Color(0xff92A3FD)
                                      : Colors.transparent
                                ],
                              ),
                            ),
                            height: 45,
                            width: 130,
                            child: Center(
                              child: Text(
                                'View',
                                style: TextStyle(
                                    color: diets[index].viewIsSelected
                                        ? Colors.white
                                        : const Color(0xffC58BF2)),
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 25,
                  ),
              itemCount: diets.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20)),
        ),
      ],
    );
  }

  Column _categorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ), //TextField
        SizedBox(
          height: 15,
        ),
        Container(
          //margin: EdgeInsets.only(left: 4.0),
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 120,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 25,
            ),
          ),
        )
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: 'Yummy Pancakes',
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
            ),
          ),
          suffixIcon: Container(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/icons/Filter.svg'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'BreakFast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          print('clicked top left arrow');
        },
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
            //color: Colors.black,
          ),
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              print('Right button clicked!!');
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                  color: const Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                'assets/icons/dots.svg',
                height: 5,
                width: 5,
              ),
            ))
      ],
    );
  }
}
