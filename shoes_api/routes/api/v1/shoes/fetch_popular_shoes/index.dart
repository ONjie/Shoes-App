import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';

Future<Response> onRequest( RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}


Future<Response> _onGet(RequestContext context) async {
  
  final shoesRepository = context.read<ShoesRepository>();

  final shoesOrFailure = await shoesRepository.fetchPopularShoes();

  return shoesOrFailure.fold(
    (failure) => Response.json(
      statusCode: HttpStatus.notFound,
      body: {'error': failure.message},
    ),
    (shoes) => Response.json(
      body: shoes.map((shoe) => shoe.toJson()).toList(),
    ),
  );

  
}