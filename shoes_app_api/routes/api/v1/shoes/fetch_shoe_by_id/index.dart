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

  final prams = context.request.uri.queryParameters;
  final id = int.tryParse(prams['id'] ?? '');

  if(id == null){
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'id is required'},
    );
  }
  
  final shoesRepository = context.read<ShoesRepository>();

  final shoeOrFailure = await shoesRepository.fetchShoeById(id: id);

  return shoeOrFailure.fold(
    (failure) => Response.json(
      statusCode: HttpStatus.notFound,
      body: {'error': failure.message},
    ),
    (shoe) => Response.json(
      body: shoe.toJson(),
    ),
  );

  
}