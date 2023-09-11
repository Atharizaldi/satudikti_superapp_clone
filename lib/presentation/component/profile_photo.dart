String defaultProfilePhoto({required String role, required String gender}) {
  switch (role) {
    case 'Dosen':
      if (gender == 'P') {
        return 'assets/profil/dosen2.png';
      }
      return 'assets/profil/dosen.png';

    case 'Mahasiswa':
      if (gender == 'P') {
        return 'assets/profil/mahasiswa2.png';
      }
      return 'assets/profil/mahasiswa.png';

    case 'Admin-PT':
      if (gender == 'P') {
        return 'assets/profil/admin2.png';
      }
      return 'assets/profil/admin.png';

    default:
      if (gender == 'P') {
        return 'assets/profil/general2.png';
      }
      return 'assets/profil/general.png';
  }
}
