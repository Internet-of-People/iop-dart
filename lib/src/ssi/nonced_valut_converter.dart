import 'package:json_annotation/json_annotation.dart';

class NoncedValueConverter<T> implements JsonConverter<T, Object> {
  const NoncedValueConverter();

  @override
  T fromJson(Object json) {
    if (json is String || json is int || json is double || json is bool) {
      return json as T;
    }

    throw Exception('NoncedValue does not support ${json.runtimeType}');
  }

  @override
  Object toJson(T object) {
    if (object is String ||
        object is int ||
        object is double ||
        object is bool) {
      return object as Object;
    }

    throw Exception('NoncedValue does not support ${object.runtimeType}');
  }
}
