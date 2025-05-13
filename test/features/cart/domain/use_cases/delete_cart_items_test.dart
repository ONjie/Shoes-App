import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';


class MockCartRepository extends Mock implements CartRepository{}

void main(){

  late DeleteCartItems deleteCartItems;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    deleteCartItems = DeleteCartItems(cartRepository: mockCartRepository);
  });
 const tRowNumber = 1;

  test('should return Right(tRowNumber) from Shoes Cart Repository', () async {
    //arrange
    when(() => mockCartRepository.deleteCartItems())
        .thenAnswer((_) async => const Right(tRowNumber));

    //act
    final result = await deleteCartItems.call();


    //assert
    expect(result, equals(const Right(tRowNumber)));
    verify(() => mockCartRepository.deleteCartItems()).called(1);
    verifyNoMoreInteractions(mockCartRepository);


  });
}