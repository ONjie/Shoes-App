import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/favorite_shoe_entity.dart';

import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchFavoriteShoes fetchFavoriteShoes;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();
    fetchFavoriteShoes = FetchFavoriteShoes(
      shoesRepository: mockShoesRepository,
    );
  });

  const tFavoriteShoe = FavoriteShoeEntity(
    id: 1,
    shoeId: 2,
    title: 'Title',
    image: 'image1',
    price: 100,
    ratings: 1.5,
    isFavorite: true,
  );

  final tFavoriteShoes = [tFavoriteShoe];

  test(
    'should return Right(List<FavoriteShoeEntity>) from ShoesRepository',
    () async {
      //arrange
      when(
        () => mockShoesRepository.fetchFavoriteShoes(),
      ).thenAnswer((_) async => Right(tFavoriteShoes));

      //act
      final result = await fetchFavoriteShoes.call();

      //assert
      expect(result, Right(tFavoriteShoes));
      verify(() => mockShoesRepository.fetchFavoriteShoes()).called(1);
      verifyNoMoreInteractions(mockShoesRepository);
    },
  );
}
