import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:dartz/dartz.dart';

class GetFaqIjazah {
  final IjazahLnRepository repository;

  GetFaqIjazah(this.repository);

  Future<Either<Failure, FAQList>> execute(String port, String layanan) {
    return repository.getFaqIjazah(port, layanan);
  }
}
