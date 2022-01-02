import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
      label: 'Science'
    ),
    // const BottomNavigationBarItem(
    //     icon: Icon(
    //       Icons.settings,
    //     ),
    //   label: 'Settings'
    // ),
  ];

  List<Widget> screens=const[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;

    if(index==1){
      getSport();
    }
    if(index==2){
      getScience();
    }
    emit(NewsStateBottomNav());
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      // url: 'products',             //***************************** for Product  Api **************
//    *****/?=&=&=&keyword=&keywordOper=or&lang=eng&articlesSortBy=date&includeArticleConcepts=true&includeArticleCategories=true&articleBodyLen=300&articlesCount=10&apiKey=d9083f1b-74e1-46af-8190-dbcf992e077e
//       url: 'api/v1/article/getArticles',
//       query: { 'resultType' : 'articles' , 'keyword' : 'Bitcoin' ,'keyword' : 'Ethereum' ,'keywordOper' : 'or' ,'lang' : 'eng' ,'articlesSortBy' : 'date' ,'includeArticleConcepts' : 'true', 'includeArticleCategories' : 'true' , 'articleBodyLen' : '300', 'articlesCount' : '10' , 'apikey' : 'd9083f1b-74e1-46af-8190-dbcf992e077e' , },

      url: 'v2/top-headlines',
      query: { 'country' : 'eg' , 'category' : 'business' , 'apikey' : 'f998471c838e4f7dbcfd7908891793c5' , },

    ).then((value) {

      // print(value.data['articles'][0]['title']);
      // print(value.data.toString());

      // business = value.data;                       //********************* value of products ******************
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());

    }).catchError((onError){

      print('error is// ${onError.toString()}');
      emit(NewsGetBusinessErrorState(onError.toString()));

    });
  }


  List<dynamic> sport=[];

  void getSport(){

    emit(NewsGetSportsLoadingState());

    if(sport.isEmpty){
      DioHelper.getData(

        url: 'v2/top-headlines',
        query: { 'country' : 'eg' , 'category' : 'sports' , 'apikey' : 'f998471c838e4f7dbcfd7908891793c5' , },

      ).then((value) {


        sport = value.data['articles'];
        print(sport[0]['title']);

        emit(NewsGetSportsSuccessState());

      }).catchError((onError){

        print('error is// ${onError.toString()}');
        emit(NewsGetSportsErrorState(onError.toString()));

      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science=[];

  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(science.isEmpty){
      DioHelper.getData(

        url: 'v2/top-headlines',
        query: { 'country' : 'eg' , 'category' : 'science' , 'apikey' : 'f998471c838e4f7dbcfd7908891793c5' , },

      ).then((value) {


        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());

      }).catchError((onError){

        print('error is// ${onError.toString()}');
        emit(NewsGetScienceErrorState(onError.toString()));

      });
    }else{
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic> search=[];

  void getSearch(String value){

    emit(NewsGetSearchLoadingState());

    if(search.isEmpty){
      DioHelper.getData(

        url: 'v2/everything',
        query: { 'q' : value , 'apikey' : 'f998471c838e4f7dbcfd7908891793c5' , },

      ).then((value) {

        search = value.data['articles'];
        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());

      }).catchError((onError){
        print('error is// ${onError.toString()}');

        emit(NewsGetSearchErrorState(onError.toString()));

      });
    }else{
      emit(NewsGetSearchSuccessState());
    }

  }

}

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());


  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeAppMode({bool? fromShared}){

    if (fromShared!= null) {
      isDark = fromShared;
      emit(AppChangeModeState());

    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then( (value) {
        emit(AppChangeModeState());
      });
    }

  }

}