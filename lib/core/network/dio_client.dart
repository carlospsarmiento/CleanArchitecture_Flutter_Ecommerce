import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class DioClient{
   final Dio _dio;

   DioClient(): _dio = Dio(
     BaseOptions(
       baseUrl: ApiEndpoints.baseUrl,
       headers: {
         'Content-Type': 'application/json',
         'Accept': 'application/json'
       },
       connectTimeout: Duration(seconds: 6),
       receiveTimeout: Duration(seconds: 6),
       validateStatus: (int? status) {
          return status! > 0;
      }
     )
   );

  Dio get dio => _dio;

   /*
   DioClient(): _dio = Dio(
     BaseOptions(
       baseUrl: "https://myapi.com/v1"
     )
   ){
     test();
   }
   */

   /*
   void test(){
     _dio = Dio(
       BaseOptions(
         baseUrl: "https://otherapi.com/v1"
       )
     );
   }
   */
}