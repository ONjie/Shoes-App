import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onGet(RequestContext context) async {
  final prams = context.request.uri.queryParameters;
  final title = prams['title'] ?? '';

  if (title.isEmpty) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'title is required'},
    );
  }

  final shoesRepository = context.read<ShoesRepository>();

  final shoesOrFailure =
      await shoesRepository.fetchShoesSuggestions(title: title);

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
