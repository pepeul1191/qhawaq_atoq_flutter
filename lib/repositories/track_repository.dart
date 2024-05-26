import 'package:sembast/sembast.dart';
import 'package:bson/bson.dart';
import '../models/entities/track.dart';
import '../configs/app_database.dart';

class TrackRepository {
  static const String TRACK_STORE_NAME = 'tracks';
  final _trackStore = intMapStoreFactory.store(TRACK_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> insert(Track track) async {
    await _trackStore.add(await _db, track.toMap());
  }

  Future<List<Track>> fetchAll() async {
    final recordSnapshots = await _trackStore.find(await _db);

    return recordSnapshots.map((snapshot) {
      final track = Track.fromMap(snapshot.value);
      return track;
    }).toList();
  }

  Future<void> update(Track track) async {
    final finder = Finder(filter: Filter.equals('id', track.id.toHexString()));
    await _trackStore.update(await _db, track.toMap(), finder: finder);
  }

  Future<void> delete(ObjectId id) async {
    final finder = Finder(filter: Filter.equals('id', id.toHexString()));
    await _trackStore.delete(await _db, finder: finder);
  }

  Future<void> deleteAll() async {
    await _trackStore.delete(await _db);
  }
}
