import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';

class Listofcharitys extends StatelessWidget {
  const Listofcharitys({super.key, this.icon, this.color});
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, item) {
        return CharityItem(icon: icon, color: color);
=======
    return BlocBuilder<CharityCubit, CharityState>(
      builder: (context, state) {
       if (state is CharityLodaing)
          {
           return  Center(
              child: CircularProgressIndicator(
                color: tintAppColor, 
              ),
            );
          }
          if (state is CharitySuccess) {
        return ListView.builder(
          itemCount: state.charites.length,
          itemBuilder: (context, index) {
            return CharityItem(charityModel: state.charites[index],);
          },
        );
          }
            if (state is CharityFaild)
          {
            return 
            Center(
              child :Text (state.errorMessage.toString() , style: TextStyle(
                fontSize: 18, 
                color:  Colors.grey
              ),)
            );
          
          }
          else {
            return Center(
              child :Text ('There Was An Error ' , style: TextStyle(
                fontSize: 18, 
                color:  Colors.grey
              ),)
            ) ; 
          }

>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513
      },
    );
  }
}
