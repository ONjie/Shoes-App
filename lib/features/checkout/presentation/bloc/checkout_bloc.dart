import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_app/core/core.dart';

import '../../domain/use_cases/make_payment.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final MakePayment makePayment;
  CheckoutBloc({required this.makePayment})
    : super(CheckoutState(checkoutStatus: CheckoutStatus.initial)) {
    on<MakePaymentEvent>(_onMakePayment);
  }

  _onMakePayment(MakePaymentEvent event, Emitter<CheckoutState> emit) async {
    final isSucccessfulOrFailure = await makePayment.call(
      totalCost: event.totalCost,
    );

    isSucccessfulOrFailure.fold(
      (failure) {
        emit(
          CheckoutState(
            checkoutStatus: CheckoutStatus.paymentFailed,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isSucessful) {
        emit(
          CheckoutState(
            checkoutStatus: CheckoutStatus.paymentSuccessful,
            message: paymentSuccessfulMessage,
          ),
        );
      },
    );
  }
}
