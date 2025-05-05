import '../../core.dart';

String mapFailureToMessage({required Failure failure}) {
  if (failure is ServerFailure) {
    return failure.message;
  } else if (failure is DatabaseFailure) {
    return failure.message;
  } else if (failure is InternetConnectionFailure) {
    return noInternetConnectionMessage;
  } else if (failure is SupabaseAuthFailure) {
    return failure.message;
  } else if (failure is OtherFailure) {
    return failure.message;
  } else {
    return 'Unexpected Error';
  }
}
