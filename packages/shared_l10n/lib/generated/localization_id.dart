// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class LocalizationId extends Localization {
  LocalizationId([String locale = 'id']) : super(locale);

  @override
  String get about_screen_app_version => 'Versi Aplikasi';

  @override
  String get about_screen_email_us => 'Email kami';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Muncul';

  @override
  String get appeared_help =>
      'Menghitung orang atau kendaraan yang posisi terdeteksi pertamanya berada di dalam area ini.\\n\\nBerguna untuk memahami di mana pelacakan dimulai.\\n\\n(Terutama untuk pengguna tingkat lanjut)';

  @override
  String get average_occupancy => 'Rata-rata Jumlah';

  @override
  String get average_occupancy_help =>
      'Menampilkan rata-rata jumlah orang atau kendaraan di area ini selama jendela penghitungan saat ini.\\n\\nMembantu menunjukkan seberapa ramai area ini selama seluruh periode penghitungan.';

  @override
  String get average_stay => 'Rata-rata Lama Tinggal';

  @override
  String get average_stay_help =>
      'Menampilkan rata-rata lama orang atau kendaraan berada di area ini.\\n\\nRata-rata waktu yang lebih lama dapat menunjukkan pelanggan menghabiskan lebih banyak waktu di area ini.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter menggunakan kamera dan AI di perangkat untuk menghitung orang. Pertama, mari pastikan perangkat Anda kompatibel.';

  @override
  String get camera_test_screen_instruction =>
      'Arahkan kamera ke orang. Aplikasi akan menggambar kotak di sekitar setiap orang yang terdeteksi.';

  @override
  String get camera_test_screen_next => 'Ketuk Berikutnya untuk melanjutkan.';

  @override
  String get camera_test_screen_start =>
      'Ketuk Mulai. Jika diminta, izinkan akses kamera.';

  @override
  String get camera_test_screen_test_failed => 'Tes gagal!';

  @override
  String get camera_test_screen_test_passed => 'Tes berhasil!';

  @override
  String get camera_test_screen_title => 'Ujian Kamera AI';

  @override
  String get camera_test_screen_wait => 'Menunggu AI mendeteksi orang…';

  @override
  String get cta_screen_custom => 'Gunakan Server Sendiri';

  @override
  String get cta_screen_custom_help =>
      'Kirim data lalu lintas langsung ke backend atau database Anda.';

  @override
  String get cta_screen_footer =>
      'Dengan melanjutkan, Anda menyetujui Ketentuan Layanan, Kebijakan Privasi, dan Perjanjian Pemrosesan Data.';

  @override
  String get cta_screen_invitation => 'Gunakan Kode Undangan';

  @override
  String get cta_screen_invitation_help =>
      'Bergabung dengan organisasi yang sudah ada menggunakan undangan dari administrator.';

  @override
  String get cta_screen_local => 'Hanya Perangkat Ini';

  @override
  String get cta_screen_local_help =>
      'Simpan data lalu lintas hanya di perangkat ini. Tidak ada data yang diunggah.';

  @override
  String get cta_screen_piyuo => 'Gunakan Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Simpan data lalu lintas di Piyuo Cloud dengan dasbor dan wawasan bisnis.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter membuat statistik lalu lintas anonim setiap 5 menit.\\nPilih cara menyimpan dan mengakses data Anda.';

  @override
  String get current_occupancy => 'Jumlah Saat Ini';

  @override
  String get current_occupancy_help =>
      'Menampilkan jumlah orang atau kendaraan saat ini di area ini.\\n\\nAngka ini diperbarui secara real-time dan membantu memastikan deteksi AI sesuai dengan yang terlihat di layar. Nilai ini tidak disertakan dalam data telemetri yang diunggah.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Menyimpan...';

  @override
  String get custom_server_screen_server_url_label => 'URL Server';

  @override
  String get detection_screen_confidence => 'Ambang Kepercayaan';

  @override
  String get detection_screen_confidence_dialog =>
      'Mengontrol seberapa yakin AI harus sebelum menghitung orang atau kendaraan.\\nNilai lebih rendah\\n• Mendeteksi lebih banyak objek\\n• Lebih baik untuk objek jauh atau sebagian tersembunyi\\n• Dapat meningkatkan deteksi palsu\\nNilai lebih tinggi\\n• Hanya menghitung deteksi dengan keyakinan tinggi\\n• Mengurangi deteksi palsu\\n• Dapat melewatkan objek kecil atau sulit\\nGunakan nilai lebih rendah jika aplikasi melewatkan orang atau kendaraan.\\nGunakan nilai lebih tinggi jika aplikasi menghitung bayangan, pantulan, atau objek palsu lainnya.';

  @override
  String get detection_screen_confidence_help =>
      'Keyakinan minimum yang diperlukan untuk mendeteksi objek.';

  @override
  String get detection_screen_confidence_max_label => 'Ketat';

  @override
  String get detection_screen_confidence_min_label => 'Longgar';

  @override
  String get detection_screen_disappear => 'Batas Waktu Hilang';

  @override
  String get detection_screen_disappear_dialog =>
      'Menentukan berapa lama AI menunggu sebelum menandai objek sebagai menghilang setelah tidak lagi terdeteksi.\\nNilai lebih pendek\\n• Menandai objek menghilang lebih cepat\\n• Lebih baik untuk lalu lintas cepat\\n• Dapat menandai objek yang tersembunyi sementara sebagai menghilang\\nNilai lebih panjang\\n• Menunggu lebih lama sebelum menandai objek menghilang\\n• Lebih baik saat objek terhalang atau terlewat sebentar\\n• Menunda peristiwa menghilang';

  @override
  String get detection_screen_disappear_help =>
      'Berapa lama AI menunggu sebelum menandai objek sebagai hilang setelah tidak lagi mendeteksinya.';

  @override
  String get detection_screen_disappear_max_label => 'Lambat';

  @override
  String get detection_screen_disappear_min_label => 'Cepat';

  @override
  String get detection_screen_memory_dialog =>
      'Mengontrol berapa lama AI mengingat objek setelah menghilang.\\nTingkatkan nilai ini jika orang atau kendaraan sering tersembunyi di belakang objek lain.\\nKurangi nilai ini jika objek salah terhubung setelah meninggalkan area.';

  @override
  String get detection_screen_min_presence => 'Waktu Kehadiran Minimum';

  @override
  String get detection_screen_min_presence_help =>
      'Objek harus tetap terlihat sebelum dihitung. Nilai lebih tinggi membantu mengurangi deteksi palsu yang singkat.';

  @override
  String get detection_screen_min_presence_max_label => 'Lebih Aman';

  @override
  String get detection_screen_min_presence_min_label => 'Lebih Cepat';

  @override
  String get detection_screen_minimum_visible =>
      'Objek harus tetap terlihat selama waktu ini sebelum dihitung.\\nTingkatkan nilai ini untuk mengabaikan deteksi palsu singkat.\\nKurangi nilai ini jika orang atau kendaraan yang bergerak cepat terlewat.';

  @override
  String get detection_screen_new_track => 'Ambang Pelacakan Baru';

  @override
  String get detection_screen_new_track_help =>
      'Keyakinan minimum untuk mulai melacak objek baru. Nilai rendah dapat membuat pelacakan ganda.';

  @override
  String get detection_screen_new_track_max_label => 'Konservatif';

  @override
  String get detection_screen_new_track_min_label => 'Agresif';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content =>
      'Apakah Anda yakin ingin mereset pengaturan deteksi?';

  @override
  String get detection_screen_show_track_id => 'Tampilkan ID Pelacakan';

  @override
  String get detection_screen_show_track_id_help =>
      'Aktifkan opsi ini untuk menampilkan ID pelacakan unik untuk setiap objek yang dilacak.';

  @override
  String get detection_screen_stay => 'Waktu Tinggal';

  @override
  String get detection_screen_stay_help =>
      'Berapa lama objek harus berada di area sebelum dihitung sebagai tinggal.';

  @override
  String get detection_screen_stay_max_label => 'Tertunda';

  @override
  String get detection_screen_stay_min_label => 'Instan';

  @override
  String get detection_screen_stay_threshold =>
      'Menentukan kapan objek berkontribusi pada hitungan Stay (Tinggal).\\nNilai lebih pendek\\n• Menghitung tinggal segera\\n• Lebih baik untuk analisis cepat\\nNilai lebih panjang\\n• Mengabaikan lalu lintas lewat sekilas\\n• Lebih baik untuk pengukuran okupansi';

  @override
  String get detection_screen_subtitle =>
      'Atur cara AI mendeteksi dan melacak objek.';

  @override
  String get detection_screen_title => 'Pelacakan & Penghitungan';

  @override
  String get detection_screen_track_dialog =>
      'Mengontrol kapan objek yang baru terdeteksi menjadi track baru.\\nNilai lebih rendah\\n• Pelacakan dimulai lebih cepat\\n• Lebih baik untuk objek yang bergerak cepat\\n• Dapat membuat track duplikat\\nNilai lebih tinggi\\n• Membutuhkan bukti lebih kuat sebelum membuat track baru\\n• Mengurangi track duplikat\\n• Dapat menunda pelacakan objek baru';

  @override
  String get detection_screen_track_memory => 'Memori Pelacakan';

  @override
  String get detection_screen_track_memory_help =>
      'Berapa lama objek tetap dilacak setelah hilang sementara. Nilai lebih tinggi membantu memulihkan pelacakan setelah terhalang sebentar.';

  @override
  String get detection_screen_track_memory_max_label => 'Panjang';

  @override
  String get detection_screen_track_memory_min_label => 'Pendek';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter menggunakan kamera Anda untuk mendeteksi pejalan kaki dan kendaraan secara real time. Perangkat ini tidak memiliki kamera yang tersedia.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Coba buka aplikasi ini di ponsel Anda';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Smartphone atau tablet dengan kamera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Disarankan perangkat iOS atau Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Yang Anda perlukan';

  @override
  String get device_not_supported_screen_title => 'Kamera tidak ditemukan';

  @override
  String get disappeared => 'Menghilang';

  @override
  String get disappeared_help =>
      'Menghitung orang atau kendaraan yang posisi terdeteksi terakhirnya berada di dalam area ini.\\n\\nPelacakan berakhir setelah Waktu Hilang yang ditentukan jika orang atau kendaraan tidak lagi terdeteksi.\\n\\n(Terutama untuk pengguna tingkat lanjut)';

  @override
  String get dpa => 'Perjanjian Pemrosesan Data';

  @override
  String get durationDaysShort => '%sh';

  @override
  String get durationHoursShort => '%sj';

  @override
  String get durationMinutesShort => '%sm';

  @override
  String get durationSecondsShort => '%sd';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Masuk';

  @override
  String get entered_help =>
      'Menghitung orang atau kendaraan yang memasuki area ini selama jendela penghitungan saat ini.\\n\\nSatu masuk dihitung saat seseorang atau kendaraan berpindah dari luar area ke dalam area.';

  @override
  String get exited => 'Keluar';

  @override
  String get exited_help =>
      'Menghitung orang atau kendaraan yang keluar dari area ini selama jendela penghitungan saat ini.\\n\\nSatu keluar dihitung saat seseorang atau kendaraan berpindah dari dalam area ke luar area.';

  @override
  String get language_screen_language => 'Bahasa';

  @override
  String get language_screen_subtitle =>
      'Pilih bahasa yang digunakan dalam aplikasi.';

  @override
  String get local_only_screen_body =>
      'Mode Hanya Perangkat Lokal memungkinkan Anda mencoba deteksi dan pelacakan kamera AI tanpa mengunggah data apa pun. Semua statistik lalu lintas pejalan kaki diproses hanya di perangkat ini, cocok untuk uji coba sebelum terhubung ke server.';

  @override
  String get local_only_screen_use_action => 'Gunakan Perangkat Lokal Saja';

  @override
  String get local_screen_text =>
      'Piyuo Counter akan berjalan sepenuhnya di perangkat ini.\\nStatistik lalu lintas hanya akan disimpan di perangkat ini dan tidak akan diunggah.\\nNanti Anda dapat menghubungkan Piyuo Cloud atau server Anda sendiri melalui Pengaturan.';

  @override
  String get maximum_occupancy => 'Jumlah Maksimum';

  @override
  String get maximum_occupancy_help =>
      'Menampilkan jumlah orang atau kendaraan terbanyak yang berada di area ini pada saat yang sama selama jendela penghitungan saat ini.\\n\\nBerguna untuk mengetahui waktu paling ramai.';

  @override
  String get maximum_stay => 'Lama Tinggal Maksimum';

  @override
  String get maximum_stay_help =>
      'Menampilkan waktu terlama seseorang atau kendaraan berada di area ini selama jendela penghitungan saat ini.\\n\\nBerguna untuk mengetahui kunjungan atau berhenti yang sangat lama.';

  @override
  String get metric_events => 'Peristiwa';

  @override
  String get metric_live => 'Langsung';

  @override
  String get metric_show_less => 'Tampilkan lebih sedikit';

  @override
  String get metric_show_more => 'Tampilkan lebih banyak';

  @override
  String get metric_statistics => 'Statistik';

  @override
  String get metrics_counting_all => 'Semua';

  @override
  String get metrics_counting_done => 'Selesai';

  @override
  String get metrics_counting_in_progress => 'Dalam Proses';

  @override
  String get metrics_counting_missing => 'Hilang';

  @override
  String get metrics_counting_window =>
      'Statistik untuk setiap periode 5 menit';

  @override
  String get onboarding_back_action => 'Kembali';

  @override
  String get onboarding_cta_no_server => 'Tidak ingin mengunggah data?';

  @override
  String get onboarding_cta_title => 'Ke mana data Anda akan dikirim?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter menggunakan kamera perangkatmu dan AI bawaan untuk mengenali orang dan kendaraan secara langsung.\\nDengan teknologi deteksi dan pelacakan, ia otomatis menghitung arus pejalan kaki dan kendaraan — semuanya diproses langsung di perangkatmu.';

  @override
  String get onboarding_intro_text2 =>
      'Semua pemrosesan AI dilakukan secara lokal di perangkatmu. Tidak ada video, gambar, wajah, atau identitas yang diunggah.\\nHanya ringkasan anonim setiap 5 menit yang dibagikan, mencakup statistik jumlah, okupansi, masuk, keluar, dan waktu tinggal.';

  @override
  String get onboarding_intro_text3 =>
      'Cukup jalankan aplikasinya dan biarkan berjalan. Piyuo Counter secara otomatis terus mengumpulkan dan menyimpan data lalu lintas.\\nRingkasan data disimpan setiap 5 menit dan diunggah setiap jam ke Piyuo Cloud atau server milikmu sendiri.';

  @override
  String get onboarding_intro_title1 => 'Pengiraan Trafik AI';

  @override
  String get onboarding_intro_title2 => 'Privasi Sejak Awal';

  @override
  String get onboarding_intro_title3 => 'Berjalan Otomatis 24/7';

  @override
  String get onboarding_next_action => 'Berikutnya';

  @override
  String get onboarding_skip_action => 'Lewati Pengenalan';

  @override
  String get onboarding_start_action => 'Mulai';

  @override
  String get passed_by => 'Lewat';

  @override
  String get passed_by_help =>
      'Menghitung orang atau kendaraan yang melewati area ini selama jendela penghitungan saat ini.\\n\\nSetiap orang atau kendaraan dihitung satu kali untuk setiap kali melewati area.';

  @override
  String get payloads_screen_area => 'Area';

  @override
  String get payloads_screen_confidence => 'Kepercayaan';

  @override
  String get payloads_screen_coverage => 'Cakupan';

  @override
  String get payloads_screen_delivered => 'Terkirim';

  @override
  String get payloads_screen_failed_load => 'Gagal memuat payload terbaru';

  @override
  String get payloads_screen_frame_processed => 'Frame diproses';

  @override
  String get payloads_screen_hour_not_exists => 'Jam ini sudah tidak tersedia.';

  @override
  String get payloads_screen_missing_time => 'Waktu yang hilang';

  @override
  String get payloads_screen_no_payloads => 'Belum ada payload.';

  @override
  String get payloads_screen_partial =>
      'Jendela berakhir lebih awal (sebagian)';

  @override
  String get payloads_screen_partially => 'Sebagian terkirim';

  @override
  String get payloads_screen_payload_not_exists =>
      'Payload ini sudah tidak tersedia.';

  @override
  String get payloads_screen_pending => 'Menunggu penghantaran';

  @override
  String get payloads_screen_process_fps => 'FPS pemrosesan';

  @override
  String get payloads_screen_resend => 'Kirim ulang';

  @override
  String get payloads_screen_select_first =>
      'Pilih sekurang-kurangnya satu tarikh atau jam terlebih dahulu.';

  @override
  String get payloads_screen_subtitle =>
      'Pilih berdasarkan tanggal atau jam untuk kirim ulang';

  @override
  String get payloads_screen_title => 'Payload terbaru';

  @override
  String get personal_custom_screen_build_server =>
      'Perlu bantuan menyiapkan server Anda sendiri?\\nLihat dokumentasi API dan contoh server kami.';

  @override
  String get personal_custom_screen_help_action => 'Buka Dokumentasi API';

  @override
  String get personal_custom_screen_reset_action => 'Mulai Lagi';

  @override
  String get personal_custom_success_screen_help =>
      'Ketuk Start di bawah untuk mulai menghitung.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Statistik lalu lintas diunggah otomatis setiap jam.\\nAnda juga dapat mengunggahnya secara manual dari layar Upload Logs.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Server Anda belum harus online.\\nMulai menghitung sekarang. Anda dapat menyelesaikan pembuatan dan pengujian server nanti. Statistik lalu lintas akan tetap berada di perangkat ini hingga berhasil diunggah.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Statistik lalu lintas akan dikirim ke';

  @override
  String get personal_custom_success_screen_title => 'Server Anda Siap';

  @override
  String get piyuo_server_screen_cloud_url_label => 'URL Piyuo Cloud Anda';

  @override
  String get piyuo_server_screen_copy_action => 'Salin URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL disalin';

  @override
  String get piyuo_server_screen_saving_action => 'Menyimpan...';

  @override
  String get piyuo_server_screen_start =>
      'Tekan \"Start\" di bawah untuk mulai menghitung.';

  @override
  String get piyuo_server_screen_url_help =>
      'Dasbor pribadi Piyuo Cloud Anda siap di URL ini.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Simpan URL ini untuk mengakses dasbor lalu lintas Anda dari perangkat lain.';

  @override
  String get piyuo_server_screen_use_action => 'Gunakan Piyuo Cloud';

  @override
  String get privacy => 'Kebijakan Privasi';

  @override
  String get product_copyright => 'Hak Cipta © 2026';

  @override
  String get product_desc => 'Penghitungan orang dan kendaraan berbasis AI.';

  @override
  String get settings_screen_custom_subtitle =>
      'Kirim data lalu lintas langsung ke backend atau database Anda.';

  @override
  String get settings_screen_custom_title => 'Gunakan Server Kustom';

  @override
  String get settings_screen_data_server_label => 'Server Data';

  @override
  String get settings_screen_detection_target => 'Target Deteksi';

  @override
  String get settings_screen_language_title => 'Bahasa';

  @override
  String get settings_screen_local_subtitle =>
      'Simpan data lalu lintas hanya di perangkat ini. Tidak ada yang diunggah.';

  @override
  String get settings_screen_local_title => 'Hanya Perangkat Lokal';

  @override
  String get settings_screen_misc_label => 'Lainnya';

  @override
  String get settings_screen_object_detection => 'Deteksi Objek';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Simpan data lalu lintas di Piyuo Cloud dengan dasbor dan wawasan bisnis.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Ini akan menghapus semua data dan memulai dari awal. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get settings_screen_reset_all_data_title => 'Reset semua data?';

  @override
  String get settings_screen_subscription_body =>
      'Kelola langganan dan informasi penagihan';

  @override
  String get settings_screen_subscription_title => 'Langganan';

  @override
  String get start_screen_about => 'Tentang';

  @override
  String get start_screen_server_none => 'Data hanya disimpan di perangkat ini';

  @override
  String get start_screen_server_personal => 'Data diunggah setiap jam ke';

  @override
  String get start_screen_settings => 'Pengaturan';

  @override
  String get start_screen_upload_logs => 'Unggah Log';

  @override
  String get start_screen_video_sources => 'Sumber video';

  @override
  String get stayed => 'Tinggal';

  @override
  String get stayed_help =>
      'Menghitung orang atau kendaraan yang tetap berada di area ini setidaknya selama Waktu Tinggal yang ditentukan.\\n\\nWaktu Tinggal bawaan adalah 15 detik dan dapat diubah di Pengaturan.';

  @override
  String get target_pedestrian => 'Pejalan kaki';

  @override
  String get target_pedestrian_help =>
      'Hitung orang menggunakan model deteksi pejalan kaki';

  @override
  String get target_screen_subtitle =>
      'Pilih model deteksi yang akan digunakan';

  @override
  String get target_vehicle => 'Kendaraan';

  @override
  String get target_vehicle_help =>
      'Hitung mobil dan kendaraan lain menggunakan model kendaraan';

  @override
  String get telemetry_error_connection_refused =>
      'Tidak dapat terhubung ke server. Mungkin sedang offline.';

  @override
  String get telemetry_error_connection_reset =>
      'Koneksi telah direset. Periksa koneksi internet Anda dan coba lagi.';

  @override
  String get telemetry_error_connection_timeout =>
      'Koneksi memerlukan waktu terlalu lama untuk merespons. Periksa koneksi internet Anda dan coba lagi.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Alamat server tidak ditemukan. Periksa koneksi internet atau URL server Anda.';

  @override
  String get telemetry_error_http_error_status =>
      'Server menolak permintaan tersebut. Silakan coba lagi nanti.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Terjadi kesalahan tak terduga saat berkomunikasi dengan server.';

  @override
  String get telemetry_error_invalid_url =>
      'Alamat server tidak valid. Periksa pengaturan Anda.';

  @override
  String get telemetry_error_network_error =>
      'Terjadi kesalahan jaringan. Periksa koneksi internet Anda dan coba lagi.';

  @override
  String get telemetry_error_socket_error =>
      'Terjadi masalah koneksi jaringan. Periksa koneksi internet Anda.';

  @override
  String get telemetry_error_transport_exception =>
      'Terjadi kesalahan saat mengirim data. Silakan coba lagi.';

  @override
  String get terms => 'Syarat Layanan';

  @override
  String get upload_screen_attempt_time => 'Waktu percobaan:';

  @override
  String get upload_screen_error => 'Kesalahan:';

  @override
  String get upload_screen_failed => 'Gagal';

  @override
  String get upload_screen_load_error => 'Gagal memuat log unggahan.';

  @override
  String get upload_screen_log_not_exists =>
      'Log unggahan tidak lagi tersedia.';

  @override
  String get upload_screen_next => 'Unggahan berikutnya ...';

  @override
  String get upload_screen_next_upload_prefix => 'Unggahan berikutnya ';

  @override
  String get upload_screen_no_data_server =>
      'Silakan atur Server Data terlebih dahulu.';

  @override
  String get upload_screen_no_logs => 'Belum ada log unggahan.';

  @override
  String get upload_screen_payload_count => 'Jumlah Payload';

  @override
  String get upload_screen_payload_count_label => 'Jumlah payload:';

  @override
  String get upload_screen_payload_size => 'Ukuran payload:';

  @override
  String get upload_screen_result => 'Hasil:';

  @override
  String get upload_screen_retry => 'Jumlah percobaan ulang:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Berhasil';

  @override
  String get upload_screen_today => 'Hari Ini';

  @override
  String get upload_screen_upload_now => 'Unggah sekarang';

  @override
  String get upload_screen_upload_success => 'Berhasil diunggah.';

  @override
  String get upload_screen_uploading => 'Mengunggah...';

  @override
  String get upload_screen_yesterday => 'Kemarin';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URL RTSP harus menyertakan nama host.';

  @override
  String get url_screen_invalid_url_error =>
      'Masukkan URL yang valid dengan skema yang didukung.';

  @override
  String get url_screen_subtitle => 'Silakan masukkan URL siaran langsung';

  @override
  String get url_screen_title => 'URL siaran langsung';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error => 'Masukkan URL siaran langsung.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream atau rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Kamera belakang';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_front_camera => 'Kamera depan';

  @override
  String get video_sources_live_stream => 'URL siaran langsung';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Perlu memberikan izin kamera untuk menggunakan kamera';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Kamera tidak ditemukan';

  @override
  String get video_sources_screen_import_error => 'Gagal mengimpor file video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Buka pengaturan dan izinkan akses foto untuk aplikasi ini.';

  @override
  String get video_sources_screen_select_camera =>
      'Ketuk untuk memilih kamera ini';

  @override
  String get video_sources_screen_select_file => 'Ketuk untuk memilih file';

  @override
  String get video_sources_screen_select_live =>
      'Ketuk untuk mengatur URL siaran langsung';

  @override
  String get video_sources_webcam => 'Webcam';
}
