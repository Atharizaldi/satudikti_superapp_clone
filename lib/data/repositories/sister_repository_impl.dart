import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/biodata_sister.dart';
import 'package:app/data/source/remote/model/sister/bkd_rekrutmen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_diklat_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_formal_dosen_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pembimbingan_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengajaran_sister.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengujian_sister.dart';
import 'package:app/data/source/remote/model/sister/penelitian_sister.dart';
import 'package:app/data/source/remote/model/sister/penempatan_sister.dart';
import 'package:app/data/source/remote/model/sister/pengabdian_sister.dart';
import 'package:app/data/source/remote/model/sister/praktisi_sister.dart';
import 'package:app/data/source/remote/model/sister/profile_sister_detail.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SisterRepositoryImpl implements SisterRepository {
  final http.Client client;

  SisterRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, ProfileSisterDetail>> getProfileDetail(
      String nidn) async {
    var uri = Uri.parse('$urlStagging/selancar-pak/profile/$nidn');
    print("CEK==================");
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(ProfileSisterDetail.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PenempatanSister>> getPenempatan(String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/penempatan');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PenempatanSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, BiodataSister>> getBiodata(String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(BiodataSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PendidikanFormalDosenSister>> getPendidikanFormalDosen(
      String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/pendidikan/formal');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PendidikanFormalDosenSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PendidikanDiklatSister>> getPendidikanDiklat(
      String nidn, String displayBy, String judul) async {
    var uri = Uri.parse(
        '$urlAPI/v2/sister/dosen/$nidn/pendidikan/diklat?judul=$judul&display-by=$displayBy');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PendidikanDiklatSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PendidikanPengujianSister>> getPendidikanPengujian(
      String nidn, String displayBy, String judul) async {
    var uri = Uri.parse(
        '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pengujian?judul=$judul&display-by=$displayBy');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PendidikanPengujianSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PendidikanPengajaranSister>> getPendidikanPengajaran(
      String nidn, String matkul, String displayBy) async {
    var uri = Uri.parse(
        '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pengajaran?matkul=$matkul&display-by=$displayBy');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PendidikanPengajaranSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PendidikanPembimbinganSister>>
      getPendidikanPembimbingan(
          String nidn, String displayBy, String judul) async {
    var uri = Uri.parse(
        '$urlAPI/v2/sister/dosen/$nidn/pendidikan/pembimbingan?judul=$judul&display-by=$displayBy');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PendidikanPembimbinganSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PraktisiSister>> getPraktisi(String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/praktisi');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PraktisiSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PengabdianSister>> getPengabdian(String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/pengabdian');
    // var uri = Uri.parse(
    //     'https://1429ab0b-dc72-43df-b0ec-e5720984af57.mock.pstmn.io/pengabdian');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);
      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PengabdianSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, PenelitianSister>> getPenelitian(String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/penelitian');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(PenelitianSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, BKDPenilaianSister>> getBKDPenilaian(
      String nidn, String judul, String sortBy) async {
    var uri = Uri.parse(
        '$urlAPI/v2/sister/dosen/$nidn/bkd/penilaian?nama=$judul&display-by=$sortBy');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(BKDPenilaianSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, BKDRekrutmenSister>> getBKDRekrutmen(
      String nidn) async {
    var uri = Uri.parse('$urlAPI/v2/sister/dosen/$nidn/bkd/rekrutmen');
    print(uri);
    try {
      var response = await client.get(uri, headers: appHeaders);

      Logger().d('profile respcode: ${response.statusCode}');
      Logger().d('Response profile: ${response.body.toString()}');
      if (response.statusCode == 200) {
        String jsonDataString = response.body.toString();
        var jsonData = jsonDecode(jsonDataString);
        return Right(BKDRekrutmenSister.fromJson(jsonData));
      } else if (response.statusCode == 500) {
        return Left(ServerFailure('error500'));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure('error404'));
      } else {
        return Left(ServerFailure(''));
      }
    } on Exception {
      return Left(ServerFailure(''));
    }
  }

// @override
// Future<Either<Failure, UsulanList>> getUsulanList(String nidn) async {
//   var uri = Uri.parse('$urlStagging/selancar-pak/profile/$nidn/riwayat');
//   print(uri);
//   try {
//     var response = await client
//         .get(uri, headers: appHeaders)
//         .timeout(const Duration(milliseconds: 3000), onTimeout: () {
//       throw SocketException('');
//     });
//     Logger().d('usulan respcode: ${response.statusCode}');
//     Logger().d('Response usulan: ${response.body.toString()}');
//     if (response.statusCode == 200) {
//       String jsonDataString = response.body.toString();
//       var jsonData = jsonDecode(jsonDataString);
//       return Right(UsulanList.fromJson(jsonData));
//     } else if (response.statusCode == 500) {
//       return Left(ServerFailure('error500'));
//     } else if (response.statusCode == 404) {
//       return Left(ServerFailure('error404'));
//     } else {
//       return Left(ServerFailure(''));
//     }
//   } on Exception {
//     return Left(ServerFailure(''));
//   }
// }

// @override
// Future<Either<Failure, UsulanDetail>> getUsulanDetail(
//     String nidn, String id) async {
//   var uri =
//       Uri.parse('$urlStagging/selancar-pak/v2/profile/$nidn/riwayat/$id');
//   print(uri);
//   try {
//     var response = await client
//         .get(uri, headers: appHeaders)
//         .timeout(const Duration(milliseconds: 3000), onTimeout: () {
//       throw SocketException('');
//     });
//     Logger().d('detail respcode: ${response.statusCode}');
//     Logger().d('Response detail: ${response.body.toString()}');
//     if (response.statusCode == 200) {
//       String jsonDataString = response.body.toString();
//       var jsonData = jsonDecode(jsonDataString);
//       return Right(UsulanDetail.fromJson(jsonData));
//     } else if (response.statusCode == 500) {
//       return Left(ServerFailure('error500'));
//     } else if (response.statusCode == 404) {
//       return Left(ServerFailure('error404'));
//     } else {
//       return Left(ServerFailure(''));
//     }
//   } on Exception {
//     return Left(ServerFailure(''));
//   }
// }
}
