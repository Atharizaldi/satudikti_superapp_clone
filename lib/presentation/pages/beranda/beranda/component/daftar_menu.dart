import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/component/beranda_loading.dart';
import 'package:app/presentation/pages/beranda/beranda/component/on_click_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget daftarMenu(BuildContext context, state) {
  BerandaBloc bloc = BlocProvider.of<BerandaBloc>(context);

  if (state is BerandaLoadedState) {
    if (bloc.isMenuListEmpty(state.listMenuFavorit)) {
      return modulLoading();
    } else {
      return AlignedGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 30,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
        ),
        itemCount: state.listMenuFavorit.length,
        itemBuilder: (context, index) {
          final MenuItems menuItems = state.listMenuFavorit[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
                width: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
                decoration: BoxDecoration(boxShadow: shadow3),
                child: InkEffect(
                  boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.purple),
                  onTap: () => onClickMenu(context, menuItems, state),
                  child: Image.asset(
                    menuItems.menuImage,
                    scale: MediaQuery.of(context).size.width > 600
                        ? 1.7
                        : menuItems.imageScale,
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                menuItems.menuName,
                style: TextStyle(
                  color: neutral40,
                  fontSize:
                      MediaQuery.of(context).size.width > 600 ? 16.sp : 11.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      );
    }
  } else {
    return modulLoading();
  }
}
