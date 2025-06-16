import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/core/utils/text/info_messages.dart';
import 'package:shoes_app/features/checkout/domain/use_cases/make_payment.dart';
import 'package:shoes_app/features/checkout/presentation/bloc/checkout_bloc.dart';

class MockMakePayment extends Mock implements MakePayment {}

void main() {
  late CheckoutBloc checkoutBloc;
  late MockMakePayment mockMakePayment;

  setUp(() {
    mockMakePayment = MockMakePayment();
    checkoutBloc = CheckoutBloc(makePayment: mockMakePayment);
  });

  group('_onMakePayment', () {
    const tTotalCost = 100;
    blocTest(
      'should emit[CheckoutStatus.paymentFailed] when payment is unsuccessful',
      setUp: () {
        when(() => mockMakePayment.call(totalCost: tTotalCost)).thenAnswer(
          (_) async =>
              Left(StripePaymentFailure(message: 'Payment was unsuccessful')),
        );
      },
      build: () => checkoutBloc,
      act: (bloc) => checkoutBloc.add(MakePaymentEvent(totalCost: tTotalCost)),
      expect:
          () => <CheckoutState>[
            CheckoutState(
              checkoutStatus: CheckoutStatus.paymentFailed,
              message: 'Payment was unsuccessful',
            ),
          ],
    );

    blocTest(
      'should emit[CheckoutStatus.paymentSuccessful] when payment is unsuccessful',
      setUp: () {
        when(() => mockMakePayment.call(totalCost: tTotalCost)).thenAnswer(
          (_) async =>
              Right(true),
        );
      },
      build: () => checkoutBloc,
      act: (bloc) => checkoutBloc.add(MakePaymentEvent(totalCost: tTotalCost)),
      expect:
          () => <CheckoutState>[
            CheckoutState(
              checkoutStatus: CheckoutStatus.paymentSuccessful,
              message: paymentSuccessfulMessage,
            ),
          ],
    );
  });
}
