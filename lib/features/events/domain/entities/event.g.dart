// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
      id: json['id'] as String,
      name: json['name'] as String,
      albumThumbnailUrl: json['albumThumbnailUrl'] as String,
    );

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'albumThumbnailUrl': instance.albumThumbnailUrl,
    };
