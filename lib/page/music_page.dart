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
                      Osayo.printLog(music);

                      return BasedListTile(
                        leading: music.type.isLocal
                            ? ExtendedImage.file(
                                File(music.coverPath),
                                // errorBuilder: (context, error, stackTrace) =>
                                //     const SizedBox(),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ExtendedImage.network(
                                  '${Osayo.apiStaticUrl}/beatmaps/${music.sid}/covers/cover.webp',
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        titleText: music.name,
                        subtitleText: music.musicPath,
                        detailText: music.type.name,
                        onTap: () async {
                          await audioPlayer.play(
                            music.type.isLocal
                                ? DeviceFileSource(music.musicPath)
                                : UrlSource(
                                    'https://dl.sayobot.cn/beatmaps/files/${music.sid}/${music.musicPath.isEmpty ? 'audio.ogg' : music.musicPath}',
                                  ),
                          );
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
