import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';
import 'package:shoes_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:shoes_app/features/orders/domain/use_cases/fetch_orders.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late FetchOrders fetchOrders;
  late MockOrdersRepository mockOrdersRepository;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
    fetchOrders = FetchOrders(ordersRepository: mockOrdersRepository);
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

  test(
    'should return Right(List<OrderEntity>) from OrdersRepository',
    () async {
      //arrange
      when(
        () => mockOrdersRepository.fetchOrders(),
      ).thenAnswer((_) async => Right([tOrder]));

      //act
      final result = await fetchOrders.call();

      //assert
      expect(result, isA<Right<Failure, List<OrderEntity>>>());
      expect(result.right, equals([tOrder]));
      verify(() => mockOrdersRepository.fetchOrders()).called(1);
      verifyNoMoreInteractions(mockOrdersRepository);
    },
  );
}
