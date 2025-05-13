import 'package:drift/drift.dart';
import '../../../../../core/core.dart';
import '../../models/cart_item_model.dart';

abstract class CartLocalDatabaseService{

  Future<int> addCartItem({required CartItemModel cartItem});

  Future<List<CartItemModel>> fetchCartItems();

  Future<bool> updateCartItem({required CartItemModel cartItem});

  Future<bool> deleteCartItem({required int cartItemId});

  Future<int> updateCartItemQuantity({required int cartItemId, required int quantity});

  Future<int> deleteCartItems();
}


class CartLocalDatabaseServiceImpl implements CartLocalDatabaseService{
  final AppDatabase appDatabase;

  CartLocalDatabaseServiceImpl({required this.appDatabase});

  @override
  Future<int> addCartItem({required CartItemModel cartItem}) async {
    return await appDatabase.into(appDatabase.cartItems).insert(
      CartItemsCompanion.insert(
          shoeTitle: cartItem.shoeTitle,
          image: cartItem.image,
          color: cartItem.color,
          price: cartItem.price,
          shoeSize: cartItem.shoeSize,
          quantity: cartItem.quantity,
      ),
    );
  }

  @override
  Future<int> deleteCartItems() async {
    return await appDatabase.delete(appDatabase.cartItems).go();
  }

  @override
  Future<bool> deleteCartItem({required int cartItemId}) async {
   return await (appDatabase.delete(appDatabase.cartItems)
     ..where((t) => t.id.equals(cartItemId))).go() == 1;
  }

  @override
  Future<List<CartItemModel>> fetchCartItems() async {
   final fetchedCartItems = await appDatabase.select(appDatabase.cartItems).get();

   final cartItems = fetchedCartItems.map((fetchCartItem) => CartItemModel.fromCartItem(cartItem: fetchCartItem)).toList();
   return cartItems;
  }

  @override
  Future<bool> updateCartItem({required CartItemModel cartItem}) async {
    return await (appDatabase.update(appDatabase.cartItems).replace(
        CartItem(
            id: cartItem.id,
            shoeTitle: cartItem.shoeTitle,
            image: cartItem.image,
            color: cartItem.color,
            price: cartItem.price,
            shoeSize: cartItem.shoeSize,
            quantity: cartItem.quantity,
        ),
    )
    );
  }

  @override
  Future<int> updateCartItemQuantity({required int cartItemId, required int quantity}) async{
    return await (appDatabase.update(appDatabase.cartItems)
      ..where((t) => t.id.equals(cartItemId))).write(
      CartItemsCompanion(
        quantity: Value(quantity),
      )
    );
  }
}