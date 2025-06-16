import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';
import 'package:shoes_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:shoes_app/features/orders/domain/use_cases/create_order.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late CreateOrder createOrder;
  late MockOrdersRepository mockOrdersRepository;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
    createOrder = CreateOrder(ordersRepository: mockOrdersRepository);
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
      () => mockOrdersRepository.createOrder(order: tOrder),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await createOrder.call(order: tOrder);

    //assert
    expect(result, isA<Right<Failure, bool>>());
    expect(result.right, equals(true));
    verify(() => mockOrdersRepository.createOrder(order: tOrder)).called(1);
    verifyNoMoreInteractions(mockOrdersRepository);
  });
}
