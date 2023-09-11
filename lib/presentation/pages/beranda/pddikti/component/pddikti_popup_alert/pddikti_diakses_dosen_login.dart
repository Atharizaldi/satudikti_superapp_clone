import 'package:app/presentation/component/pop_up_alert/pop_up_alert_widgets.dart';
import 'package:flutter/material.dart';

class PDDiktiPopUpDosenLogin extends StatelessWidget {
  const PDDiktiPopUpDosenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cardAlertDialogLogin(
            context,
            "Silahkan login sebagai dosen untuk mengakses layanan ini",
          )
        ],
      ),
    );
  }
}
