import 'package:osayo/index.dart';
part 'map_list.freezed.dart';
part 'map_list.g.dart';

@freezed
class MapList with _$MapList {
  const MapList._();

  const factory MapList({
    @JsonKey(name: 'data') required List<MapItem> data,
    @JsonKey(name: 'endid') required int endId,
    @JsonKey(name: 'match_artist_results') int? matchArtistResults,
    @JsonKey(name: 'match_creator_results') int? matchCreatorResults,
    @JsonKey(name: 'match_tags_results') int? matchTagsResults,
    @JsonKey(name: 'match_title_results') int? matchTitleResults,
    @JsonKey(name: 'match_version_results') int? matchVersionResults,
    @JsonKey(name: 'results') int? results,
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'time_cost') int? timeCostMilliSecond,
  }) = _MapList;

  factory MapList.fromJson(Map<String, Object?> json) =>
      _$MapListFromJson(json);
}
