// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Album _$AlbumFromJson(Map<String, dynamic> json) => _Album(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
    );

Map<String, dynamic> _$AlbumToJson(_Album instance) => <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
    };
