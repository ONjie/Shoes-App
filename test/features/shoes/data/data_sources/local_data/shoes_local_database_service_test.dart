import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/shoes/data/data_sources/local_data/shoes_local_database_service.dart';
import 'package:shoes_app/features/shoes/data/models/shoe_model.dart';

void main() {
  late ShoesLocalDatabaseServiceImpl shoesLocalDatabaseServiceImpl;
  late AppDatabase appDatabase;

  setUp(() {
    appDatabase = AppDatabase.forTesting(NativeDatabase.memory());
    shoesLocalDatabaseServiceImpl = ShoesLocalDatabaseServiceImpl(
      appDatabase: appDatabase,
    );
  });

  tearDown(() async {
    await appDatabase.close();
  });

  const tShoeModel = ShoeModel(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: true,
    isNew: true,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tFavoriteShoe = FavoriteShoe(
    id: 1,
    shoeId: 1,
    title: 'title',
    image: 'image1',
    price: 100,
    ratings: 1.5,
    isFavorite: 1,
  );

  test(
    'addShoeToFavoriteShoes should add shoe to favorite shoes database',
    () async {
      //act
      final result = await shoesLocalDatabaseServiceImpl.addShoeToFavoriteShoes(
        shoe: tShoeModel,
      );

      //assert
      expect(result, isA<FavoriteShoe>());
      expect(result.shoeId, tShoeModel.id);
      expect(result.title, tShoeModel.title);
    },
  );

  test(
    'deleteShoeFromFavoriteShoes should delete shoe from favorite shoes database with the provided id',
    () async {
      const tShoeId = 1;
      //arrange
      await appDatabase.favoriteShoes.insertOne(
        FavoriteShoesCompanion.insert(
          shoeId: tShoeModel.id,
          title: tShoeModel.title,
          image: tShoeModel.images[0],
          price: tShoeModel.price,
          ratings: tShoeModel.ratings,
          isFavorite: 1,
        ),
      );

      //act
      final result = await shoesLocalDatabaseServiceImpl
          .deleteShoeFromFavoriteShoes(shoeId: tShoeId);

      //assert
      expect(result, isA<bool>());
      expect(result, isTrue);
    },
  );

  test(
    'fetchFavoriteShoes should return List<FavoriteShoe> from favorite shoes database',
    () async {
      //arrange
      await appDatabase.favoriteShoes.insertOne(
        FavoriteShoesCompanion.insert(
          shoeId: tShoeModel.id,
          title: tShoeModel.title,
          image: tShoeModel.images[0],
          price: tShoeModel.price,
          ratings: tShoeModel.ratings,
          isFavorite: 1,
        ),
      );

      //act
      final result = await shoesLocalDatabaseServiceImpl.fetchFavoriteShoes();

      //assert
      expect(result, equals(isA<List<FavoriteShoe>>()));
      expect(result, equals([tFavoriteShoe]));
    },
  );
}
