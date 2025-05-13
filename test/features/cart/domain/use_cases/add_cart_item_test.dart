import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';

class MockCartRepository extends Mock implements CartRepository{}


void main(){
  late AddCartItem addCartItem;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    addCartItem = AddCartItem(cartRepository: mockCartRepository);
  });

  const tCartItem = CartItemEntity(
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tInsertedId = 1;

  test('should return Right(insertId) from Shoes Cart Repository', () async {
    //arrange
    when(() => mockCartRepository.addCartItem(cartItem: tCartItem))
        .thenAnswer((_) async => const Right(tInsertedId));

    //act
    final result = await addCartItem.call(cartItem: tCartItem);

    //assert
    expect(result, equals(const Right(tInsertedId)));
    verify(() => mockCartRepository.addCartItem(cartItem: tCartItem))
        .called(1);
    verifyNoMoreInteractions(mockCartRepository);
  });
}