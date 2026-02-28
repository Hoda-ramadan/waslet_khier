import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waslet_khier/const.dart';

class CustomHomeViewAppbar extends StatelessWidget implements PreferredSizeWidget  {
  const CustomHomeViewAppbar({super.key});
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: appcolor,
    elevation: 0 ,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
             IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_outlined, color: Colors.white),
                  ),
          
           IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_outlined, color: Colors.white),
                  ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                 Text('مرجبا', style: TextStyle(color: Colors.white),),
                 Text('norhan', style: TextStyle(color: Colors.white),)
              ],
            ),
            SizedBox(width: 8,),
            CircleAvatar(
            
              radius: 18,
               child: Image.asset('assets/images/Rectangle 2.png',
               width: 38,
               height: 38,
               fit: BoxFit.cover,
              ),
            )
          ],
        )
      ],
    ),
    );
            
  }
  

}