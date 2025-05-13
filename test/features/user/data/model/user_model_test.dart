import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/features/user/data/models/user_model.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

typedef MapJson = Map<String, dynamic>;

void main() {
  final tUserModel = UserModel(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  final tUserEntity = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  group('UserModel', () {
    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap = json.decode(fixture('user.json')) as MapJson;

      //act
      final result = UserModel.fromJson(jsonMap);

      //assert
      expect(result, isA<UserModel>());
      expect(result, equals(tUserModel));
    });

    test(
      'toJson should return a JSON map containing the proper data',
      () async {
        //arrange
        final jsonMap = json.decode(fixture('user.json')) as MapJson;

        //act
        final result = tUserModel.toJson();

        //assert
        expect(result, isA<MapJson>());
        expect(result, equals(jsonMap));
      },
    );

    test(
      'toUserEntity should return a UserEntity when conversion is successful',
      () async {
        //arrange & act
        final result = tUserModel.toUserEntity();

        //assert
        expect(result, isA<UserEntity>());
        expect(result, equals(tUserEntity));
      },
    );
  });
}
