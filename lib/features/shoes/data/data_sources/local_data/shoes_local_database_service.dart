import '../../../../../core/core.dart';
import '../../models/shoe_model.dart';

abstract class ShoesLocalDatabaseService {
  Future<FavoriteShoe> addShoeToFavoriteShoes({required ShoeModel shoe});

  Future<bool> deleteShoeFromFavoriteShoes({required int shoeId});

  Future<List<FavoriteShoe>> fetchFavoriteShoes();
}

class ShoesLocalDatabaseServiceImpl implements ShoesLocalDatabaseService {
  final AppDatabase appDatabase;

  ShoesLocalDatabaseServiceImpl({required this.appDatabase});

  @override
  Future<FavoriteShoe> addShoeToFavoriteShoes({required ShoeModel shoe}) async {
    try {
      return await appDatabase
          .into(appDatabase.favoriteShoes)
          .insertReturning(
            FavoriteShoesCompanion.insert(
              shoeId: shoe.id,
              title: shoe.title,
              image: shoe.images[0],
              price: shoe.price,
              ratings: shoe.ratings,
              isFavorite: 1,
            ),
          );
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteShoeFromFavoriteShoes({required int shoeId}) async {
    try {
      return await (appDatabase.delete(appDatabase.favoriteShoes)
            ..where((t) => t.shoeId.equals(shoeId))).go() ==
          1;
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<FavoriteShoe>> fetchFavoriteShoes() async {
    try {
      final favoriteShoes =
          await appDatabase.select(appDatabase.favoriteShoes).get();

      return favoriteShoes;
    } catch (e) {
      throw LocalDatabaseException(message: e.toString());
    }
  }
}
