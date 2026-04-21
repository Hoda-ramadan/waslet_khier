import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favCubit.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favitentest.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteview_body.dart';

class CaseItemTest extends StatelessWidget {
  const CaseItemTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Favcubit, FavorieState>(
      builder: (context, state) {
        if (state is favoritLodaing) {
          return const Center(
            child: CircularProgressIndicator(color: appcolor),
          );
        }

        if (state is FavoritSuccess) {
          if (state.favorit.isEmpty) {
            return FavoriteView_body();
          }

          return ListView.builder(
            itemCount: state.favorit.length,
            itemBuilder: (context, i) {
              final item = state.favorit[i];
              return favitemtext(item: item);
            },
          );
        }

        if (state is FavoritFaild) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                Text(state.errorMessage),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final donorId =
                        Provider.of<AuthProvider_info>(
                          context,
                          listen: false,
                        ).donor?.id ??
                        0;
                    context.read<Favcubit>().getfav(donorId);
                  },
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
