import 'package:sembast/sembast.dart';
import 'package:bson/bson.dart';
import '../models/entities/picture.dart';
import '../configs/app_database.dart';

class PictureRepository {
  static const String PICTURE_STORE_NAME = 'pictures';
  final _PictureStore = intMapStoreFactory.store(PICTURE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> insert(Picture Picture) async {
    await _PictureStore.add(await _db, Picture.toMap());
  }

  Future<List<Picture>> fecthAll() async {
    final recordSnapshots = await _PictureStore.find(await _db);

    return recordSnapshots.map((snapshot) {
      final picture = Picture.fromMap(snapshot.value);
      return picture;
    }).toList();
  }

  Future<void> update(Picture picture) async {
    final finder =
        Finder(filter: Filter.equals('id', picture.id.toHexString()));
    await _PictureStore.update(await _db, picture.toMap(), finder: finder);
  }

  Future<void> delete(ObjectId id) async {
    final finder = Finder(filter: Filter.equals('id', id.toHexString()));
    await _PictureStore.delete(await _db, finder: finder);
  }

  Future<void> deleteAll() async {
    await _PictureStore.delete(await _db);
  }
}
