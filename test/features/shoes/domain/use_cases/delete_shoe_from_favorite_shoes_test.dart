import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late DeleteShoeFromFavoriteShoes deleteShoeFromFavoriteShoes;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();
    deleteShoeFromFavoriteShoes = DeleteShoeFromFavoriteShoes(
      shoesRepository: mockShoesRepository,
    );
  });

  test('should return true from ShoesRepository', () async {
    //arrange
    const tShoeId = 1;

    when(
      () => mockShoesRepository.deleteShoeFromFavoriteShoes(shoeId: tShoeId),
    ).thenAnswer((_) async => const Right(true));

    //act
    final result = await deleteShoeFromFavoriteShoes.call(shoeId: tShoeId);

    //assert
    expect(result, const Right(true));
    verify(
      () => mockShoesRepository.deleteShoeFromFavoriteShoes(shoeId: tShoeId),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
