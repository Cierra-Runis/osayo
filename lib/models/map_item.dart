import 'package:osayo/index.dart';
part 'map_item.freezed.dart';
part 'map_item.g.dart';

@freezed
class MapItem with _$MapItem {
  const MapItem._();

  const factory MapItem({
    @JsonKey(name: 'approved') required int approved,
    @JsonKey(name: 'artist') required String artist,
    @JsonKey(name: 'artistU') required String artistU,
    @JsonKey(name: 'creator') required String creator,
    @JsonKey(name: 'favourite_count') required int favouriteCount,
    @JsonKey(name: 'lastupdate') required int lastUpdateTimeStamp,
    @JsonKey(name: 'modes') required int modes,
    @JsonKey(name: 'play_count') required int playCount,
    @JsonKey(name: 'sid') required int sid,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'titleU') required String titleU,
  }) = _MapItem;

  DateTime get lastUpdate =>
      DateTime.fromMicrosecondsSinceEpoch(lastUpdateTimeStamp * 1000000);

  factory MapItem.fromJson(Map<String, Object?> json) =>
      _$MapItemFromJson(json);

  String get approvedLabel => switch (approved) {
        -2 => 'graveyard',
        -1 => 'WIP',
        0 => 'pending',
        1 => 'ranked',
        2 => 'approved',
        3 => 'qualified',
        4 => 'loved',
        int() => 'error',
      };
}

enum MapMode {
  osu,
  taiKo,
  ctb,
  mania;

  static List<MapMode> getMapModesBy(int num) {
    List<MapMode> mapModes = [];
    if (num & 1 != 0) mapModes.add(osu);
    if (num & 2 != 0) mapModes.add(taiKo);
    if (num & 4 != 0) mapModes.add(ctb);
    if (num & 8 != 0) mapModes.add(mania);
    return mapModes;
  }
}
