import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_c8_online/model/api_exception.dart';
import '../model/articles_response.dart';
import '../model/sources_response.dart';

abstract class ApiManager {
  static const baseUrl = 'newsapi.org';
  static const apiKey = "4ba02a56473e4228a7a8748f2a12303f";

  static Future<SourcesResponse> getSources(String sourceId) async {
    Uri url = Uri.https(baseUrl, 'v2/top-headlines/sources',
        {"apiKey": apiKey, "category": sourceId});
    Response response = await get(url);
    Map json = jsonDecode(response.body);
    print("SourcesResponse: $json}");
    SourcesResponse responseDM = SourcesResponse.fromJson(json);
    if (responseDM.code != null) {
      throw ApiException(responseDM.code!);
    }
    return responseDM;
  }

  static Future<ArticlesResponse> getArticles(String sourceID) async {
    Response response = await get(Uri.parse(
        "https://$baseUrl/v2/everything?apiKey=$apiKey&sources=$sourceID"));
    print("ArticlesResponse: ${jsonDecode(response.body)}");

    var articlesResponseDm =
        ArticlesResponse.fromJson(jsonDecode(response.body));
    if (articlesResponseDm.code != null) {
      throw ApiException(articlesResponseDm.code!);
    }
    return articlesResponseDm;
  }
}
