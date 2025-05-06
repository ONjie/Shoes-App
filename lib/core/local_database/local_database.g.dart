// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $FavoriteShoesTable extends FavoriteShoes
    with TableInfo<$FavoriteShoesTable, FavoriteShoe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteShoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _shoeIdMeta = const VerificationMeta('shoeId');
  @override
  late final GeneratedColumn<int> shoeId = GeneratedColumn<int>(
    'shoe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingsMeta = const VerificationMeta(
    'ratings',
  );
  @override
  late final GeneratedColumn<double> ratings = GeneratedColumn<double>(
    'ratings',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shoeId,
    title,
    image,
    price,
    ratings,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_shoes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteShoe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shoe_id')) {
      context.handle(
        _shoeIdMeta,
        shoeId.isAcceptableOrUnknown(data['shoe_id']!, _shoeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shoeIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('ratings')) {
      context.handle(
        _ratingsMeta,
        ratings.isAcceptableOrUnknown(data['ratings']!, _ratingsMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingsMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteShoe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteShoe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      shoeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}shoe_id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      image:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price'],
          )!,
      ratings:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}ratings'],
          )!,
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_favorite'],
          )!,
    );
  }

  @override
  $FavoriteShoesTable createAlias(String alias) {
    return $FavoriteShoesTable(attachedDatabase, alias);
  }
}

class FavoriteShoe extends DataClass implements Insertable<FavoriteShoe> {
  final int? id;
  final int shoeId;
  final String title;
  final String image;
  final double price;
  final double ratings;
  final int isFavorite;
  const FavoriteShoe({
    this.id,
    required this.shoeId,
    required this.title,
    required this.image,
    required this.price,
    required this.ratings,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['shoe_id'] = Variable<int>(shoeId);
    map['title'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    map['price'] = Variable<double>(price);
    map['ratings'] = Variable<double>(ratings);
    map['is_favorite'] = Variable<int>(isFavorite);
    return map;
  }

  FavoriteShoesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteShoesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      shoeId: Value(shoeId),
      title: Value(title),
      image: Value(image),
      price: Value(price),
      ratings: Value(ratings),
      isFavorite: Value(isFavorite),
    );
  }

