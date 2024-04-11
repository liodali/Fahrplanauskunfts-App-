// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get disassembledName => throw _privateConstructorUsedError;
  List<double> get coord => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get matchQuality => throw _privateConstructorUsedError;
  List<int>? get productClasses => throw _privateConstructorUsedError;
  bool get isBest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? disassembledName,
      List<double> coord,
      String type,
      int matchQuality,
      List<int>? productClasses,
      bool isBest});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? disassembledName = freezed,
    Object? coord = null,
    Object? type = null,
    Object? matchQuality = null,
    Object? productClasses = freezed,
    Object? isBest = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      disassembledName: freezed == disassembledName
          ? _value.disassembledName
          : disassembledName // ignore: cast_nullable_to_non_nullable
              as String?,
      coord: null == coord
          ? _value.coord
          : coord // ignore: cast_nullable_to_non_nullable
              as List<double>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      matchQuality: null == matchQuality
          ? _value.matchQuality
          : matchQuality // ignore: cast_nullable_to_non_nullable
              as int,
      productClasses: freezed == productClasses
          ? _value.productClasses
          : productClasses // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      isBest: null == isBest
          ? _value.isBest
          : isBest // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
          _$LocationImpl value, $Res Function(_$LocationImpl) then) =
      __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? disassembledName,
      List<double> coord,
      String type,
      int matchQuality,
      List<int>? productClasses,
      bool isBest});
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
      _$LocationImpl _value, $Res Function(_$LocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? disassembledName = freezed,
    Object? coord = null,
    Object? type = null,
    Object? matchQuality = null,
    Object? productClasses = freezed,
    Object? isBest = null,
  }) {
    return _then(_$LocationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      disassembledName: freezed == disassembledName
          ? _value.disassembledName
          : disassembledName // ignore: cast_nullable_to_non_nullable
              as String?,
      coord: null == coord
          ? _value._coord
          : coord // ignore: cast_nullable_to_non_nullable
              as List<double>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      matchQuality: null == matchQuality
          ? _value.matchQuality
          : matchQuality // ignore: cast_nullable_to_non_nullable
              as int,
      productClasses: freezed == productClasses
          ? _value._productClasses
          : productClasses // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      isBest: null == isBest
          ? _value.isBest
          : isBest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationImpl implements _Location {
  _$LocationImpl(
      {required this.id,
      required this.name,
      this.disassembledName,
      required final List<double> coord,
      required this.type,
      required this.matchQuality,
      final List<int>? productClasses,
      required this.isBest})
      : _coord = coord,
        _productClasses = productClasses;

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? disassembledName;
  final List<double> _coord;
  @override
  List<double> get coord {
    if (_coord is EqualUnmodifiableListView) return _coord;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coord);
  }

  @override
  final String type;
  @override
  final int matchQuality;
  final List<int>? _productClasses;
  @override
  List<int>? get productClasses {
    final value = _productClasses;
    if (value == null) return null;
    if (_productClasses is EqualUnmodifiableListView) return _productClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isBest;

  @override
  String toString() {
    return 'Location(id: $id, name: $name, disassembledName: $disassembledName, coord: $coord, type: $type, matchQuality: $matchQuality, productClasses: $productClasses, isBest: $isBest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.disassembledName, disassembledName) ||
                other.disassembledName == disassembledName) &&
            const DeepCollectionEquality().equals(other._coord, _coord) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.matchQuality, matchQuality) ||
                other.matchQuality == matchQuality) &&
            const DeepCollectionEquality()
                .equals(other._productClasses, _productClasses) &&
            (identical(other.isBest, isBest) || other.isBest == isBest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      disassembledName,
      const DeepCollectionEquality().hash(_coord),
      type,
      matchQuality,
      const DeepCollectionEquality().hash(_productClasses),
      isBest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  factory _Location(
      {required final String id,
      required final String name,
      final String? disassembledName,
      required final List<double> coord,
      required final String type,
      required final int matchQuality,
      final List<int>? productClasses,
      required final bool isBest}) = _$LocationImpl;

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get disassembledName;
  @override
  List<double> get coord;
  @override
  String get type;
  @override
  int get matchQuality;
  @override
  List<int>? get productClasses;
  @override
  bool get isBest;
  @override
  @JsonKey(ignore: true)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
