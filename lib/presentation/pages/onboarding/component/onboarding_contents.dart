class OnboardingContents {
  final String title;
  final String image;
  final String description;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'Tahukah Kamu?',
    image: 'assets/onboarding1_batch4.png',
    description: 'Satudikti mengintegrasikan \n14 layanan pendidikan tinggi, yang sekarang \ndapat kamu akses dalam satu aplikasi.',
  ),
  OnboardingContents(
    title: 'Satu Aplikasi untuk Semua',
    image: 'assets/onboarding2_batch4.png',
    description: 'Mahasiswa, dosen, tendik, hingga masyarakat\n umum bisa mengakses Satudikti.',
  ),
  OnboardingContents(
    title: 'Mudah, Cepat dan Akurat',
    image: 'assets/onboarding3_batch4.png',
    description: 'Akses berbagai layanan dan informasi terkini\n seputar Pendidikan Tinggi, lewat Satudikti.',
  ),
];