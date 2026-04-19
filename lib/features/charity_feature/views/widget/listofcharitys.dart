import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';

class Listofcharitys extends StatefulWidget {
  const Listofcharitys({super.key, required this.icon});

  final IconData icon;

  @override
  State<Listofcharitys> createState() => _ListofcharitysState();
}

class _ListofcharitysState extends State<Listofcharitys> {
  @override
  void initState() {
    super.initState();

    // safer after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharityCubit>().getCharites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharityCubit, CharityState>(
      builder: (context, state) {
        if (state is CharityLodaing) {
          return const Center(
            child: CircularProgressIndicator(color: tintAppColor),
          );
        }

        if (state is CharitySuccess) {
          return ListView.builder(
            itemCount: state.charites.length,
            itemBuilder: (context, index) {
              return CharityItem(
                charityModel: state.charites[index],
                icon: widget.icon ?? Icons.arrow_forward_ios,
              );
            },
          );
        }

        if (state is CharityFaild) {
          return Center(
            child: Text(
              state.errorMessage.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return const Center(
          child: Text(
            'There was an error',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      },
    );
  }
}
