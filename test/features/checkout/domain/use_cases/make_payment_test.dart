import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:shoes_app/features/checkout/domain/use_cases/make_payment.dart';

class MockCheckoutRepository extends Mock implements CheckoutRepository {}

void main() {
  late MakePayment makePayment;
  late MockCheckoutRepository mockCheckoutRepository;

  setUp(() {
    mockCheckoutRepository = MockCheckoutRepository();
    makePayment = MakePayment(checkoutRepository: mockCheckoutRepository);
  });

  const tTotalCost = 100;

  test('should return Right(true) from CheckoutRepository', () async {
    //arrange
    when(
      () => mockCheckoutRepository.makePayment(totalCost: tTotalCost),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await makePayment.call(totalCost: tTotalCost);

    //assert
    expect(result, isA<Right<Failure, bool>>());
    expect(result.right, equals(true));
    verify(
      () => mockCheckoutRepository.makePayment(totalCost: tTotalCost),
    ).called(1);
    verifyNoMoreInteractions(mockCheckoutRepository);
  });
}
