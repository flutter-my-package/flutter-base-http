typedef DecodeFunction<T> = T Function(Map<String, dynamic>);
typedef EncodeFunction<T> = Map<String, dynamic> Function(T);

class DSResponseObject<T> extends BaseResponse<T> {
  DSResponseObject(code, message, status,path,results) : super(code, message, status,path,results);

  factory DSResponseObject.fromJson(Map<String, dynamic> jsonMap, DecodeFunction<T> decodeFunction) => $DSResponseObjectFromJson<T>(jsonMap, decodeFunction);

  Map<String, dynamic> toJson(EncodeFunction<T> encodeFun) =>
      $DSResponseObjectToJson<T>(this, encodeFun);
}

DSResponseObject<T> $DSResponseObjectFromJson<T>(Map<String, dynamic> jsonMap, DecodeFunction<T> decodeFunction){
  String code = jsonMap['code'] as String;
  String message = jsonMap['message'] as String;
  String status = jsonMap['status'] as String;
  String path = jsonMap['path'] as String;
  dynamic results;
  if(jsonMap['results'] != null && decodeFunction != null){
    results = decodeFunction(jsonMap['results']);
  }
  return  DSResponseObject<T>(code,message,status,path,results);
}

Map<String, dynamic> $DSResponseObjectToJson<T>(
        DSResponseObject<T> instance, EncodeFunction<T> encodeFunction) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
      'path': instance.path,
      'results': encodeFunction(instance.results)
    };

class BaseResponse<T> {
  final String code;
  final String message;
  final String status;
  final String path;
  final T results;

  BaseResponse(this.code, this.message, this.status,this.path,this.results);

  bool get isSuccess => (code == '200' || status == 'success') ;
}
