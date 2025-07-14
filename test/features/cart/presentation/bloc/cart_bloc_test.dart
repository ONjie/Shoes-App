import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';
import 'package:shoes_app/features/cart/presentation/bloc/cart_bloc.dart';

class MockAddCartItem extends Mock implements AddCartItem {}

class MockDeleteCartItems extends Mock implements DeleteCartItems {}

class MockDeleteCartItem extends Mock implements DeleteCartItem {}

class MockFetchCartItems extends Mock implements FetchCartItems {}

class MockUpdateCartItemQuantity extends Mock
    implements UpdateCartItemQuantity {}

void main() {
  late CartBloc cartBloc;
  late MockAddCartItem mockAddCartItem;
  late MockDeleteCartItems mockDeleteCartItems;
  late MockDeleteCartItem mockDeleteCartItem;
  late MockFetchCartItems mockFetchCartItems;
  late MockUpdateCartItemQuantity mockUpdateCartItemQuantity;

  setUp(() {
    mockAddCartItem = MockAddCartItem();
    mockDeleteCartItems = MockDeleteCartItems();
    mockDeleteCartItem = MockDeleteCartItem();
    mockFetchCartItems = MockFetchCartItems();
    mockUpdateCartItemQuantity = MockUpdateCartItemQuantity();
    cartBloc = CartBloc(
      addCartItem: mockAddCartItem,
      deleteCartItems: mockDeleteCartItems,
      deleteCartItem: mockDeleteCartItem,
      fetchCartItems: mockFetchCartItems,
      updateCartItemQuantity: mockUpdateCartItemQuantity,
    );
  });

  const tCartItemOne = CartItemEntity(
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.00,
    shoeSize: 14,
    quantity: 1,
  );
  const tCartItemTwo = CartItemEntity(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.00,
    shoeSize: 14,
    quantity: 1,
  );

  group('_onAddCartItemToCartItems', () {
    const tInsertedId = 1;
    blocTest(
      'should emit [CartItemsStatus.cartItemAdded] when successful',
      setUp: () {
        when(
          () => mockAddCartItem.call(cartItem: tCartItemOne),
        ).thenAnswer((_) async => const Right(tInsertedId));
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(
            const AddCartItemToCartItemsEvent(cartItem: tCartItemOne),
          ),
      expect:
          () => [
            CartState(
              cartItemsStatus: CartItemsStatus.cartItemAdded,
              message: cartItemAddedSuccessfully,
            ),
          ],
    );

    blocTest(
      'should emit [CartItemsStatus.addCartIemToCartItemsError] when unsuccessful',
      setUp: () {
        when(() => mockAddCartItem.call(cartItem: tCartItemOne)).thenAnswer(
          (_) async =>
              Left(LocalDatabaseFailure(message: addCartItemErrorMessage)),
        );
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(
            const AddCartItemToCartItemsEvent(cartItem: tCartItemOne),
          ),
      expect:
          () => [
            CartState(
              cartItemsStatus: CartItemsStatus.addCartIemToCartItemsError,
              message: addCartItemErrorMessage,
            ),
          ],
    );
  });

  group('_onDeleteCartItems', () {
    blocTest(
      'should emit [CartItemsStatus.cartItemsDeleted] when successful',
      setUp: () {
        when(
          () => mockDeleteCartItems.call(),
        ).thenAnswer((_) async => const Right(1));
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add(DeleteCartItemsEvent()),
      expect:
          () => [
            const CartState(cartItemsStatus: CartItemsStatus.cartItemsDeleted),
          ],
    );

    blocTest(
      'should emit [CartItemsStatus.deleteCartItemsError] when unsuccessful',
      setUp: () {
        when(() => mockDeleteCartItems.call()).thenAnswer(
          (_) async => Left(
            LocalDatabaseFailure(message: deleteAllCartItemsErrorMessage),
          ),
        );
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add(DeleteCartItemsEvent()),
      expect:
          () => [
            CartState(
              cartItemsStatus: CartItemsStatus.deleteCartItemsError,
              message: deleteAllCartItemsErrorMessage,
            ),
          ],
    );
  });

  group('_onDeleteCartItem', () {
    blocTest(
      'should emit [CartItemsStatus.cartItemDeleted] when successful',
      setUp: () {
        when(
          () => mockDeleteCartItem.call(cartItemId: any(named: 'cartItemId')),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(DeleteCartItemEvent(cartItemId: tCartItemTwo.id!)),
      expect:
          () => [
            const CartState(cartItemsStatus: CartItemsStatus.cartItemDeleted),
          ],
    );

    blocTest(
      'should emit [CartItemsStatus.deleteCartItemError] when unsuccessful',
      setUp: () {
        when(
          () => mockDeleteCartItem.call(cartItemId: any(named: 'cartItemId')),
        ).thenAnswer(
          (_) async =>
              Left(LocalDatabaseFailure(message: deleteCartItemErrorMessage)),
        );
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(DeleteCartItemEvent(cartItemId: tCartItemTwo.id!)),
      expect:
          () => [
            CartState(
              cartItemsStatus: CartItemsStatus.deleteCartItemError,
              message: deleteCartItemErrorMessage,
            ),
          ],
    );
  });

  group('_onFetchCartItems', () {
    blocTest(
      'should emit [CartItemsStatus.loading, CartItemsStatus.cartItemsLoaded] when successful',
      setUp: () {
        when(
          () => mockFetchCartItems.call(),
        ).thenAnswer((_) async => const Right([tCartItemTwo]));
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add(FetchCartItemsEvent()),
      expect:
          () => [
            CartState(cartItemsStatus: CartItemsStatus.loading),
            const CartState(
              cartItemsStatus: CartItemsStatus.cartItemsFetched,
              cartItems: [tCartItemTwo],
              totalShoesPrice: 100,
              totalCost: 120,
              numberOfItems: 1,
            ),
          ],
    );

    blocTest(
      'should emit [CartItemsStatus.loading ,CartItemsStatus.fetchCartItemsError] when unsuccessful',
      setUp: () {
        when(() => mockFetchCartItems.call()).thenAnswer(
          (_) async => Left(
            LocalDatabaseFailure(message: fetchAllCartItemsErrorMessage),
          ),
        );
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add(FetchCartItemsEvent()),
      expect:
          () => [
            CartState(cartItemsStatus: CartItemsStatus.loading),
            CartState(
              cartItemsStatus: CartItemsStatus.fetchCartItemsError,
              message: fetchAllCartItemsErrorMessage,
            ),
          ],
    );
  });

  group('_onUpdateCartItemQuantity', () {
    const tQuantity = 1;
    blocTest(
      'should emit [CartItemsStatus.cartItemQuantityUpdated] when successful',
      setUp: () {
        when(
          () => mockUpdateCartItemQuantity.call(
            cartItemId: any(named: 'cartItemId'),
            quantity: any(named: 'quantity'),
          ),
        ).thenAnswer((_) async => const Right(1));
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(
            UpdateCartItemQuantityEvent(
              cartItemId: tCartItemTwo.id!,
              quantity: tQuantity,
            ),
          ),
      expect:
          () => [
            const CartState(
              cartItemsStatus: CartItemsStatus.cartItemQuantityUpdated,
            ),
          ],
    );

    blocTest(
      'should emit [CartItemsStatus.updateCartItemQuantityError] when unsuccessful',
      setUp: () {
        when(
          () => mockUpdateCartItemQuantity.call(
            cartItemId: any(named: 'cartItemId'),
            quantity: any(named: 'quantity'),
          ),
        ).thenAnswer(
          (_) async => Left(
            LocalDatabaseFailure(message: updateCartItemQuantityErrorMessage),
          ),
        );
      },
      build: () => cartBloc,
      act:
          (bloc) => bloc.add(
            UpdateCartItemQuantityEvent(
              cartItemId: tCartItemTwo.id!,
              quantity: tQuantity,
            ),
          ),
      expect:
          () => [
            CartState(
              cartItemsStatus: CartItemsStatus.updateCartItemQuantityError,
              message: updateCartItemQuantityErrorMessage,
            ),
          ],
    );
  });
}
