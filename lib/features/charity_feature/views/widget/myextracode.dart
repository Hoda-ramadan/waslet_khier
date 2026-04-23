import 'dart:convert';

import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

class MyExtraCodec extends Codec<Object?, Object?> {
  const MyExtraCodec();

  @override
  Converter<Object?, Object?> get encoder => const MyExtraEncoder();

  @override
  Converter<Object?, Object?> get decoder => const MyExtraDecoder();
}

class MyExtraEncoder extends Converter<Object?, Object?> {
  const MyExtraEncoder();

  @override
  Object? convert(Object? input) {
    if (input is CategoryMadel) {
      return {'type': 'CategoryMadel', 'data': input.toJson()};
    }
    return input;
  }
}

class MyExtraDecoder extends Converter<Object?, Object?> {
  const MyExtraDecoder();

  @override
  Object? convert(Object? input) {
    if (input is Map && input['type'] == 'CategoryMadel') {
      return CategoryMadel.fromJson(input['data'] as Map<String, dynamic>);
    }
    return input;
  }
}
