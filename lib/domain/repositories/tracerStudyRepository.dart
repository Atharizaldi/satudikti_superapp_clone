import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/source/remote/model/faq/faqList.dart';

abstract class TracerStudyRepository {
  Future<Either<Failure, FAQList>> getFaq();
}
