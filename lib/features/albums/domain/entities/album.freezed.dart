// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Album {
  String get id;
  String get eventId;
  String get title;
  String get coverUrl;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AlbumCopyWith<Album> get copyWith =>
      _$AlbumCopyWithImpl<Album>(this as Album, _$identity);

  /// Serializes this Album to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Album &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, eventId, title, coverUrl);

  @override
  String toString() {
    return 'Album(id: $id, eventId: $eventId, title: $title, coverUrl: $coverUrl)';
  }
}

/// @nodoc
abstract mixin class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) _then) =
      _$AlbumCopyWithImpl;
  @useResult
  $Res call({String id, String eventId, String title, String coverUrl});
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res> implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._self, this._then);

  final Album _self;
  final $Res Function(Album) _then;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? title = null,
    Object? coverUrl = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _self.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _self.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Album implements Album {
  const _Album(
      {required this.id,
      required this.eventId,
      required this.title,
      required this.coverUrl});
  factory _Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  final String id;
  @override
  final String eventId;
  @override
  final String title;
  @override
  final String coverUrl;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AlbumCopyWith<_Album> get copyWith =>
      __$AlbumCopyWithImpl<_Album>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AlbumToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Album &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, eventId, title, coverUrl);

  @override
  String toString() {
    return 'Album(id: $id, eventId: $eventId, title: $title, coverUrl: $coverUrl)';
  }
}

/// @nodoc
abstract mixin class _$AlbumCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$AlbumCopyWith(_Album value, $Res Function(_Album) _then) =
      __$AlbumCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String eventId, String title, String coverUrl});
}

/// @nodoc
class __$AlbumCopyWithImpl<$Res> implements _$AlbumCopyWith<$Res> {
  __$AlbumCopyWithImpl(this._self, this._then);

  final _Album _self;
  final $Res Function(_Album) _then;

  /// Create a copy of Album
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? title = null,
    Object? coverUrl = null,
  }) {
    return _then(_Album(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _self.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _self.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
