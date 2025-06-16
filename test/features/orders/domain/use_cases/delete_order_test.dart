import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';
import 'package:shoes_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:shoes_app/features/orders/domain/use_cases/delete_order.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late DeleteOrder deleteOrder;
  late MockOrdersRepository mockOrdersRepository;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
    deleteOrder = DeleteOrder(ordersRepository: mockOrdersRepository);
  });

  const tOrderedItem = OrderedItemEntity(
    title: "title",
    image: 'image',
    color: 'color',
    price: 100,
    size: 10,
    quantity: 1,
  );

  final tOrder = OrderEntity(
    id: 1,
    orderId: 1234,
    estimatedDeliveryDate: DateTime.now(),
    orderStatus: 'orderStatus',
    paymentMethod: 'paymentMethod',
    deliveryDestination: 'destination',
    totalCost: tOrderedItem.price.toInt() + 20,
    orderedItems: [tOrderedItem],
  );

  test('should return Right(true) from OrdersRepository', () async {
    //arrange
    when(
      () => mockOrdersRepository.deleteOrder(orderId: tOrder.orderId),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await deleteOrder.call(orderId: tOrder.orderId);

    //assert
    expect(result, isA<Right<Failure, bool>>());
    expect(result.right, equals(true));
    verify(
      () => mockOrdersRepository.deleteOrder(orderId: tOrder.orderId),
    ).called(1);
    verifyNoMoreInteractions(mockOrdersRepository);
  });
}
