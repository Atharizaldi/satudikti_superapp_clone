import 'dart:async';
import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/data/source/remote/model/profil/user_information.dart';
import 'package:app/domain/usecases/profil/get_user_avatar.dart';
import 'package:app/domain/usecases/profil/get_user_information.dart';
import 'package:app/domain/usecases/profil/get_user_information_detail.dart';
import 'package:app/domain/usecases/profil/logout_sso.dart';
import 'package:app/domain/usecases/profil/put_user_avatar.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/profil/sso/package/credentials.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  Logger log;
  InternetCheck internetCheck;
  GetUserInformation getUserInformationUseCase;
  GetUserInformationDetail getUserInformationDetail;
  LogoutSSO logoutSSO;
  GetUserAvatar getUserAvatar;
  PutUserAvatar putUserAvatar;
  late String namaDosen;
  late String avatarPhoto;
  late String univDosen;
  late String nidnDosen;

  ProfilBloc({
    required this.log,
    required this.internetCheck,
    required this.getUserInformationUseCase,
    required this.getUserInformationDetail,
    required this.logoutSSO,
    required this.getUserAvatar,
    required this.putUserAvatar,
  }) : super(ProilLoadingState()) {
    on<CheckIsLoggedInEvent>(_checkLoggedIn);
    on<LogInEvent>(_logIn);
    on<LogOutEvent>(_logOut);
    on<GetProfilDetailEvent>(_getProfilDetail);
    on<GetProfilInfoDetailEvent>(_getProfilInfoDetail);
    on<GetAvatarEvent>(_getAvatar);
  }

  void _checkLoggedIn(
      CheckIsLoggedInEvent event, Emitter<ProfilState> emit) async {
    String? userCredentials =
        await FlutterSecureStorage().read(key: "user_credentials");
    if (userCredentials != null) {
      log.i("_checkLoggedIn: user exist");
      Credentials credentials = Credentials.fromJson(userCredentials);
      add(GetProfilDetailEvent(credentials: credentials));
    } else {
      log.i("_checkLoggedIn: user null");
      emit(ProfilNotLogInState());
    }
    // bool isLoggedIn = event.username == "Leonardi";
    // if (isLoggedIn) {
    //   add(GetProfilDetailEvent());
    // } else {
    //   emit(ProfilNotLogInState());
    // }
  }

  void _logOut(LogOutEvent event, Emitter<ProfilState> emit) async {
    // await logoutSSO.execute();
    await FlutterSecureStorage().delete(key: "user_credentials");
    log.i("logout");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // await controller.clearCache()
    await FlutterSecureStorage().deleteAll();
    emit(ProfilNotLogInState());
  }

  void _getProfilDetail(
      GetProfilDetailEvent event, Emitter<ProfilState> emit) async {
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getUserInformationUseCase.execute(event.credentials);
      result.fold(
        (failure) {
          emit(ProfilErrorState());
        },
        (response) async {
          // Logger().e(response);
          add(GetProfilInfoDetailEvent(
              username: response.data!.username,
              userInformation: response.data));
        },
      );
    }
  }

  void _getProfilInfoDetail(
      GetProfilInfoDetailEvent event, Emitter<ProfilState> emit) async {
    final resultDetail = await getUserInformationDetail.execute(event.username);
    resultDetail.fold(
      (failure) {
        emit(ProfilErrorState());
      },
      (responseDetail) {
        add(
          GetAvatarEvent(
            userId: responseDetail.data!.userID,
            userInformation: event.userInformation!,
            userInformationDetail: responseDetail.data!,
          ),
        );
        Prefs.setNidnDosen(responseDetail.data!.nidn!);
        namaDosen = responseDetail.data!.nama!;
        univDosen = responseDetail.data!.namaPT!;
        nidnDosen = responseDetail.data!.nidn!;
      },
    );
  }

  Future<bool> _logIn(LogInEvent event, Emitter<ProfilState> emit) async {
    try {
      await FlutterSecureStorage().write(
        key: "user_credentials",
        value: event.credentials.toJson(),
      );
      add(GetProfilDetailEvent(credentials: event.credentials));
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> getFromGallery(String userId) async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'svg', 'png', 'heic', 'heif']);
    if (image == null) return;
    final file = image.files.first;
    File imageFile = File(image.files.single.path!);

    Logger().i("Get From Gallery: ${imageFile.lengthSync()} bytes");

    _cropFileAvatar(imageFile, userId);
  }

  Future<void> _cropFileAvatar(File avatar, String userId) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: avatar.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            showCropGrid: false,
            toolbarTitle: 'Edit',
            toolbarColor: blue2,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: blueLinear1,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        maxHeight: 1080,
        maxWidth: 1080);
    File imageFile = File(croppedFile!.path);

    var result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      imageFile.path + 'compressed.jpg',
      quality: 50,
    );
    File imageFileCompressed = result!;
    Logger().i(
        "Get From Gallery Compressed: ${imageFileCompressed.lengthSync()} bytes");

    print(imageFileCompressed);

    if (imageFileCompressed.lengthSync() <= 100000) {
      await putUserAvatar.execute(imageFileCompressed, userId);
      add(CheckIsLoggedInEvent());
    } else {
      print("kegedean cuy");
    }
  }

  void _getAvatar(GetAvatarEvent event, Emitter<ProfilState> emit) async {
    final resultAvatarUser = await getUserAvatar.execute(event.userId);

    late String userAvatarResponse;

    resultAvatarUser.fold(
      (failure) {
        emit(ProfilLoadedState(
            userInformation: event.userInformation!,
            userInformationDetail: event.userInformationDetail!,
            userAvatar: ""));
      },
      (userAvatarResponseResult) {
        userAvatarResponse = userAvatarResponseResult.data!;
        avatarPhoto = userAvatarResponseResult.data!;

        List<String> dataDosen = [
          namaDosen,
          userAvatarResponseResult.data!,
          univDosen,
          nidnDosen
        ];
        Prefs.setDataDosen(dataDosen);

        emit(ProfilLoadedState(
            userInformation: event.userInformation!,
            userInformationDetail: event.userInformationDetail!,
            userAvatar: userAvatarResponse));
      },
    );
  }
}
