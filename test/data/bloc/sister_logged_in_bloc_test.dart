// import 'dart:convert';
// import 'dart:io';


// import 'package:app/common/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'package:mockito/mockito.dart';
// import 'package:app/common/internetCheck.dart';
// import 'package:app/data/source/local/sharedpreferences.dart';
// import 'package:app/presentation/pages/beranda/sister/logged_in_page/bloc/sister_logged_in_bloc.dart';
// import 'package:app/data/source/remote/model/sister/profile_sister_detail.dart';
// import 'package:app/domain/usecases/sister/get_profile_detail_sister.dart';

// import '../../json_reader.dart';

// class MockGetProfileDetailSister extends Mock implements GetProfileDetailSister {}
// class MockInternetCheck extends Mock implements InternetCheck {}
// class TestFailure extends Failure {
//   TestFailure(String message) : super(message);
// }

// void main() {
//   group("Sister Loggedin BLoC", () {
//     late SisterLoggedinBloc sisterLoggedinBloc;
//     late MockGetProfileDetailSister mockGetProfileDetailSister;
//     late MockInternetCheck mockInternetCheck;

//     final String filePath = "dummy_data/sister/get_profile_detail.json";
//     final mockProfileDetail = ProfileSisterDetail.fromJson(jsonDecode(readFile(filePath)));
    
//     setUp(() {
//       mockGetProfileDetailSister = MockGetProfileDetailSister();
//       mockInternetCheck = MockInternetCheck();
//       sisterLoggedinBloc = SisterLoggedinBloc(
//         getProfileDetailSister: mockGetProfileDetailSister,
//         internetCheck: mockInternetCheck,
//         log: Logger(),
//       );
//     });

//     test('initial state should be SisterLoggedinInitial', () {
//       expect(sisterLoggedinBloc.state, SisterLoggedinInitial());
//     });

//     blocTest<SisterLoggedinBloc, SisterLoggedinState>(
//       'emits SisterLoggedInLoadedState when successful',
//       build: () {
//         when(mockInternetCheck.hasConnection()).thenAnswer((_) async => true);
//         when(mockGetProfileDetailSister.execute('0011075809')).thenAnswer(
//           (_) async => Right(mockProfileDetail),
//         );
//         return sisterLoggedinBloc;
//       },
//       act: (bloc) => bloc.add(SisterGetProfileEvent(nidn: '0011075809')),
//       expect: () => [
//         SisterLoggedInLoadedState(
//           profileDetail: mockProfileDetail,
//           nidn: '0011075809',
//           dataDosen: ['Ini dataDosen'],
//         ),
//       ],
//     );

//     blocTest<SisterLoggedinBloc, SisterLoggedinState>(
//       'emits SisterLoggedInErrorState when failure with error 500',
//       build: () {
//         when(mockInternetCheck.hasConnection()).thenAnswer((_) async => true);
//         when(mockGetProfileDetailSister.execute('0011075809')).thenAnswer(
//           (_) async => Left(TestFailure('erorr 500')), 
//         );
//         return sisterLoggedinBloc;
//       },
//       act: (bloc) => bloc.add(SisterGetProfileEvent(nidn: '0011075809')),
//       expect: () => [
//         SisterLoggedInErrorState(nidn: '0011075809'),
//       ],
//     );

//     // test('emits [SisterLoggedInLoadedState] when SisterGetProfileEvent is added and has internet', () {
//     //   when(mockInternetCheck.hasConnection()).thenAnswer((_) async => true);
//     //   when(mockGetProfileDetailSister.execute('0011075809')).thenAnswer((_) async => Future.value(Right(mockProfileDetail)));

//     //   expectLater(sisterLoggedinBloc,
//     //     emitsInOrder([
//     //       SisterLoggedinInitial(),
//     //       SisterLoggedInLoadedState(
//     //         profileDetail: mockProfileDetail,
//     //         nidn: '0011075809',
//     //         dataDosen: ['Ini dataDosen'],
//     //       ),
//     //     ])
//     //   );
//     // });

//   });
// }

