import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/covidModel.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://coronavirus.m.pipedream.net/';

  Future<CovidModel> fetchCovidList() async {
    try {
      Response response = await _dio.get(_url);
      debugPrint("Covid response:${response.data}");
      return CovidModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CovidModel.withError("Data not found / Connection issue");
    }
  }
}