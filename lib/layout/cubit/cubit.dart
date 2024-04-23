import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports),
    ),
    BottomNavigationBarItem(
      label: 'Science',
      icon: Icon(Icons.science),
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavBarState());
  }

  bool isDark = false;

  void changeMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(NewsChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        emit(NewsChangeModeState());
      });
    }
  }

  List<dynamic> business = [];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'category' : 'business',
          'apiKey' : '6aaf5e790e1649a39423a77fd1a2dd87',
        },
      ).then((value) {
        business = value.data['articles'];
        //print(value.data['articles'][0]['title']);
        print('length of business = ${business.length}');
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error));
      });
    }
    else{
      emit(NewsGetBusinessSuccessState());
    }

  }

  List<dynamic> sports = [];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'category' : 'sports',
          'apiKey' : '6aaf5e790e1649a39423a77fd1a2dd87',
        },
      ).then((value) {
        sports = value.data['articles'];
        //print(value.data['articles'][0]['title']);
        print('length of sports = ${sports.length}');
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'category' : 'science',
          'apiKey' : '6aaf5e790e1649a39423a77fd1a2dd87',
        },
      ).then((value) {
        science = value.data['articles'];
        //print(value.data['articles'][0]['title']);
        print('length of science = ${science.length}');
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List <dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q' : '$value',
          'apiKey' : '6aaf5e790e1649a39423a77fd1a2dd87',
        },
    ).then((value) {
      search = value.data['articles'];
      print('length of search = ${search.length}');
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error));
    });
  }

}