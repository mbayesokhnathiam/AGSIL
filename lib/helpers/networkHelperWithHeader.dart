import 'dart:io';
//import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class NetworkHelper {
  NetworkHelper(this.url, this.data, this.headers);

  final String? url;
  final Map? data;
  final Map<String, String>? headers;

  Future getData() async {
    http.Response response = await http.post(Uri(scheme: url), body: data, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body.toString();
      //print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      // print(response.body);
    }
  }
}

class NetworkHelperWithHeader {
  NetworkHelperWithHeader(this.url, this.data, this.header);


  final String url;
  final Map data;
  final Map<String, String> header;

  Future getData() async {
    http.Response response = await http.post(Uri.parse(url), headers: header, body:data);

    if (response.statusCode == 200) {
      String data = response.body.toString();
      //print(jsonDecode(data));
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class GetUserData {
  GetUserData(this.url, this.header);

  final String url;
  final Map<String, String> header;

  Future getData() async {


    http.Response response = await http.get(Uri.parse(url), headers:header);

    if (response.statusCode == 200) {
      String data = response.body.toString();

      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}
class GetData {
  GetData(this.url, this.token);
  final String url;
  final String token;
  Future getData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.getUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    request.headers.set(HttpHeaders.authorizationHeader, "Bearer ${token}");
    request.headers.set(HttpHeaders.connectionHeader, "Keep-Alive");


    var response1 = await request.close();
    client.close(force: true);
    if (response1.statusCode == 200) {
      return await response1.transform(utf8.decoder).join();;
    }
    else {
      return await response1.transform(utf8.decoder).join();;
    }
  }


  Future getData1() async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    var  response = await dio.get(url,options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": 'application/json',
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    }));



    if(response.statusCode == 401){
      return {"status":401};

    }
    return response.data;


  }
}

class PostData {
  PostData(this.url, this.token, this.body,);

  final String url;
  final String token;
  final body;

  Future postData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.postUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=utf-8");
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ${token}');
    request.headers.set("Connection", "Keep-Alive");
    request.headers.set("Keep-Alive", "timeout=5, max=1000");
    request.write(json.encode(body));
    var response1 = await request.close();


    client.close(force: true);

    if (response1.statusCode == 200) {

      return await response1.transform(utf8.decoder).join();
    } else if(response1.statusCode == 401){
      return 400;
    }
    else {
      return await response1.transform(utf8.decoder).join();
    }
  }
  Future postData1() async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };


    FormData formData = FormData.fromMap({
    //  "file":
     // await MultipartFile.fromFile(file.path, filename:fileName),

      "body":MultipartFile.fromString(
        jsonEncode(body),
        contentType: MediaType.parse('application/json; charset=utf-8'),

      ),
    },);
 


        var  response = await dio.post(url, data: formData,options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        }));
        print(response.data);
        return response.data;


  }
  Future postData2() async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };


//    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      //  "file":
      // await MultipartFile.fromFile(file.path, filename:fileName),

      "body":MultipartFile.fromString(
        jsonEncode(body),
        contentType: MediaType.parse('application/json'),

      ),
    },);


    var  response = await dio.post(url, data: body,options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": 'application/json',
    }));



    if(response.statusCode == 401){
      return {"status":401};

    }
    return response.data;


  }
  Future putData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.putUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ${token}');
    request.write(json.encode(body));

    var response1 = await request.close();


    client.close(force: true);



    if (response1.statusCode == 200) {

      return {"status":"OK"};


    }
    else {
      return await response1.transform(utf8.decoder).join();

    }
  }
  Future ddeleteData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.deleteUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write(json.encode(body));
    print(body);
    var response1 = await request.close();


    client.close(force: true);



    if (response1.statusCode == 200) {


      return await response1.transform(utf8.decoder).join();



    }
    else {


      return await response1.transform(utf8.decoder).join();

    }
  }


  Future upload() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    var request = await client.postUrl(Uri.parse(url));
    // request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write(body);
    var response1 = await request.close();


    client.close(force: true);


    if (response1.statusCode == 200) {

      return await response1.transform(utf8.decoder).join();



    }
    else {


      return null;

    }
  }
}

class RefreshToken {
  RefreshToken(this.url, this.header);

  final String url;
  final Map<String, String>? header;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url), headers:header);

    if (response.statusCode == 200) {
      String data = response.body.toString();

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}