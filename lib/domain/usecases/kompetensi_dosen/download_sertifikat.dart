import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';

class DownloadSertifikat {
  final KompetensiDosenRepository repository;
  DownloadSertifikat(this.repository);

  Future<void> execute(String id) {
    return repository.downloadSertifikat(id);
  }
}
