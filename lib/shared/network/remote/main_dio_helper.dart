import 'package:dio/dio.dart';

import '../end_points.dart';

// Dio is an HTTP client, we declare in the init() giving the url to get the data from, and it getData we give him the method and queries.
class MainDioHelper
{
  static Dio ? dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: '$localhost/api/',   // JuniorProject default url.
        receiveDataWhenStatusError: true,
        receiveTimeout: 0, //50000,
        connectTimeout: 0, //30000,
        // validateStatus: (status)=>true, //Won't throw errors
      ),
    );
  }

  static Future<Response> getData({required String url,  Map<String,dynamic>? query}) async
  {
    dio?.options.headers=
    {
      'Accept':'application/json',
      'Connection' : 'keep-alive',
    };

    print('in Main Dio getData');
    return await dio!.get(
      url,
      queryParameters: query,
    ); //path is the method
  }



}