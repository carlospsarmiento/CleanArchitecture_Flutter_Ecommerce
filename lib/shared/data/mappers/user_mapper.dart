import 'package:app_flutter/shared/data/model/user_model.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';

class UserMapper {
  static User toEntity(UserModel model) {
    return User(
      id: model.id,
      name: model.name,
      lastname: model.lastname,
      email: model.email,
      phone: model.phone,
      password: model.password,
      sessionToken: model.sessionToken,
    );
  }

  static UserModel toModel(User entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      lastname: entity.lastname,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
      sessionToken: entity.sessionToken,
    );
  }
}
