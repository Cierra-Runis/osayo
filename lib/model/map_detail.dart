import 'package:osayo/index.dart';
part 'map_detail.freezed.dart';
part 'map_detail.g.dart';

@freezed
class MapDetail with _$MapDetail {
  const factory MapDetail({
    @JsonKey(name: 'data') required MapDetailData data,
    @JsonKey(name: 'status') required int status,
  }) = _MapDetail;

  const MapDetail._();

  factory MapDetail.fromJson(Map<String, Object?> json) =>
      _$MapDetailFromJson(json);
}

@freezed
class MapDetailData with _$MapDetailData {
  const factory MapDetailData({
    @JsonKey(name: 'approved') required int approved,
    @JsonKey(name: 'approved_date') required int approvedDate,
    @JsonKey(name: 'artist') required String artist,
    @JsonKey(name: 'artistU') required String artistU,
    @JsonKey(name: 'bid_data') required List<MapDetailBidData> bidData,
    @JsonKey(name: 'bids_amount') required int bidsAmount,
    @JsonKey(name: 'bpm') required double bpm,
    @JsonKey(name: 'creator') required String creator,
    @JsonKey(name: 'creator_id') required int creatorId,
    @JsonKey(name: 'favourite_count') required int favouriteCount,
    @JsonKey(name: 'genre') required int genre,
    @JsonKey(name: 'language') required int language,
    @JsonKey(name: 'last_update') required int lastUpdate,
    @JsonKey(name: 'local_update') required int localUpdate,
    @JsonKey(name: 'preview') required int preview,
    @JsonKey(name: 'sid') required int sid,
    @JsonKey(name: 'source') required String source,
    @JsonKey(name: 'storyboard') required int storyboard,
    @JsonKey(name: 'tags') required String tags,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'titleU') required String titleU,
    @JsonKey(name: 'video') required int video,
  }) = _MapDetailData;

  const MapDetailData._();

  factory MapDetailData.fromJson(Map<String, Object?> json) =>
      _$MapDetailDataFromJson(json);
}

@freezed
class MapDetailBidData with _$MapDetailBidData {
  const factory MapDetailBidData({
    @JsonKey(name: 'AR') required double ar,
    @JsonKey(name: 'CS') required double cs,
    @JsonKey(name: 'HP') required double hp,
    @JsonKey(name: 'OD') required double od,
    @JsonKey(name: 'aim') required double aim,
    @JsonKey(name: 'audio') required String audio,
    @JsonKey(name: 'bg') required String bg,
    @JsonKey(name: 'bid') required int bid,
    @JsonKey(name: 'circles') required int circles,
    @JsonKey(name: 'hit300window') required int hit300window,
    @JsonKey(name: 'img') required String img,
    @JsonKey(name: 'length') required int length,
    @JsonKey(name: 'maxcombo') required int maxcombo,
    @JsonKey(name: 'mode') required int mode,
    @JsonKey(name: 'passcount') required int passcount,
    @JsonKey(name: 'playcount') required int playcount,
    @JsonKey(name: 'pp') required double pp,
    @JsonKey(name: 'pp_acc') required double ppAcc,
    @JsonKey(name: 'pp_aim') required double ppAim,
    @JsonKey(name: 'pp_speed') required double ppSpeed,
    @JsonKey(name: 'sliders') required int sliders,
    @JsonKey(name: 'speed') required double speed,
    @JsonKey(name: 'spinners') required int spinners,
    @JsonKey(name: 'star') required double star,
    @JsonKey(name: 'strain_aim') required String strainAim,
    @JsonKey(name: 'strain_speed') required String strainSpeed,
    @JsonKey(name: 'version') required String version,
  }) = _MapDetailBidData;

  const MapDetailBidData._();

  factory MapDetailBidData.fromJson(Map<String, Object?> json) =>
      _$MapDetailBidDataFromJson(json);
}
