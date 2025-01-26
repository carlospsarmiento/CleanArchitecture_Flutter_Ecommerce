import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/auth/domain/usecase/get_userlogged.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/user_avatar/user_avatar_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/user_avatar/user_avatar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatarWidget extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;

  const UserAvatarWidget({
    super.key,
    this.radius = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserAvatarCubit(di<GetUserLogged>())..loadUserAvatar(),
      child: BlocBuilder<UserAvatarCubit, UserAvatarState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              child: _buildAvatarContent(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarContent(BuildContext context, UserAvatarState state) {
    if (state is UserAvatarLoading) {
      return SizedBox(
        width: radius,
        height: radius,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    if (state is UserAvatarLoaded && state.user.image != null) {
      print("user");
      print(state.user.image);
      return ClipOval(
        child: Image.network(
          state.user.image!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
        ),
      );
    }

    return _buildDefaultAvatar();
  }

  Widget _buildDefaultAvatar() {
    return SvgPicture.asset(
      'assets/svg/default_avatar.svg',
      width: radius * 2,
      height: radius * 2,
    );
  }
}
