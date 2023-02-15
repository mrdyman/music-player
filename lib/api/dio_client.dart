import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_player/features/Dashboard/data/models/music_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      responseType: ResponseType.plain,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

  Future<Music?> getMusic() async {
    Music? music;
    try {
      Response response = await _dio.get("/search",
          options: Options(
            headers: {"Accept": "application/json"},
          ),
          queryParameters: {
            "term": "lyodra",
            "media": "music",
            "country": "id",
            "limit": 10,
          });
      music = musicFromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return music;
  }
}
