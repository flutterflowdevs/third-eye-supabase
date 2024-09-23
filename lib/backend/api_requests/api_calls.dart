import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start BuildShipApis Group Code

class BuildShipApisGroup {
  static String getBaseUrl() => 'https://3k9suj.buildship.run';
  static Map<String, String> headers = {};
  static TestToSpeechCall testToSpeechCall = TestToSpeechCall();
}

class TestToSpeechCall {
  Future<ApiCallResponse> call({
    String? text = '',
  }) async {
    final baseUrl = BuildShipApisGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "text": "$text"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Test to speech',
      apiUrl: '$baseUrl/text_to_speech',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End BuildShipApis Group Code

/// Start Open AI Group Code

class OpenAIGroup {
  static String getBaseUrl() => 'https://api.openai.com/v1/chat/';
  static Map<String, String> headers = {};
  static GetCategoryCall getCategoryCall = GetCategoryCall();
}

class GetCategoryCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? content = '',
    String? instructions =
        'You are an assistant for a blind person. Your job is to classify their requests into one of three categories. Emergency contact: If the request involves emergencies or help, return \'Emergency contact\'. Show me: If the request involves understanding the general surroundings or an explanation of what is in the vicinity, return \'Show me\'. Object Identification: If the request involves identifying or naming a specific object in front of them, such as What is this object called?, return \'Object Identification\'. Try again: If the request doesn’t fit any of the above categories, return \'Try again\'',
    String? languageCode = '',
  }) async {
    final baseUrl = OpenAIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "$instructions, response should be in language code $languageCode"
    },
    {
      "role": "user",
      "content": "$content"
    }
  ],
  "temperature": 0.7
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Category',
      apiUrl: '${baseUrl}completions',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Open AI Group Code

class GetResponseCall {
  static Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
    String? prompt = '',
    String? language = '',
  }) async {
    final ffApiRequestBody = '''
{
  "messages": [
    {
      "role": "user",
      "content": "$prompt. Return a response that could be read allowed in a total of about 13-15 seconds in $language (language code)"
    }
  ],
  "model": "gpt-4-1106-preview",
  "max_tokens": 100
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetResponse',
      apiUrl: 'https://api.openai.com/v1/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $apiKeyAuth',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.content''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
