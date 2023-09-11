import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';

class DownloadUnduhan {
  final KompetensiDosenRepository repository;
  DownloadUnduhan(this.repository);

  Future<void> execute(String id) {
    return repository.downloadUnduhan(id);
  }
}
