// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      disassembledName: json['disassembledName'] as String?,
      coord: (json['coord'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      type: json['type'] as String,
      matchQuality: json['matchQuality'] as int,
      productClasses: (json['productClasses'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      isBest: json['isBest'] as bool,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'disassembledName': instance.disassembledName,
      'coord': instance.coord,
      'type': instance.type,
      'matchQuality': instance.matchQuality,
      'productClasses': instance.productClasses,
      'isBest': instance.isBest,
    };
