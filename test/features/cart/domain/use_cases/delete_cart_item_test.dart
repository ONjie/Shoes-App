import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';

import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';

class MockCartRepository extends Mock implements CartRepository{}


void main(){
  late DeleteCartItem deleteCartItem;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    deleteCartItem = DeleteCartItem(cartRepository: mockCartRepository);
  });


  test('should return Righ(true) from Shoes Cart Repository', () async {
    //arrange
    const tCartItemId = 1;
    when(() => mockCartRepository.deleteCartItem(cartItemId: any(named: 'cartItemId')))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await deleteCartItem.call(cartItemId: tCartItemId);


    //assert
    expect(result, equals(const Right(true)));
    verify(() => mockCartRepository.deleteCartItem(cartItemId: any(named: 'cartItemId')))
        .called(1);
    verifyNoMoreInteractions(mockCartRepository);


  });
}