import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/checkout/data/data_sources/remote_data/stripe_payment_service.dart';

class MockStripe extends Mock implements Stripe {}

class MockDio extends Mock implements Dio {}

void main() {
  late StripePaymentServiceImpl stripePaymentServiceImpl;
  late MockStripe mockStripe;
  late MockDio mockDio;

  setUp(() {
    mockStripe = MockStripe();
    mockDio = MockDio();

    stripePaymentServiceImpl = StripePaymentServiceImpl(
      dio: mockDio,
      stripe: mockStripe,
    );
  });

  const tTotalAmount = 100;
  const tClientSecret = 'clientSecret';
  const tCurrency = 'usd';

  group('calculateAmount', () {
    test(
      'should convert the amount into cents and return it as a String',
      () async {
        //arrange & act
        final result = await stripePaymentServiceImpl.calculateAmount(
          totalCost: tTotalAmount,
        );

        //assert
        expect(result, isA<String>());
        expect(result, equals('10000'));
      },
    );
  });

  group('createPaymentIntent', () {
    test('should create a payment intent and return client secret', () async {
      //arrange
      when(
        () => mockDio.post(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          statusCode: HttpStatus.ok,
          requestOptions: RequestOptions(),
          data: {'client_secret': tClientSecret},
        ),
      );

      //act
      final result = await stripePaymentServiceImpl.createPaymentIntent(
        amount: tTotalAmount.toString(),
        currency: tCurrency,
      );

      //assert
      expect(result, isA<String>());
      expect(result, equals(tClientSecret));
      verify(
        () => mockDio.post(
          any(),
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test(
      'should throw StripePaymentException when DioException is thrown',
      () async {
        //arrange
        when(
          () => mockDio.post(
            any(),
            options: any(named: 'options'),
            data: any(named: 'data'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {'error': 'Unexpected Error'},
            ),
          ),
        );

        //act
        final result = stripePaymentServiceImpl.createPaymentIntent;

        //assert
        expect(
          () => result(amount: tTotalAmount.toString(), currency: tCurrency),
          throwsA(isA<StripePaymentException>()),
        );
        verify(
          () => mockDio.post(
            any(),
            options: any(named: 'options'),
            data: any(named: 'data'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDio);
      },
    );
  });
}
