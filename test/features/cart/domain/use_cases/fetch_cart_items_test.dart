import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';

class MockCartRepository extends Mock implements CartRepository{}

void main(){
  late FetchCartItems fetchCartItems;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    fetchCartItems = FetchCartItems(cartRepository: mockCartRepository);
  });

  const tCartItem = CartItemEntity(
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  test('should return Right(List<CartItemEntity>) from Shoes Cart Repository', () async {
    //arrange
    when(() => mockCartRepository.fetchCartItems())
        .thenAnswer((_) async => const Right([tCartItem]));

    //act
    final result = await fetchCartItems.call();

    //assert
    expect(result, equals(const Right([tCartItem])));
    verify(() => mockCartRepository.fetchCartItems())
        .called(1);
    verifyNoMoreInteractions(mockCartRepository);
  });
}