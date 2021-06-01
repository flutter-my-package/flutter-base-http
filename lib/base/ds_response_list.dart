import 'ds_response_object.dart';

class DSResponseList<T> extends BaseResponse<List<T>> {
  DSResponseList(code, message, status,path,results) : super(code, message, status,path,results);

  factory DSResponseList.fromJson(jsonMap, DecodeFunction decodeFunction) =>
      $DSResponseListFromJson<T>(jsonMap, decodeFunction);

  Map<String, dynamic> toJson(EncodeFunction encodeFunction) =>
      $DSResponseListToJson<T>(this, encodeFunction);
}

DSResponseList<T> $DSResponseListFromJson<T>(
    Map<String, dynamic> jsonMap, DecodeFunction decodeFunction) {
  List<T> results = [];

  if (jsonMap['results'] != null) {
    results = List<T>.from(
        (jsonMap['results'] as List).map((item) => decodeFunction(item)));
  }

  return DSResponseList<T>(
      jsonMap['code'] as String,
      jsonMap['message'] as String,
      jsonMap['status'] as String, 
      jsonMap['path'] as String, results);
}

Map<String, dynamic> $DSResponseListToJson<T>(
        DSResponseList<T> instance, EncodeFunction encodeFunction) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'path': instance.path,
      'results': instance.results.map((item) => encodeFunction(item)).toList()
    };
