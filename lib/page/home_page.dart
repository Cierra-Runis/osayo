import 'package:osayo/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            AppIconWidget(),
            AppNameWidget(),
          ],
        ),
      ),
      body: const Column(
        children: [
          // SearchBar(),
          Expanded(
            child: MapListView(),
          ),
        ],
      ),
    );
  }
}
