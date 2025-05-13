import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';


class MockCartRepository extends Mock implements CartRepository{}

void main(){

  late UpdateCartItemQuantity updateCartItemQuantity;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    updateCartItemQuantity = UpdateCartItemQuantity(cartRepository: mockCartRepository);
  });
  const tRowNumber = 1;


  test('should return Right(tRowNumber) from Shoes Cart Repository', () async {
    //arrange
    const tCartItemId = 1;
    const tQuantity = 2;
    when(() => mockCartRepository.updateCartItemQuantity(
        cartItemId: any(named: 'cartItemId'),
        quantity: any(named: 'quantity'),),
    )
        .thenAnswer((_) async => const Right(tRowNumber));

    //act
    final result = await updateCartItemQuantity.call(cartItemId: tCartItemId, quantity: tQuantity);


    //assert
    expect(result, equals(const Right(tRowNumber)));
    verify(() => mockCartRepository.updateCartItemQuantity(
      cartItemId: any(named: 'cartItemId'),
      quantity: any(named: 'quantity'),),)
        .called(1);
    verifyNoMoreInteractions(mockCartRepository);


  });
}