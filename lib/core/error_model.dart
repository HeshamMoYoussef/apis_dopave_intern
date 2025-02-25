import 'package:json_annotation/json_annotation.dart';


part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  final String field;
  final String message;

  ErrorModel({required this.field, required this.message});

  /// Connect the generated [_$ErrorModelFromJson] function to the `fromJson`
  /// factory.
  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  /// Connect the generated [_$ErrorModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
