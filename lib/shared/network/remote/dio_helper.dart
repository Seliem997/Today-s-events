import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
  static late Dio dio;

  static init(){

    dio =Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',               //  ************ abdallah mansour
        // baseUrl: 'https://fakestoreapi.com/',          //********************* for Product Api ************

        // baseUrl: 'https://eventregistry.org/',          //********************* for news Api ************

        receiveDataWhenStatusError: true,
      ),
    );

  }

  static Future<Response> getData(
      {required String url,
        dynamic query,
      }) async {
    return await dio.get(url,
      queryParameters: query,
    );
  }

}