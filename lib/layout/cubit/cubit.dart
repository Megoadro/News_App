import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:flutter/material.dart';

import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/setting/setting_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

//creatobject from bloc =>
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Scince'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  //https://newsapi.org/
  //v2/top-headline?
  //country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    // الل index هنا بيساوي 1 لان الاسكرينه بتاعة business  تساوي 0
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNaveState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper().getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': 'f1dc51a27ad64097a663e717f91ea915',
    }).then((value) {
//        print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error().toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(GetSportsLoadingState());
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    if (sports.length == 0) {
      DioHelper().getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': 'f1dc51a27ad64097a663e717f91ea915',
      }).then((value) {
        // 'apikey' :'65f7f556ec76449fa7dc7c0069f040ca',
//        print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsSuccessState());
      }).catchError((error) {
        print(error().toString());
        emit(GetSportsErrorState(error.toString()));
      });
    } else {
      emit(GetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  // هنا معناها ان هدوس علي ال icon  ف هجيب الل sports
  void getScience() {
    emit(GetScienceLoadingState());
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    // ولكن هنا بعد ما جبت sports  انا مش هدخل داخل dio لا تساوي ال 0 لان فية داتا يعني هيعمل load مره واحده بسسس
    // الفديو 93 الدقيقه 45
    if (science.length == 0) {
      DioHelper().getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': 'f1dc51a27ad64097a663e717f91ea915',
      }).then((value) {
//        print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(GetScienceSuccessState());
      }).catchError((error) {
        print(error().toString());
        emit(GetScienceErrorState(error.toString()));
      });
    } else {
      emit(GetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  // هنا معناها ان هدوس علي ال icon  ف هجيب الل sports
  void getSearch(String value) {
    emit(GetSearchLoadingState());
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    // ولكن هنا بعد ما جبت sports  انا مش هدخل داخل dio لا تساوي ال 0 لان فية داتا يعني هيعمل load مره واحده بسسس
    // الفديو 93 الدقيقه 45
    DioHelper().getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apikey': 'f1dc51a27ad64097a663e717f91ea915',
        }).then((value) {
//        print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error().toString());
      emit(GetSearchErrorState(error.toString()));
    });

}

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else
      isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());
    });
  }
}
