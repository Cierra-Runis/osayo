import 'package:osayo/index.dart';

class IsarService {
  late Future<Isar> _db;

  IsarService() {
    _db = openDB();
  }

  Future<int> saveMusic(Music music) async {
    final isar = await _db;
    return isar.writeTxn(() => isar.musics.put(music));
  }

  Future<bool> deleteMusic(Id id) async {
    final isar = await _db;
    return isar.writeTxn(() => isar.musics.delete(id));
  }

  Stream<List<Music>> listenToMusics() async* {
    final isar = await _db;
    yield* isar.musics.where().watch(fireImmediately: true);
  }

  /// 打开数据库
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      Directory directory;

      /// TIPS: 对 Android 而言为 /data/user/0/Android/data/pers.cierra_runis.mercurius/files
      /// TIPS: 对 Windows 而言为 C:\Users\{user_name}\Documents/Mercurius/
      if (Platform.isAndroid) {
        directory = await getApplicationDocumentsDirectory();
      } else if (Platform.isWindows) {
        directory = await getApplicationDocumentsDirectory();
        Directory dir = Directory('${directory.path}/${Osayo.appName}/');
        dir.createSync(recursive: true);
        directory = dir;
      } else {
        throw Exception('Unsupported Platform');
      }

      final isar = await Isar.open(
        [MusicSchema],
        inspector: true,
        name: Osayo.database,
        directory: directory.path,
        compactOnLaunch: const CompactCondition(
          /// 压缩能减小 1KB 及以上，且达到了 1KB 的体积就进行压缩
          minBytes: 1024,
          minFileSize: 1024,
        ),
      );

      return isar;
    }
    return Future.value(Isar.getInstance(Osayo.database));
  }
}
