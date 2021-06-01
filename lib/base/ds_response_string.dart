
import 'ds_response_object.dart';

class DSResponseString extends BaseResponse<String> {
  DSResponseString(code, message, status,path,results) : super(code, message, status,path,results);

  factory DSResponseString.fromJson(jsonMap) => $DSResponseStringFromJson(jsonMap);


  Map<String, dynamic> toJson() => $DSResponseStringToJson(this);
}

DSResponseString $DSResponseStringFromJson(Map<String, dynamic> jsonMap) {
  String code = jsonMap['code'] as String;
  String message = jsonMap['message'] as String;
  String status = jsonMap['status'] as String;
  String path = jsonMap['path'] as String;
  String results = jsonMap['results'] as String;
  return DSResponseString(code,message,status,path,results);
}

Map<String, dynamic> $DSResponseStringToJson(DSResponseString instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'path': instance.path,
      'results': instance.results,
    };
