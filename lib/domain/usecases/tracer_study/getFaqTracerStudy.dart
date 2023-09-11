import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/tracerStudyRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class GetFaqTracerStudy {
  final TracerStudyRepository repository;

  GetFaqTracerStudy(this.repository);

  Future<Either<Failure, FAQList>> execute(int i) {
    return repository.getFaq();
  }
}
