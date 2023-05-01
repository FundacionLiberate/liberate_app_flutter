import 'package:json_annotation/json_annotation.dart';
part 'liberate_type.g.dart';

@JsonSerializable(explicitToJson: true)

class LiberateType{

  late String id;
  late String nombre;
  late String tipo;
  late String url;

  LiberateType();

  LiberateType.newType(this.nombre,this.tipo,this.url);

  factory LiberateType.fromJson(Map<String, dynamic> json) => _$LiberateTypeFromJson(json);
  Map<String, dynamic> toJson() => _$LiberateTypeToJson(this);

}