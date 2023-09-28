import 'package:osayo/index.dart';

import 'page/root_page.dart';

AudioPlayer audioPlayer = AudioPlayer();

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
      themeMode: ThemeMode.light,
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
      fetchMapListProvider(query: const MapListQuery(keyword: 'kagura mea')),
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

class MapItemCard extends StatelessWidget {
  const MapItemCard({
    super.key,
    required this.mapItem,
  });

  final MapItem mapItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.network(
                '${Osayo.apiStaticUrl}/beatmaps/${mapItem.sid}/covers/cover.webp',
                width: constraints.maxWidth,
                fit: BoxFit.cover,
              ),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text(mapItem.sid.toString())),
                  Chip(
                    label:
                        Text(MapMode.getMapModesBy(mapItem.modes).toString()),
                  ),
                  Chip(label: Text(mapItem.title)),
                  Chip(label: Text(mapItem.titleU)),
                  Chip(label: Text(mapItem.artist)),
                  Chip(label: Text(mapItem.artistU)),
                  Chip(label: Text(mapItem.creator)),
                  Chip(label: Text(mapItem.favouriteCount.toString())),
                  Chip(label: Text(mapItem.approvedLabel)),
                  Chip(label: Text(mapItem.lastUpdate.toString())),
                  Chip(label: Text(mapItem.playCount.toString())),
                  IconButton(
                    onPressed: () async {
                      audioPlayer.play(
                        UrlSource(
                          '${Osayo.apiStaticUrl}/preview/${mapItem.sid}.mp3',
                        ),
                      );
                    },
                    icon: const Icon(Icons.music_note_rounded),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
