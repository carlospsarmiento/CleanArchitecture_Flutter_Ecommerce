import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class DioClient{
   final Dio _dio;

   DioClient(Function() getToken): _dio = Dio(
     BaseOptions(
       baseUrl: ApiEndpoints.baseUrl,
       headers: {
         'Content-Type': 'application/json',
         'Accept': 'application/json'
       },
       connectTimeout: Duration(seconds: 30),
       receiveTimeout: Duration(seconds: 30),
       validateStatus: (int? status) {
          return status! > 0;
      }
     )
   ){
     _dio.interceptors.add(
       InterceptorsWrapper(
         onRequest: (options, handler) async{
           //final token = await authRepository.getToken();
           final token = await getToken();
           if (token != null) {
             options.headers['Authorization'] = 'Bearer $token';
             print("session token: $token");
           }
           print("session token: $token");
           handler.next(options);
         }
       )
     );
   }

  Dio get dio => _dio;
}