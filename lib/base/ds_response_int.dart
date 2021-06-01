import 'ds_response_object.dart';

class DSResponseInt extends BaseResponse<int> {
  DSResponseInt(code, message, status,path,results) : super(code, message, status,path,results);

  factory DSResponseInt.fromJson(jsonMap) => $DSResponseIntFromJson(jsonMap);

  Map<String, dynamic> toJson() => $DSResponseIntToJson(this);
}

DSResponseInt $DSResponseIntFromJson(Map<String, dynamic> jsonMap) {
  String code = jsonMap['code'] as String;
  String message = jsonMap['message'] as String;
  String status = jsonMap['status'] as String;
  String path = jsonMap['path'] as String;
  int results = jsonMap['results'] as int;
  return DSResponseInt(code,message,status,path,results);
}

Map<String, dynamic> $DSResponseIntToJson(DSResponseInt instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'path': instance.path,
      'results': instance.results,
    };
