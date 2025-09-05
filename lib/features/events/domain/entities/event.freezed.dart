// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {
  String get id;
  String get name;
  String get albumThumbnailUrl;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventCopyWith<Event> get copyWith =>
      _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.albumThumbnailUrl, albumThumbnailUrl) ||
                other.albumThumbnailUrl == albumThumbnailUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, albumThumbnailUrl);

  @override
  String toString() {
    return 'Event(id: $id, name: $name, albumThumbnailUrl: $albumThumbnailUrl)';
  }
}

/// @nodoc
abstract mixin class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) =
      _$EventCopyWithImpl;
  @useResult
  $Res call({String id, String name, String albumThumbnailUrl});
}

/// @nodoc
class _$EventCopyWithImpl<$Res> implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? albumThumbnailUrl = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      albumThumbnailUrl: null == albumThumbnailUrl
          ? _self.albumThumbnailUrl
          : albumThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Event implements Event {
  const _Event(
      {required this.id, required this.name, required this.albumThumbnailUrl});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String albumThumbnailUrl;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EventCopyWith<_Event> get copyWith =>
      __$EventCopyWithImpl<_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.albumThumbnailUrl, albumThumbnailUrl) ||
                other.albumThumbnailUrl == albumThumbnailUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, albumThumbnailUrl);

  @override
  String toString() {
    return 'Event(id: $id, name: $name, albumThumbnailUrl: $albumThumbnailUrl)';
  }
}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) =
      __$EventCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String albumThumbnailUrl});
}

/// @nodoc
class __$EventCopyWithImpl<$Res> implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? albumThumbnailUrl = null,
  }) {
    return _then(_Event(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      albumThumbnailUrl: null == albumThumbnailUrl
          ? _self.albumThumbnailUrl
          : albumThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
