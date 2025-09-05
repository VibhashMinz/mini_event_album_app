// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Photo _$PhotoFromJson(Map<String, dynamic> json) => _Photo(
      id: json['id'] as String,
      albumId: json['albumId'] as String,
      url: json['url'] as String,
      liked: json['liked'] as bool? ?? false,
    );

Map<String, dynamic> _$PhotoToJson(_Photo instance) => <String, dynamic>{
      'id': instance.id,
      'albumId': instance.albumId,
      'url': instance.url,
      'liked': instance.liked,
    };
