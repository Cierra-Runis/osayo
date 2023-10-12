import 'package:osayo/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'map_list.g.dart';

@riverpod
Future<MapList> fetchMapList(
  FetchMapListRef ref, {
  MapListQuery query = const MapListQuery(),
}) async {
  final response = await Dio(BaseOptions(baseUrl: Osayo.apiBaseUrl)).post(
    '/?post',
    data: query.toJson(),
  );
  return MapList.fromJson(response.data);
}
