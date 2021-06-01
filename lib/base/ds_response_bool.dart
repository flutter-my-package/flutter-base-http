import 'ds_response_object.dart';

class DSResponseBool extends BaseResponse<bool> {
  DSResponseBool(code, message, status, path, results)
      : super(code, message, status, path, results);

  factory DSResponseBool.fromJson(jsonMap) => $DSResponseBoolFromJson(jsonMap);

  Map<String, dynamic> toJson() => $DSResponseBoolToJson(this);
}

DSResponseBool $DSResponseBoolFromJson(Map<String, dynamic> jsonMap) {
  String code = jsonMap['code'] as String;
  String message = jsonMap['message'] as String;
  String status = jsonMap['status'] as String;
  String path = jsonMap['path'] as String;
  bool results = jsonMap['results'] as bool;
  return DSResponseBool(code, message, status, path, results);
}

Map<String, dynamic> $DSResponseBoolToJson(DSResponseBool instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'path': instance.path,
      'results': instance.results,
    };
