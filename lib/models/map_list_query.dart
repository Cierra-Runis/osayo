import 'package:osayo/index.dart';
part 'map_list_query.freezed.dart';
part 'map_list_query.g.dart';

@freezed
class MapListQuery with _$MapListQuery {
  const MapListQuery._();

  const factory MapListQuery({
    @JsonKey(name: 'cmd', required: false) @Default('beatmaplist') String cmd,
    @JsonKey(name: 'limit', required: false) @Default(25) int limit,
    @JsonKey(name: 'offset', required: false) @Default(0) int offset,
    @JsonKey(name: 'type', required: false) @Default('hot') String type,
    @JsonKey(name: 'keyword', required: false) String? keyword,
    @JsonKey(name: 'subType', required: false) @Default(0xffffffff) int subType,
    @JsonKey(name: 'mode', required: false) @Default(0xffffffff) int mode,
    @JsonKey(name: 'class', required: false) @Default(0xffffffff) int class_,
    @JsonKey(name: 'genre', required: false) @Default(0xffffffff) int genre,
    @JsonKey(name: 'language', required: false)
    @Default(0xffffffff)
    int language,
    @JsonKey(name: 'stars', required: false)
    @Default([0, 1000.0])
    List<double> stars,
    @JsonKey(name: 'ar', required: false) @Default([0, 1000.0]) List<double> ar,
    @JsonKey(name: 'od', required: false) @Default([0, 1000.0]) List<double> od,
    @JsonKey(name: 'cs', required: false) @Default([0, 1000.0]) List<double> cs,
    @JsonKey(name: 'hp', required: false) @Default([0, 1000.0]) List<double> hp,
    @JsonKey(name: 'length', required: false)
    @Default([0, 1000.0])
    List<double> length,
    @JsonKey(name: 'bpm', required: false)
    @Default([0, 1000.0])
    List<double> bpm,
  }) = _MapListQuery;

  factory MapListQuery.fromJson(Map<String, Object?> json) =>
      _$MapListQueryFromJson(json);
}
