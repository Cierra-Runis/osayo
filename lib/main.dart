import 'package:osayo/index.dart';

final isarService = IsarService();
final audioPlayer = AudioPlayer();

void main() => runApp(const ProviderScope(child: OsayoApp()));

class OsayoApp extends StatelessWidget {
  const OsayoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      fontFamily: Osayo.fontFamily,
      appBarTheme: const AppBarTheme(centerTitle: true),
      useMaterial3: true,
    );

    final dartTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.deepPurple,
      ),
      fontFamily: Osayo.fontFamily,
      appBarTheme: const AppBarTheme(centerTitle: true),
      useMaterial3: true,
    );

    return MaterialApp(
      title: Osayo.appName,
      theme: theme,
      darkTheme: dartTheme,
      home: const SplashPage(child: RootPage()),
    );
  }
}

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({
    super.key,
    this.fontSize,
  });

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      Osayo.appName,
      style: TextStyle(fontSize: fontSize),
    );
  }
}

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    super.key,
    this.height = 42,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SvgPicture.asset(
      'assets/images/osayo_filled.svg',
      colorFilter: ColorFilter.mode(
        colorScheme.outline,
        BlendMode.srcIn,
      ),
      height: height,
    );
  }
}

class MapListView extends ConsumerWidget {
  const MapListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapList = ref.watch(
      MapListProvider(query: const MapListQuery(keyword: 'phony', limit: 200)),
    );

    return mapList.when(
      data: (data) => BasedListView(
        children: data.data.map((e) => MapItemCard(mapItem: e)).toList(),
      ),
      error: (error, stackTrace) => Center(child: Text('$error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class MapItemCard extends ConsumerWidget {
  const MapItemCard({
    super.key,
    required this.mapItem,
  });

  final MapItem mapItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () async {},
            child: Column(
              children: [
                ExtendedImage.network(
                  '${Osayo.apiStaticUrl}/beatmaps/${mapItem.sid}/covers/cover.webp',
                  width: constraints.maxWidth,
                  fit: BoxFit.cover,
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      onPressed: () async {
                        audioPlayer.play(
                          UrlSource(
                            '${Osayo.apiStaticUrl}/preview/${mapItem.sid}.mp3',
                          ),
                        );
                      },
                      icon: const Icon(Icons.music_note_rounded),
                    ),
                    NewWidget(mapItem: mapItem),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class NewWidget extends ConsumerWidget {
  const NewWidget({
    super.key,
    required this.mapItem,
  });

  final MapItem mapItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final response = await Dio(BaseOptions(baseUrl: Osayo.apiBaseUrl))
            .get('/v2/beatmapinfo?K=${mapItem.sid}');

        final mapDetail = MapDetail.fromJson(jsonDecode(response.data));

        final music = Music(
          id: Isar.autoIncrement,
          sid: mapDetail.data.sid,
          type: MusicType.web,
          name: mapDetail.data.artist,
          coverPath: mapDetail.data.bidData[0].bg,
          musicPath: mapDetail.data.bidData[0].audio,
          musicLength: mapDetail.data.bidData[0].length,
        );

        await isarService.saveMusic(music);
      },
      icon: const Icon(Icons.playlist_add_rounded),
    );
  }
}