  factory FavoriteShoe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteShoe(
      id: serializer.fromJson<int?>(json['id']),
      shoeId: serializer.fromJson<int>(json['shoeId']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
      price: serializer.fromJson<double>(json['price']),
      ratings: serializer.fromJson<double>(json['ratings']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'shoeId': serializer.toJson<int>(shoeId),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
      'price': serializer.toJson<double>(price),
      'ratings': serializer.toJson<double>(ratings),
      'isFavorite': serializer.toJson<int>(isFavorite),
    };
  }

  FavoriteShoe copyWith({
    Value<int?> id = const Value.absent(),
    int? shoeId,
    String? title,
    String? image,
    double? price,
    double? ratings,
    int? isFavorite,
  }) => FavoriteShoe(
    id: id.present ? id.value : this.id,
    shoeId: shoeId ?? this.shoeId,
    title: title ?? this.title,
    image: image ?? this.image,
    price: price ?? this.price,
    ratings: ratings ?? this.ratings,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  FavoriteShoe copyWithCompanion(FavoriteShoesCompanion data) {
    return FavoriteShoe(
      id: data.id.present ? data.id.value : this.id,
      shoeId: data.shoeId.present ? data.shoeId.value : this.shoeId,
      title: data.title.present ? data.title.value : this.title,
      image: data.image.present ? data.image.value : this.image,
      price: data.price.present ? data.price.value : this.price,
      ratings: data.ratings.present ? data.ratings.value : this.ratings,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteShoe(')
          ..write('id: $id, ')
          ..write('shoeId: $shoeId, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('ratings: $ratings, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, shoeId, title, image, price, ratings, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteShoe &&
          other.id == this.id &&
          other.shoeId == this.shoeId &&
          other.title == this.title &&
          other.image == this.image &&
          other.price == this.price &&
          other.ratings == this.ratings &&
          other.isFavorite == this.isFavorite);
}

class FavoriteShoesCompanion extends UpdateCompanion<FavoriteShoe> {
  final Value<int?> id;
  final Value<int> shoeId;
  final Value<String> title;
  final Value<String> image;
  final Value<double> price;
  final Value<double> ratings;
  final Value<int> isFavorite;
  const FavoriteShoesCompanion({
    this.id = const Value.absent(),
    this.shoeId = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.price = const Value.absent(),
    this.ratings = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  FavoriteShoesCompanion.insert({
    this.id = const Value.absent(),
    required int shoeId,
    required String title,
    required String image,
    required double price,
    required double ratings,
    required int isFavorite,
  }) : shoeId = Value(shoeId),
       title = Value(title),
       image = Value(image),
       price = Value(price),
       ratings = Value(ratings),
       isFavorite = Value(isFavorite);
  static Insertable<FavoriteShoe> custom({
    Expression<int>? id,
    Expression<int>? shoeId,
    Expression<String>? title,
    Expression<String>? image,
    Expression<double>? price,
    Expression<double>? ratings,
    Expression<int>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shoeId != null) 'shoe_id': shoeId,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
      if (price != null) 'price': price,
      if (ratings != null) 'ratings': ratings,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  FavoriteShoesCompanion copyWith({
    Value<int?>? id,
    Value<int>? shoeId,
    Value<String>? title,
    Value<String>? image,
    Value<double>? price,
    Value<double>? ratings,
    Value<int>? isFavorite,
  }) {
    return FavoriteShoesCompanion(
      id: id ?? this.id,
      shoeId: shoeId ?? this.shoeId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shoeId.present) {
      map['shoe_id'] = Variable<int>(shoeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (ratings.present) {
      map['ratings'] = Variable<double>(ratings.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteShoesCompanion(')
          ..write('id: $id, ')
          ..write('shoeId: $shoeId, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('ratings: $ratings, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    true,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _shoeTitleMeta = const VerificationMeta(
    'shoeTitle',
  );
  @override
  late final GeneratedColumn<String> shoeTitle = GeneratedColumn<String>(
    'shoe_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shoeSizeMeta = const VerificationMeta(
    'shoeSize',
  );
  @override
  late final GeneratedColumn<int> shoeSize = GeneratedColumn<int>(
    'shoe_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shoeTitle,
    image,
    color,
    price,
    shoeSize,
    quantity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shoe_title')) {
      context.handle(
        _shoeTitleMeta,
        shoeTitle.isAcceptableOrUnknown(data['shoe_title']!, _shoeTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_shoeTitleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('shoe_size')) {
      context.handle(
        _shoeSizeMeta,
        shoeSize.isAcceptableOrUnknown(data['shoe_size']!, _shoeSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_shoeSizeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      ),
      shoeTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}shoe_title'],
          )!,
      image:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image'],
          )!,
      color:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}color'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price'],
          )!,
      shoeSize:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}shoe_size'],
          )!,
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}quantity'],
          )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final int? id;
  final String shoeTitle;
  final String image;
  final String color;
  final double price;
  final int shoeSize;
  final int quantity;
  const CartItem({
    this.id,
    required this.shoeTitle,
    required this.image,
    required this.color,
    required this.price,
    required this.shoeSize,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['shoe_title'] = Variable<String>(shoeTitle);
    map['image'] = Variable<String>(image);
    map['color'] = Variable<String>(color);
    map['price'] = Variable<double>(price);
    map['shoe_size'] = Variable<int>(shoeSize);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      shoeTitle: Value(shoeTitle),
      image: Value(image),
      color: Value(color),
      price: Value(price),
      shoeSize: Value(shoeSize),
      quantity: Value(quantity),
    );
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(
      id: serializer.fromJson<int?>(json['id']),
      shoeTitle: serializer.fromJson<String>(json['shoeTitle']),
      image: serializer.fromJson<String>(json['image']),
      color: serializer.fromJson<String>(json['color']),
      price: serializer.fromJson<double>(json['price']),
      shoeSize: serializer.fromJson<int>(json['shoeSize']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'shoeTitle': serializer.toJson<String>(shoeTitle),
      'image': serializer.toJson<String>(image),
      'color': serializer.toJson<String>(color),
      'price': serializer.toJson<double>(price),
      'shoeSize': serializer.toJson<int>(shoeSize),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  CartItem copyWith({
    Value<int?> id = const Value.absent(),
    String? shoeTitle,
    String? image,
    String? color,
    double? price,
    int? shoeSize,
    int? quantity,
  }) => CartItem(
    id: id.present ? id.value : this.id,
    shoeTitle: shoeTitle ?? this.shoeTitle,
    image: image ?? this.image,
    color: color ?? this.color,
    price: price ?? this.price,
    shoeSize: shoeSize ?? this.shoeSize,
    quantity: quantity ?? this.quantity,
  );
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      id: data.id.present ? data.id.value : this.id,
      shoeTitle: data.shoeTitle.present ? data.shoeTitle.value : this.shoeTitle,
      image: data.image.present ? data.image.value : this.image,
      color: data.color.present ? data.color.value : this.color,
      price: data.price.present ? data.price.value : this.price,
      shoeSize: data.shoeSize.present ? data.shoeSize.value : this.shoeSize,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('id: $id, ')
          ..write('shoeTitle: $shoeTitle, ')
          ..write('image: $image, ')
          ..write('color: $color, ')
          ..write('price: $price, ')
          ..write('shoeSize: $shoeSize, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, shoeTitle, image, color, price, shoeSize, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.id == this.id &&
          other.shoeTitle == this.shoeTitle &&
          other.image == this.image &&
          other.color == this.color &&
          other.price == this.price &&
          other.shoeSize == this.shoeSize &&
          other.quantity == this.quantity);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<int?> id;
  final Value<String> shoeTitle;
  final Value<String> image;
  final Value<String> color;
  final Value<double> price;
  final Value<int> shoeSize;
  final Value<int> quantity;
  const CartItemsCompanion({
    this.id = const Value.absent(),
    this.shoeTitle = const Value.absent(),
    this.image = const Value.absent(),
    this.color = const Value.absent(),
    this.price = const Value.absent(),
    this.shoeSize = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  CartItemsCompanion.insert({
    this.id = const Value.absent(),
    required String shoeTitle,
    required String image,
    required String color,
    required double price,
    required int shoeSize,
    required int quantity,
  }) : shoeTitle = Value(shoeTitle),
       image = Value(image),
       color = Value(color),
       price = Value(price),
       shoeSize = Value(shoeSize),
       quantity = Value(quantity);
  static Insertable<CartItem> custom({
    Expression<int>? id,
    Expression<String>? shoeTitle,
    Expression<String>? image,
    Expression<String>? color,
    Expression<double>? price,
    Expression<int>? shoeSize,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shoeTitle != null) 'shoe_title': shoeTitle,
      if (image != null) 'image': image,
      if (color != null) 'color': color,
      if (price != null) 'price': price,
      if (shoeSize != null) 'shoe_size': shoeSize,
      if (quantity != null) 'quantity': quantity,
    });
  }

  CartItemsCompanion copyWith({
    Value<int?>? id,
    Value<String>? shoeTitle,
    Value<String>? image,
    Value<String>? color,
    Value<double>? price,
    Value<int>? shoeSize,
    Value<int>? quantity,
  }) {
    return CartItemsCompanion(
      id: id ?? this.id,
      shoeTitle: shoeTitle ?? this.shoeTitle,
      image: image ?? this.image,
      color: color ?? this.color,
      price: price ?? this.price,
      shoeSize: shoeSize ?? this.shoeSize,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shoeTitle.present) {
      map['shoe_title'] = Variable<String>(shoeTitle.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (shoeSize.present) {
      map['shoe_size'] = Variable<int>(shoeSize.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('id: $id, ')
          ..write('shoeTitle: $shoeTitle, ')
          ..write('image: $image, ')
          ..write('color: $color, ')
          ..write('price: $price, ')
          ..write('shoeSize: $shoeSize, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteShoesTable favoriteShoes = $FavoriteShoesTable(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteShoes,
    cartItems,
  ];
}

typedef $$FavoriteShoesTableCreateCompanionBuilder =
    FavoriteShoesCompanion Function({
      Value<int?> id,
      required int shoeId,
      required String title,
      required String image,
      required double price,
      required double ratings,
      required int isFavorite,
    });
typedef $$FavoriteShoesTableUpdateCompanionBuilder =
    FavoriteShoesCompanion Function({
      Value<int?> id,
      Value<int> shoeId,
      Value<String> title,
      Value<String> image,
      Value<double> price,
      Value<double> ratings,
      Value<int> isFavorite,
    });

class $$FavoriteShoesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteShoesTable> {
  $$FavoriteShoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shoeId => $composableBuilder(
    column: $table.shoeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratings => $composableBuilder(
    column: $table.ratings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteShoesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteShoesTable> {
  $$FavoriteShoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shoeId => $composableBuilder(
    column: $table.shoeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratings => $composableBuilder(
    column: $table.ratings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteShoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteShoesTable> {
  $$FavoriteShoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get shoeId =>
      $composableBuilder(column: $table.shoeId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get ratings =>
      $composableBuilder(column: $table.ratings, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$FavoriteShoesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteShoesTable,
          FavoriteShoe,
          $$FavoriteShoesTableFilterComposer,
          $$FavoriteShoesTableOrderingComposer,
          $$FavoriteShoesTableAnnotationComposer,
          $$FavoriteShoesTableCreateCompanionBuilder,
          $$FavoriteShoesTableUpdateCompanionBuilder,
          (
            FavoriteShoe,
            BaseReferences<_$AppDatabase, $FavoriteShoesTable, FavoriteShoe>,
          ),
          FavoriteShoe,
          PrefetchHooks Function()
        > {
  $$FavoriteShoesTableTableManager(_$AppDatabase db, $FavoriteShoesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FavoriteShoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$FavoriteShoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$FavoriteShoesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                Value<int> shoeId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> ratings = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
              }) => FavoriteShoesCompanion(
                id: id,
                shoeId: shoeId,
                title: title,
                image: image,
                price: price,
                ratings: ratings,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required int shoeId,
                required String title,
                required String image,
                required double price,
                required double ratings,
                required int isFavorite,
              }) => FavoriteShoesCompanion.insert(
                id: id,
                shoeId: shoeId,
                title: title,
                image: image,
                price: price,
                ratings: ratings,
                isFavorite: isFavorite,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteShoesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteShoesTable,
      FavoriteShoe,
      $$FavoriteShoesTableFilterComposer,
      $$FavoriteShoesTableOrderingComposer,
      $$FavoriteShoesTableAnnotationComposer,
      $$FavoriteShoesTableCreateCompanionBuilder,
      $$FavoriteShoesTableUpdateCompanionBuilder,
      (
        FavoriteShoe,
        BaseReferences<_$AppDatabase, $FavoriteShoesTable, FavoriteShoe>,
      ),
      FavoriteShoe,
      PrefetchHooks Function()
    >;
typedef $$CartItemsTableCreateCompanionBuilder =
    CartItemsCompanion Function({
      Value<int?> id,
      required String shoeTitle,
      required String image,
      required String color,
      required double price,
      required int shoeSize,
      required int quantity,
    });
typedef $$CartItemsTableUpdateCompanionBuilder =
    CartItemsCompanion Function({
      Value<int?> id,
      Value<String> shoeTitle,
      Value<String> image,
      Value<String> color,
      Value<double> price,
      Value<int> shoeSize,
      Value<int> quantity,
    });

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shoeTitle => $composableBuilder(
    column: $table.shoeTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shoeSize => $composableBuilder(
    column: $table.shoeSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shoeTitle => $composableBuilder(
    column: $table.shoeTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shoeSize => $composableBuilder(
    column: $table.shoeSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shoeTitle =>
      $composableBuilder(column: $table.shoeTitle, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get shoeSize =>
      $composableBuilder(column: $table.shoeSize, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItem,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
          CartItem,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                Value<String> shoeTitle = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<int> shoeSize = const Value.absent(),
                Value<int> quantity = const Value.absent(),
              }) => CartItemsCompanion(
                id: id,
                shoeTitle: shoeTitle,
                image: image,
                color: color,
                price: price,
                shoeSize: shoeSize,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int?> id = const Value.absent(),
                required String shoeTitle,
                required String image,
                required String color,
                required double price,
                required int shoeSize,
                required int quantity,
              }) => CartItemsCompanion.insert(
                id: id,
                shoeTitle: shoeTitle,
                image: image,
                color: color,
                price: price,
                shoeSize: shoeSize,
                quantity: quantity,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItem,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
      CartItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteShoesTableTableManager get favoriteShoes =>
      $$FavoriteShoesTableTableManager(_db, _db.favoriteShoes);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
}
