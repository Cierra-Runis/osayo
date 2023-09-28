import 'package:osayo/index.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: const [
          HomePage(key: ValueKey(HomePage)),
          MusicPage(key: ValueKey(MusicPage)),
          SettingPage(key: ValueKey(SettingPage)),
        ][_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note_rounded),
            label: 'Music',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Setting',
          )
        ],
        onDestinationSelected: (value) =>
            setState(() => _selectedIndex = value),
      ),
    );
  }
}
