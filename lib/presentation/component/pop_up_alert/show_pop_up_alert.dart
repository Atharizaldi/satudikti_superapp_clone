import 'package:app/presentation/component/login_card.dart';
import 'package:app/presentation/component/pop_up_alert/pop_up_alert_widgets.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showPopUpAlert(BuildContext context, String module) {
  final state = BlocProvider.of<ProfilBloc>(context).state;
  if (state is ProfilLoadedState) {
    if (state.userInformationDetail.role != "Dosen") {
      cardAlertDialogLogin(
        context,
        "Silahkan Log Out akun anda saat ini, kemudian login sebagai dosen untuk dapat mengakses seluruh fitur $module",
      );
    }
  } else {
    cardAlertDialogLogin(context,
        "Silahkan login sebagai dosen untuk dapat mengakses seluruh fitur $module",
        title: "Anda sedang mengakses modul $module", onTapButton: () async {
      authorizationUrl = await createClient();
      showSSOLoginPage(context, authorizationUrl);
    });
  }
}

Widget loginCardWithLogoutPopUp(BuildContext context, String module) {
  final state = BlocProvider.of<ProfilBloc>(context).state;

  if (state is ProfilLoadedState) {
    if (state.userInformationDetail.role != 'Dosen') {
      return LoginCard(
        isDosenOnlyModule: module == 'Selancar PAK' ||
                module == 'Kompetensi Dosen' ||
                module == 'SISTER'
            ? true
            : false,

        onTap: () => cardAlertDialogLogout(
          context,
          "Silahkan Log Out akun anda saat ini, kemudian login sebagai dosen untuk dapat mengakses seluruh fitur $module",
        ),
      );
    } else {
      // Added an handler here just in case if
      // the second handler (if the role isn't "Dosen")
      // is failed to handle the case (rarely happens)

      return SizedBox();
    }
  } else {
    return LoginCard(
      isDosenOnlyModule: module == 'Selancar PAK' ||
              module == 'Kompetensi Dosen' ||
              module == 'SISTER'
          ? true
          : false,
    );
  }
}
