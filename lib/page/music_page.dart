import 'package:osayo/index.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Music>>(
              stream: isarService.listenToMusics(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final music = snapshot.data![index];
                      return BasedListTile(
                        leading: music.type.isLocal
                            ? Image.file(
                                File(music.coverPath),
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              )
                            : Image.network(
                                '${Osayo.apiStaticUrl}/beatmaps/${music.sid}/covers/cover.webp',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              ),
                        titleText: snapshot.data![index].name.toString(),
                        subtitleText: music.musicPath,
                        onTap: () {
                          print(music.musicPath);

                          audioPlayer.play(
                            music.type.isLocal
                                ? DeviceFileSource(music.musicPath)
                                : UrlSource(
                                    'https://dl.sayobot.cn/beatmaps/files/${music.sid}/${music.musicPath.isEmpty ? 'audio.ogg' : music.musicPath}',
                                  ),
                          );
                        },
                        onLongPress: () async {
                          print(music);
                          print(await isarService.deleteMusic(music.id));
                        },
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          StreamBuilder<AudioEvent>(
            stream: audioPlayer.eventStream,
            builder: (context, snapshot) {
              return BasedListTile(
                titleText: snapshot.data.toString(),
                onTap: () => audioPlayer.seek(Duration.zero),
              );
            },
          )
        ],
      ),
    );
  }
}
