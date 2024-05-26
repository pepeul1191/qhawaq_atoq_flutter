import 'package:sembast/sembast.dart';
import 'package:bson/bson.dart';
import '../models/entities/track.dart';
import '../models/entities/picture.dart';
import '../configs/app_database.dart';

class TrackRepository {
  static const String TRACK_STORE_NAME = 'tracks';
  final _trackStore = intMapStoreFactory.store(TRACK_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> insertTrack(Track track) async {
    await _trackStore.add(await _db, track.toMap());
  }

  Future<List<Track>> getTracks() async {
    final recordSnapshots = await _trackStore.find(await _db);

    return recordSnapshots.map((snapshot) {
      final track = Track.fromMap(snapshot.value);
      return track;
    }).toList();
  }

  Future<void> updateTrack(Track track) async {
    final finder = Finder(filter: Filter.equals('id', track.id.toHexString()));
    await _trackStore.update(await _db, track.toMap(), finder: finder);
  }

  Future<void> deleteTrack(ObjectId id) async {
    final finder = Finder(filter: Filter.equals('id', id.toHexString()));
    await _trackStore.delete(await _db, finder: finder);
  }

  Future<void> deleteAllTracks() async {
    await _trackStore.delete(await _db);
  }

  Future<void> embededPicture(Picture picture, DateTime created) async {
    List<Track> tracksToUpdate = [];
    // Encuentra todos los tracks en la base de datos
    final tracks = await _trackStore.find(await _db, finder: Finder());
    // Itera sobre los tracks y añade los que cumplan las condiciones a la lista tracksToUpdate
    for (var snapshot in tracks) {
      final track = Track.fromMap(snapshot.value);
      if (created.microsecondsSinceEpoch >
              track.created.microsecondsSinceEpoch &&
          track.picture == null) {
        track.picture = picture;
        tracksToUpdate.add(track);
        break; // Sale del bucle después de encontrar el primer track que cumpla las condiciones
      }
    }
    // Actualiza los tracks que están en tracksToUpdate
    for (var track in tracksToUpdate) {
      print('Updating track with picture: ${track.toMap()}');
      await _trackStore.update(await _db, track.toMap(),
          finder: Finder(filter: Filter.equals('id', track.id)));
      print('Track updated in the store.');
    }
  }
}
