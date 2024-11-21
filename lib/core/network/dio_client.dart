import 'package:dio/dio.dart';

class DioClient{
   final Dio _dio;

   DioClient(): _dio = Dio(
     BaseOptions(
       baseUrl: "",
       connectTimeout: Duration(seconds: 5),
       receiveTimeout: Duration(seconds: 3)
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