import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/cart/data/data_sources/local_data/cart_local_database_service.dart';
import 'package:shoes_app/features/cart/data/models/cart_item_model.dart';

void main() {
  late CartLocalDatabaseServiceImpl cartLocalDatabaseServiceImpl;
  late AppDatabase appDatabase;

  setUp(() {
    appDatabase = AppDatabase.forTesting(NativeDatabase.memory());
    cartLocalDatabaseServiceImpl = CartLocalDatabaseServiceImpl(
      appDatabase: appDatabase,
    );
  });

  tearDown(() async {
    await appDatabase.close();
  });

  const tCartItemModel = CartItemModel(
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

  test(
    'addCartItem should add cartItem to the Database and return the insertedId when successful',
    () async {
      //arrange
      const tValidInsertedId = 1;

      //act
      final result = await cartLocalDatabaseServiceImpl.addCartItem(
        cartItem: tCartItemModel,
      );

      //assert
      expect(result, isA<int>());
      expect(result, equals(tValidInsertedId));
    },
  );

  test(
    'deleteCartItems should delete all cartItems in the Cart Items Database and return the number of rows deleted when successful',
    () async {
      //arrange
      await appDatabase
          .into(appDatabase.cartItems)
          .insertReturning(
            CartItemsCompanion.insert(
              shoeTitle: tCartItemModel.shoeTitle,
              image: tCartItemModel.image,
              color: tCartItemModel.color,
              price: tCartItemModel.price,
              shoeSize: tCartItemModel.shoeSize,
              quantity: tCartItemModel.quantity,
            ),
          );

      //act
      final result = await cartLocalDatabaseServiceImpl.deleteCartItems();

      //assert
      expect(result, isA<int>());
      expect(result, equals(1));
    },
  );

  test(
    'deleteCartItem should delete a cartItem in the Cart Items Database with the provided cartItemId and return true when successful',
    () async {
      //arrange
      const tCartItemId = 1;
      await appDatabase
          .into(appDatabase.cartItems)
          .insertReturning(
            CartItemsCompanion.insert(
              shoeTitle: tCartItemModel.shoeTitle,
              image: tCartItemModel.image,
              color: tCartItemModel.color,
              price: tCartItemModel.price,
              shoeSize: tCartItemModel.shoeSize,
              quantity: tCartItemModel.quantity,
            ),
          );

      //act
      final result = await cartLocalDatabaseServiceImpl.deleteCartItem(
        cartItemId: tCartItemId,
      );

      //assert
      expect(result, isA<bool>());
      expect(result, isTrue);
    },
  );

  test(
    'fetchCartItems should return List<CartItem> from Cart Items Database when successful',
    () async {
      //arrange
      await appDatabase
          .into(appDatabase.cartItems)
          .insertReturning(
            CartItemsCompanion.insert(
              shoeTitle: tCartItemModel.shoeTitle,
              image: tCartItemModel.image,
              color: tCartItemModel.color,
              price: tCartItemModel.price,
              shoeSize: tCartItemModel.shoeSize,
              quantity: tCartItemModel.quantity,
            ),
          );

      //act
      final result = await cartLocalDatabaseServiceImpl.fetchCartItems();

      //assert
      expect(result, isA<List<CartItemModel>>());
      expect(result, equals([tCartItemTwo]));
    },
  );

  test(
    'updateCartItem should update a cartItem in the Cart Items Database and return true when successful',
    () async {
      //arrange
      final id = await appDatabase
          .into(appDatabase.cartItems)
          .insert(
            CartItemsCompanion.insert(
              shoeTitle: tCartItemModel.shoeTitle,
              image: tCartItemModel.image,
              color: tCartItemModel.color,
              price: tCartItemModel.price,
              shoeSize: tCartItemModel.shoeSize,
              quantity: tCartItemModel.quantity,
            ),
          );

      //act
      final result = await cartLocalDatabaseServiceImpl.updateCartItem(
        cartItem: CartItemModel(
          id: id,
          shoeTitle: tCartItemModel.shoeTitle,
          image: tCartItemModel.image,
          color: tCartItemModel.color,
          price: tCartItemModel.price,
          shoeSize: tCartItemModel.shoeSize,
          quantity: tCartItemModel.quantity,
        ),
      );

      //assert
      expect(result, isA<bool>());
      expect(result, equals(true));
    },
  );

  test(
    'updateCartItemQuantity should update a cartItem\'s quantity in the Cart Items Database and returns the row number when successful',
    () async {
      //arrange
      const tCartItemId = 1;
      const tQuantity = 2;
      await appDatabase
          .into(appDatabase.cartItems)
          .insert(
            CartItemsCompanion.insert(
              shoeTitle: tCartItemModel.shoeTitle,
              image: tCartItemModel.image,
              color: tCartItemModel.color,
              price: tCartItemModel.price,
              shoeSize: tCartItemModel.shoeSize,
              quantity: tCartItemModel.quantity,
            ),
          );

      //act
      final result = await cartLocalDatabaseServiceImpl.updateCartItemQuantity(
        cartItemId: tCartItemId,
        quantity: tQuantity,
      );

      //assert
      expect(result, isA<int>());
      expect(result, equals(1));
    },
  );
}
