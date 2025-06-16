import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/checkout/data/data_sources/remote_data/stripe_payment_service.dart';
import 'package:shoes_app/features/checkout/data/repositories/checkout_repository_impl.dart';

class MockStripePaymentService extends Mock implements StripePaymentService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CheckoutRepositoryImpl checkoutRepositoryImpl;
  late MockStripePaymentService mockStripePaymentService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockStripePaymentService = MockStripePaymentService();
    mockNetworkInfo = MockNetworkInfo();

    checkoutRepositoryImpl = CheckoutRepositoryImpl(
      stripePaymentService: mockStripePaymentService,
      networkInfo: mockNetworkInfo,
    );
  });

  void runOnlineTest(Function body) {
    group('when the device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOnfflineTest(Function body) {
    group('when the device is onffline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('makePayment', () {
    const tTotalCost = 100;
    const tCalculatedAmount = '10000';
    const tClientSecret = 'clientSecret';
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      checkoutRepositoryImpl.makePayment(totalCost: tTotalCost);

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOnfflineTest(() {
      test(
        'should return Left(InternetConectionFailure) when device is offline',
        () async {
          //act
          final result = await checkoutRepositoryImpl.makePayment(
            totalCost: tTotalCost,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when payment is successful', () async {
        when(
          () => mockStripePaymentService.calculateAmount(totalCost: tTotalCost),
        ).thenAnswer((_) async => tCalculatedAmount);
        when(
          () => mockStripePaymentService.createPaymentIntent(
            amount: tCalculatedAmount,
            currency: currency,
          ),
        ).thenAnswer((_) async => tClientSecret);
        when(
          () => mockStripePaymentService.initPaymentSheet(
            clientSecret: tClientSecret,
          ),
        ).thenAnswer((_) async => true);
        when(
          () => mockStripePaymentService.processPayment(),
        ).thenAnswer((_) async => true);

        //act
        final result = await checkoutRepositoryImpl.makePayment(
          totalCost: tTotalCost,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(
          () => mockStripePaymentService.calculateAmount(totalCost: tTotalCost),
        ).called(1);
        verify(
          () => mockStripePaymentService.createPaymentIntent(
            amount: tCalculatedAmount,
            currency: currency,
          ),
        ).called(1);
        verify(
          () => mockStripePaymentService.initPaymentSheet(
            clientSecret: tClientSecret,
          ),
        ).called(1);
        verify(() => mockStripePaymentService.processPayment()).called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockStripePaymentService);
      });

      test('should return Left(StripePaymentFailure) when StripePaymentException is thrown', () async {
        when(
          () => mockStripePaymentService.calculateAmount(totalCost: tTotalCost),
        ).thenAnswer((_) async => tCalculatedAmount);
        when(
          () => mockStripePaymentService.createPaymentIntent(
            amount: tCalculatedAmount,
            currency: currency,
          ),
        ).thenThrow(StripePaymentException(message: 'Unexpected error'));
       

        //act
        final result = await checkoutRepositoryImpl.makePayment(
          totalCost: tTotalCost,
        );

        //assert
        expect(result, isA<Left<Failure, bool>>());
        expect(result.left, equals(StripePaymentFailure(message: 'Unexpected error')));
        verify(
          () => mockStripePaymentService.calculateAmount(totalCost: tTotalCost),
        ).called(1);
        verify(
          () => mockStripePaymentService.createPaymentIntent(
            amount: tCalculatedAmount,
            currency: currency,
          ),
        ).called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockStripePaymentService);
      });
    });
  });
}
