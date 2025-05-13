import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/cart/data/data_sources/local_data/cart_local_database_service.dart';
import 'package:shoes_app/features/cart/data/models/cart_item_model.dart';
import 'package:shoes_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';

class MockCartLocalDatabaseService extends Mock
    implements CartLocalDatabaseService {}

const databaseErrorMessage = 'Database Error';

void main() {
  late CartRepositoryImpl cartRepositoryImpl;
  late MockCartLocalDatabaseService mockCartLocalDatabaseService;

  setUp(() {
    mockCartLocalDatabaseService = MockCartLocalDatabaseService();
    cartRepositoryImpl = CartRepositoryImpl(
      cartLocalDatabaseService: mockCartLocalDatabaseService,
    );
  });

  const tCartItemEntityOne = CartItemEntity(
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tCartItemEntityTwo = CartItemEntity(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tCartItemOne = CartItemModel(
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tCartItemTwo = CartItemModel(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  group('addCartItem', () {
    const tValidInsertedId = 1;

    test('should return Left(DatabaseFailure) when insertedId <= 0 ', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
      ).thenAnswer((_) async => 0);

      //act
      final result = await cartRepositoryImpl.addCartItem(
        cartItem: tCartItemEntityOne,
      );

      //assert
      expect(result, equals(isA<Left<Failure, int>>()));
      expect(
        result.left,
        equals(LocalDatabaseFailure(message: addCartItemErrorMessage)),
      );
      verify(
        () => mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test('should return Right(insertedId) when insertedId > 0', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
      ).thenAnswer((_) async => 1);

      //act
      final result = await cartRepositoryImpl.addCartItem(
        cartItem: tCartItemEntityOne,
      );

      //assert
      expect(result, equals(isA<Right<Failure, int>>()));
      expect(result.right, equals(tValidInsertedId));
      verify(
        () => mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test(
      'should return Left(OtherFailure) when an Exception is thrown',
      () async {
        //arrange
        when(
          () =>
              mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
        ).thenThrow(Exception(databaseErrorMessage));

        //act
        final result = await cartRepositoryImpl.addCartItem(
          cartItem: tCartItemEntityOne,
        );

        //assert
        expect(
          result.left,
          equals(
            const OtherFailure(message: 'Exception: $databaseErrorMessage'),
          ),
        );
        verify(
          () =>
              mockCartLocalDatabaseService.addCartItem(cartItem: tCartItemOne),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );
  });

  group('deleteCartItems', () {
    const tDeletedRows = 1;

    test('should return Left(DatabaseFailure) when deleteRows <= 0', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.deleteCartItems(),
      ).thenAnswer((_) async => 0);

      //act
      final result = await cartRepositoryImpl.deleteCartItems();

      //assert
      expect(result, equals(isA<Left<Failure, int>>()));
      expect(
        result.left,
        equals(LocalDatabaseFailure(message: deleteAllCartItemsErrorMessage)),
      );
      verify(() => mockCartLocalDatabaseService.deleteCartItems()).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test('should return Right(deletedRows) when deleteRows > 0', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.deleteCartItems(),
      ).thenAnswer((_) async => 1);

      //act
      final result = await cartRepositoryImpl.deleteCartItems();

      //assert
      expect(result, equals(isA<Right<Failure, int>>()));
      expect(result.right, equals(tDeletedRows));
      verify(() => mockCartLocalDatabaseService.deleteCartItems()).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test(
      'should return Left(OtherFailure) when an Exception is thrown',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.deleteCartItems(),
        ).thenThrow(Exception(databaseErrorMessage));

        //act
        final result = await cartRepositoryImpl.deleteCartItems();

        //assert
        expect(
          result.left,
          equals(
            const OtherFailure(message: 'Exception: $databaseErrorMessage'),
          ),
        );
        verify(() => mockCartLocalDatabaseService.deleteCartItems()).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );
  });

  group('deleteCartItem', () {
    const tIsDeleted = true;

    test(
      'should return Left(DatabaseFailure) when isDeleted == false',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.deleteCartItem(
            cartItemId: any(named: 'cartItemId'),
          ),
        ).thenAnswer((_) async => !tIsDeleted);

        //act
        final result = await cartRepositoryImpl.deleteCartItem(
          cartItemId: tCartItemTwo.id!,
        );

        //assert
        expect(result, equals(isA<Left<Failure, bool>>()));
        expect(
          result.left,
          equals(LocalDatabaseFailure(message: deleteCartItemErrorMessage)),
        );
        verify(
          () => mockCartLocalDatabaseService.deleteCartItem(
            cartItemId: any(named: 'cartItemId'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test('should return Right(isDeleted) when isDeleted == true', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.deleteCartItem(
          cartItemId: any(named: 'cartItemId'),
        ),
      ).thenAnswer((_) async => tIsDeleted);

      //act
      final result = await cartRepositoryImpl.deleteCartItem(
        cartItemId: tCartItemEntityTwo.id!,
      );

      //assert
      expect(result, equals(isA<Right<Failure, bool>>()));
      expect(result.right, equals(tIsDeleted));
      verify(
        () => mockCartLocalDatabaseService.deleteCartItem(
          cartItemId: any(named: 'cartItemId'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test(
      'should return Left(DatabaseFailure) when isDeleted == false',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.deleteCartItem(
            cartItemId: any(named: 'cartItemId'),
          ),
        ).thenAnswer((_) async => !tIsDeleted);

        //act
        final result = await cartRepositoryImpl.deleteCartItem(
          cartItemId: tCartItemTwo.id!,
        );

        //assert
        expect(result, equals(isA<Left<Failure, bool>>()));
        expect(
          result.left,
          equals(LocalDatabaseFailure(message: deleteCartItemErrorMessage)),
        );
        verify(
          () => mockCartLocalDatabaseService.deleteCartItem(
            cartItemId: any(named: 'cartItemId'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test('should return Left(OtherFailure) when an Exception occurs', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.deleteCartItem(
          cartItemId: any(named: 'cartItemId'),
        ),
      ).thenThrow(Exception(databaseErrorMessage));

      //act
      final result = await cartRepositoryImpl.deleteCartItem(
        cartItemId: tCartItemTwo.id!,
      );

      //assert
      expect(
        result.left,
        equals(const OtherFailure(message: 'Exception: $databaseErrorMessage')),
      );
      verify(
        () => mockCartLocalDatabaseService.deleteCartItem(
          cartItemId: any(named: 'cartItemId'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });
  });

  group('fetchCartItems', () {
    test(
      'should return Left(DatabaseFailure) when fetchedCartItems is empty',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.fetchCartItems(),
        ).thenAnswer((_) async => []);

        //act
        final result = await cartRepositoryImpl.fetchCartItems();

        //assert
        expect(result, equals(isA<Left<Failure, List<CartItemEntity>>>()));
        expect(
          result.left,
          equals(LocalDatabaseFailure(message: fetchAllCartItemsErrorMessage)),
        );
        verify(() => mockCartLocalDatabaseService.fetchCartItems()).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test(
      'should return Right(List<CartItemEntity>) when fetchedCartItems is not empty',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.fetchCartItems(),
        ).thenAnswer((_) async => [tCartItemTwo]);

        //act
        final result = await cartRepositoryImpl.fetchCartItems();

        //assert
        expect(result, equals(isA<Right<Failure, List<CartItemEntity>>>()));
        expect(result.right, equals([tCartItemEntityTwo]));
        verify(() => mockCartLocalDatabaseService.fetchCartItems()).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test(
      'should return Left(OtherFailure) when an Exceptions occurs',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.fetchCartItems(),
        ).thenThrow(Exception(databaseErrorMessage));

        //act
        final result = await cartRepositoryImpl.fetchCartItems();

        //assert
        expect(
          result.left,
          equals(
            const OtherFailure(message: 'Exception: $databaseErrorMessage'),
          ),
        );
        verify(() => mockCartLocalDatabaseService.fetchCartItems()).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );
  });

  group('updateCartItem', () {
    const tIsUpdated = true;

    test(
      'should return Left(DatabaseFailure) when isUpdated == false',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.updateCartItem(
            cartItem: tCartItemTwo,
          ),
        ).thenAnswer((_) async => !tIsUpdated);

        //act
        final result = await cartRepositoryImpl.updateCartItem(
          cartItem: tCartItemEntityTwo,
        );

        //assert
        expect(result, equals(isA<Left<Failure, bool>>()));
        expect(
          result.left,
          equals(LocalDatabaseFailure(message: updateCartItemErrorMessage)),
        );
        verify(
          () => mockCartLocalDatabaseService.updateCartItem(
            cartItem: tCartItemTwo,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test('should return Right(isUpdated) when isUpdated == true', () async {
      //arrange
      when(
        () =>
            mockCartLocalDatabaseService.updateCartItem(cartItem: tCartItemTwo),
      ).thenAnswer((_) async => tIsUpdated);

      //act
      final result = await cartRepositoryImpl.updateCartItem(
        cartItem: tCartItemEntityTwo,
      );

      //assert
      expect(result, equals(isA<Right<Failure, bool>>()));
      expect(result.right, equals(tIsUpdated));
      verify(
        () =>
            mockCartLocalDatabaseService.updateCartItem(cartItem: tCartItemTwo),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test(
      'should return Left(DatabaseFailure) when isUpdated == false',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.updateCartItem(
            cartItem: tCartItemTwo,
          ),
        ).thenAnswer((_) async => !tIsUpdated);

        //act
        final result = await cartRepositoryImpl.updateCartItem(
          cartItem: tCartItemEntityTwo,
        );

        //assert
        expect(result, equals(isA<Left<Failure, bool>>()));
        expect(
          result.left,
          equals(LocalDatabaseFailure(message: updateCartItemErrorMessage)),
        );
        verify(
          () => mockCartLocalDatabaseService.updateCartItem(
            cartItem: tCartItemTwo,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );

    test('should return Left(OtherFailure) when an Exception occurs', () async {
      //arrange
      when(
        () =>
            mockCartLocalDatabaseService.updateCartItem(cartItem: tCartItemTwo),
      ).thenThrow(Exception(databaseErrorMessage));

      //act
      final result = await cartRepositoryImpl.updateCartItem(
        cartItem: tCartItemEntityTwo,
      );

      //assert
      expect(result, equals(isA<Left<Failure, bool>>()));
      expect(
        result.left,
        equals(const OtherFailure(message: 'Exception: $databaseErrorMessage')),
      );
      verify(
        () =>
            mockCartLocalDatabaseService.updateCartItem(cartItem: tCartItemTwo),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });
  });

  group('updateCartItemQuantity', () {
    const tQuantity = 1;
    const tRowId = 1;

    test('should return Left(DatabaseFailure) when rowId <= 0', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.updateCartItemQuantity(
          cartItemId: any(named: 'cartItemId'),
          quantity: any(named: 'quantity'),
        ),
      ).thenAnswer((_) async => 0);

      //act
      final result = await cartRepositoryImpl.updateCartItemQuantity(
        cartItemId: tCartItemTwo.id!,
        quantity: tQuantity,
      );

      //assert
      expect(result, equals(isA<Left<Failure, int>>()));
      expect(
        result.left,
        equals(
          LocalDatabaseFailure(message: updateCartItemQuantityErrorMessage),
        ),
      );
      verify(
        () => mockCartLocalDatabaseService.updateCartItemQuantity(
          cartItemId: any(named: 'cartItemId'),
          quantity: any(named: 'quantity'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test('should return Right(rowId) when rowId > 0', () async {
      //arrange
      when(
        () => mockCartLocalDatabaseService.updateCartItemQuantity(
          cartItemId: any(named: 'cartItemId'),
          quantity: any(named: 'quantity'),
        ),
      ).thenAnswer((_) async => tRowId);

      //act
      final result = await cartRepositoryImpl.updateCartItemQuantity(
        cartItemId: tCartItemTwo.id!,
        quantity: tQuantity,
      );

      //assert
      expect(result, equals(isA<Right<Failure, int>>()));
      expect(result.right, equals(tRowId));
      verify(
        () => mockCartLocalDatabaseService.updateCartItemQuantity(
          cartItemId: any(named: 'cartItemId'),
          quantity: any(named: 'quantity'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockCartLocalDatabaseService);
    });

    test(
      'should return Left(OtherFailure) when an Exception occcurs',
      () async {
        //arrange
        when(
          () => mockCartLocalDatabaseService.updateCartItemQuantity(
            cartItemId: any(named: 'cartItemId'),
            quantity: any(named: 'quantity'),
          ),
        ).thenThrow(Exception(databaseErrorMessage));

        //act
        final result = await cartRepositoryImpl.updateCartItemQuantity(
          cartItemId: tCartItemTwo.id!,
          quantity: tQuantity,
        );

        //assert
        expect(
          result.left,
          equals(
            const OtherFailure(message: 'Exception: $databaseErrorMessage'),
          ),
        );
        verify(
          () => mockCartLocalDatabaseService.updateCartItemQuantity(
            cartItemId: any(named: 'cartItemId'),
            quantity: any(named: 'quantity'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCartLocalDatabaseService);
      },
    );
  });
}
