import 'package:osayo/index.dart';
part 'music.g.dart';

@JsonSerializable()
@collection
class Music {
  const Music({
    required this.id,
    required this.sid,
    required this.type,
    required this.name,
    required this.coverPath,
    required this.musicPath,
    required this.musicLength,
  });

  /// 日记 `id`
  final Id id;

  final int sid;

  @enumerated
  final MusicType type;

  final String name;

  final String coverPath;

  final String musicPath;

  final int musicLength;

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);
  Map<String, dynamic> toJson() => _$MusicToJson(this);

  /// 转换用工厂函数
  factory Music.copyWith(
    Music music, {
    Id? id,
    int? sid,
    MusicType? type,
    String? name,
    String? coverPath,
    String? musicPath,
    int? musicLength,
  }) =>
      Music(
        id: id ?? music.id,
        sid: sid ?? music.sid,
        type: type ?? music.type,
        name: name ?? music.name,
        coverPath: coverPath ?? music.coverPath,
        musicPath: musicPath ?? music.musicPath,
        musicLength: musicLength ?? music.musicLength,
      );
}

enum MusicType {
  local,
  web;

  bool get isLocal => this == local;
  bool get isWeb => this == web;
}
