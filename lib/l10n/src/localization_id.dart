// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class LocalizationId extends Localization {
  LocalizationId([String locale = 'id']) : super(locale);

  @override
  String get product_name => 'Penghitung';

  @override
  String get product_desc =>
      'Menggunakan visi komputer dan kecerdasan buatan untuk menghitung orang, kendaraan, hewan peliharaan, dan lainnya.';

  @override
  String get product_copyright => 'Hak Cipta © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL siaran langsung';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera tidak ditemukan';

  @override
  String get video_sources_camera_not_found_message =>
      'Perlu memberikan izin kamera untuk menggunakan kamera';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam tidak ditemukan';

  @override
  String get video_sources_webcam_not_found_message =>
      'Periksa izin aplikasi dan koneksi webcam';

  @override
  String get wizard_screen_desc =>
      'Buat proyek baru di bawah ini untuk mulai menghitung.';

  @override
  String get wizard_screen_new_project_from => 'Proyek Baru dari';

  @override
  String get wizard_screen_language => 'Bahasa';

  @override
  String get wizard_screen_about => 'Tentang';

  @override
  String get wizard_screen_open_projects_tip =>
      'Semua proyek akan disimpan secara otomatis di perangkat lokal';

  @override
  String get wizard_screen_open_projects => 'Buka proyek yang ada';

  @override
  String get wizard_screen_email_us => 'Email kami';

  @override
  String get language_screen_language => 'Bahasa';

  @override
  String get project_view_no_videos => 'Tidak ada sumber video tersedia.';

  @override
  String get about_screen_title => 'Tentang';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'Versi Aplikasi';

  @override
  String get about_screen_models => 'Model deteksi objek';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Info Build OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmark Model';

  @override
  String get benchmark_screen_recommended => 'Model yang Direkomendasikan';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Mulai Benchmark';

  @override
  String get benchmark_screen_start_failed =>
      'Gagal memulai benchmark, kode error-nya adalah';

  @override
  String get benchmark_screen_models => 'Model deteksi objek';

  @override
  String get project_screen_title => 'Proyek';

  @override
  String get project_screen_exit_confirm_title =>
      'Konfirmasi keluar dari proyek';

  @override
  String get project_screen_exit_confirm_content =>
      'Meninggalkan proyek akan menghentikan Penghitungan. Apakah Anda yakin ingin melanjutkan?';

  @override
  String get project_screen_exit_button => 'Keluar';

  @override
  String get project_screen_add_video_button => 'Tambah sumber video';

  @override
  String get project_screen_from_desc =>
      'Kami menyimpan catatan selama 24 jam, sehingga Anda dapat melihat bagian waktu yang Anda butuhkan.';

  @override
  String get project_screen_report_settings => 'Pengaturan';

  @override
  String get filter_screen_title => 'Filter';

  @override
  String get filter_screen_desc =>
      'Pilih rentang filter dari daftar di bawah ini';

  @override
  String get filter_screen_error_title => 'Filter';

  @override
  String get filter_screen_error_content =>
      'Waktu akhir harus lebih besar dari waktu mulai';

  @override
  String get filter_screen_error_custom => 'Kustom';

  @override
  String get filter_screen_error_start => 'Mulai';

  @override
  String get filter_screen_error_end => 'Akhir';

  @override
  String get settings_screen_title => 'Pengaturan';

  @override
  String get settings_screen_desc =>
      'Atur nama Proyek, parameter deteksi, pengosongan hitungan.';

  @override
  String get settings_screen_project_id => 'ID Proyek';

  @override
  String get settings_screen_project_name => 'Nama Proyek';

  @override
  String get settings_screen_project_name_place_holder =>
      'Jl. Sudirman 123 atau Taman Menteng';

  @override
  String get settings_screen_project_error => 'Nama proyek tidak boleh kosong';

  @override
  String get settings_screen_random_count_button => 'Tambah hitungan acak';

  @override
  String get settings_screen_reset_count_header =>
      'Reset semua hitungan dalam proyek ini';

  @override
  String get settings_screen_reset_count_button => 'Reset hitungan';

  @override
  String get settings_screen_reset_count_content =>
      'Apakah Anda yakin ingin mereset semua hitungan?';

  @override
  String get settings_screen_delete_header => 'Hapus proyek ini';

  @override
  String get settings_screen_delete_content =>
      'Apakah Anda yakin ingin menghapus proyek ini?';

  @override
  String get settings_screen_delete_button => 'Hapus';

  @override
  String get settings_screen_center_point_title => 'Titik Tengah pada Target';

  @override
  String get settings_screen_center_point_desc =>
      'Titik tengah membantu menentukan apakah target berada dalam zona jangkauan.';

  @override
  String get settings_screen_center_point_button =>
      'Tampilkan Titik Tengah pada Target';

  @override
  String get settings_screen_lost_target_title => 'Target Hilang';

  @override
  String get settings_screen_lost_target_desc =>
      'Saat pelacakan objek kehilangan target, opsi ini membuatnya terlihat. Secara default, target yang hilang tidak ditampilkan.';

  @override
  String get settings_screen_lost_target_button => 'Tampilkan Target Hilang';

  @override
  String get detection_screen_title => 'Pengaturan Deteksi';

  @override
  String get detection_screen_models => 'Model';

  @override
  String get detection_screen_confidence => 'Kepercayaan';

  @override
  String get detection_screen_confidence_desc =>
      'kepercayaan di atas #0 dianggap sebagai deteksi yang valid';

  @override
  String get detection_screen_low => 'Rendah';

  @override
  String get detection_screen_high => 'Tinggi';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc =>
      '#0 Ambang NMS lebih rendah (mis. 0.3-0.4) menghapus kotak tumpang tindih lebih ketat dan mengurangi hasil positif palsu tetapi mungkin melewatkan orang-orang tumpang tindih. Ambang lebih tinggi (0.7-0.9) mempertahankan lebih banyak kotak yang dapat meningkatkan hasil positif palsu tetapi lebih baik mendeteksi orang-orang tumpang tindih.';

  @override
  String get detection_screen_match => 'Kecocokan';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold adalah parameter kunci dalam pelacakan objek yang mengukur tingkat kecocokan antara kotak deteksi berbeda. Nilai lebih rendah mempermudah asosiasi objek tetapi meningkatkan risiko asosiasi yang salah. Nilai lebih tinggi lebih ketat pada asosiasi objek tetapi mungkin melewatkan beberapa kecocokan yang benar.';

  @override
  String get detection_screen_lost => 'Hilang';

  @override
  String get detection_screen_lost_desc =>
      'Menentukan waktu penghapusan objek yang hilang secara dinamis antara #0 dan #1 berdasarkan kecepatan gerakan';

  @override
  String get detection_screen_consider_valid => 'Anggap valid setelah';

  @override
  String get detection_screen_consider_valid_desc =>
      'Objek yang dilacak akan dianggap valid setelah #0';

  @override
  String get detection_screen_reset => 'Reset';

  @override
  String get detection_screen_reset_content =>
      'Apakah Anda yakin ingin mereset pengaturan deteksi?';

  @override
  String get url_screen_title => 'URL siaran langsung';

  @override
  String get url_screen_desc => 'Silakan masukkan URL siaran langsung';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream atau rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Tambah sumber Video';

  @override
  String get add_video_screen_from => 'Tambah sumber video dari';

  @override
  String get webcam_screen_add_title => 'Tambah Webcam';

  @override
  String get webcam_screen_edit_title => 'Pilih Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Kamera Depan';

  @override
  String get camera_screen_back_camera => 'Kamera Belakang';

  @override
  String get camera_screen_add_title => 'Tambah Kamera';

  @override
  String get camera_screen_edit_title => 'Pilih Kamera';

  @override
  String get camera_screen_zoom_level => 'Level Zoom';

  @override
  String get video_screen_name_empty => 'Nama video tidak boleh kosong.';

  @override
  String get video_screen_desc =>
      'Kelola sumber video, tambah atau ubah zona deteksi.';

  @override
  String get video_screen_video_name => 'Nama sumber video';

  @override
  String get video_screen_edit_placeholder =>
      'Kamera Pintu Depan atau Kamera Tempat Parkir';

  @override
  String get video_screen_change_file => 'Ganti File';

  @override
  String get video_screen_add_zone => 'Tambah zona deteksi';

  @override
  String get video_screen_zones => 'Zona deteksi';

  @override
  String get video_screen_zones_desc =>
      'Gunakan drag and drop untuk menyesuaikan zona';

  @override
  String get video_screen_tools => 'Alat';

  @override
  String get video_screen_move_bottom => 'Pindahkan zona saat ini ke bawah';

  @override
  String get video_screen_add_point => 'Tambah titik ke zona saat ini';

  @override
  String get video_screen_remove_point => 'Hapus titik dari zona saat ini';

  @override
  String get video_screen_playback_speed => 'Kecepatan Pemutaran';

  @override
  String get video_screen_playback_current => 'saat ini: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Hapus sumber video ini';

  @override
  String get video_screen_delete_content =>
      'Apakah Anda yakin ingin menghapus sumber video ini?';

  @override
  String get video_screen_delete_button => 'Hapus';

  @override
  String get video_screen_sources =>
      'Konfigurasi sumber gambar, target deteksi, dan parameter model.';

  @override
  String get video_screen_targets => 'Target deteksi';

  @override
  String get video_screen_detection => 'Parameter model';

  @override
  String get color_screen_title => 'Pilih warna';

  @override
  String get zone_screen_desc =>
      'Zona deteksi dapat mengatur jenis objek yang akan dideteksi dan memilih penghitung mana yang akan ditampilkan, seperti Terdeteksi, Muncul, dan Masuk.';

  @override
  String get zone_screen_name_placeholder =>
      'Nama zona, seperti Trotoar atau Tempat Parkir';

  @override
  String get zone_screen_zone_color => 'Warna zona';

  @override
  String get zone_screen_color => 'Warna';

  @override
  String get zone_screen_delete_header => 'Hapus zona ini';

  @override
  String get zone_screen_delete_content =>
      'Apakah Anda yakin ingin menghapus zona ini?';

  @override
  String get zone_screen_delete_button => 'Hapus';

  @override
  String get zone_screen_can_not_delete => 'Tidak dapat menghapus zona';

  @override
  String get zone_screen_one_zone_required =>
      'Setidaknya satu zona diperlukan.';

  @override
  String get zone_screen_zone_name_required => 'Nama zona tidak boleh kosong';

  @override
  String get counter_screen_show_on => 'Tampilkan di layar';

  @override
  String get counter_screen_enabled => 'Diaktifkan';

  @override
  String get counter_screen_reentry_threshold => 'Ambang Masuk Kembali';

  @override
  String get counter_screen_reentry_desc =>
      'Objek harus masuk #0 kali, dengan pendinginan #1 detik antara setiap keluar dan masuk kembali, untuk memicu perhitungan masuk kembali';

  @override
  String get counter_screen_reentry_title => 'Hitungan masuk kembali';

  @override
  String get counter_screen_cooldown_threshold => 'Ambang Pendinginan';

  @override
  String get counter_screen_cooldown_desc =>
      'Masuk kembali membutuhkan pendinginan #0 detik setelah keluar dari zona deteksi';

  @override
  String get counter_screen_cooldown_time => 'Waktu Pendinginan';

  @override
  String get counter_screen_cooldown_in_seconds => 'dalam detik';

  @override
  String get counter_screen_stagnant_threshold => 'Ambang Stagnasi';

  @override
  String get counter_screen_stagnant_desc =>
      'Objek yang tetap diam selama lebih dari #0 detik akan dianggap stagnasi';

  @override
  String get counter_screen_stagnant_consider => 'Anggap sebagai stagnasi';

  @override
  String get counter_screen_stagnant_in_seconds => 'dalam detik';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Awalan Deskripsi';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Akhiran Deskripsi';

  @override
  String get counter_screen_name_error => 'Nama penghitung tidak boleh kosong';

  @override
  String get counter_screen_enabled_error => 'Error';

  @override
  String get counter_screen_enabled_error_content =>
      'Anda perlu mengaktifkan penghitung lain terlebih dahulu, baru Anda dapat menonaktifkan penghitung ini';

  @override
  String get objects_screen_title => 'Objek';

  @override
  String get objects_screen_desc =>
      'Pilih target deteksi seperti orang, mobil, bus, dll.';

  @override
  String get open_project_screen_title => 'Buka Proyek';

  @override
  String get open_project_screen_desc =>
      'Buka proyek yang dibuat sebelumnya, hanya menyimpan 20 proyek terbaru.';

  @override
  String get open_project_screen_no_project => 'Tidak ada proyek ditemukan.';

  @override
  String get default_project_name => 'Proyek';

  @override
  String get default_video_name => 'Sumber video';

  @override
  String get default_zone_name => 'Zona deteksi';

  @override
  String get error_oops => 'Ups, ada yang salah';

  @override
  String get error_content =>
      'Terjadi kesalahan yang tidak terduga. Apakah Anda ingin mengirimkan laporan email?';

  @override
  String get error_report => 'Email kami';

  @override
  String get submit => 'Kirim';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Batal';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get close => 'Tutup';

  @override
  String get back => 'Kembali';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_show_summary => 'Tampilkan ringkasan di layar';

  @override
  String get video_sources_photos_denied => 'Akses ke foto ditolak';

  @override
  String get video_sources_photos_goto_settings => 'Buka pengaturan';

  @override
  String get video_sources_camera_denied => 'Akses ke kamera ditolak';

  @override
  String get video_sources_photos_denied_msg =>
      'Buka pengaturan dan izinkan akses foto untuk aplikasi ini.';

  @override
  String get video_sources_camera_denied_msg =>
      'Buka pengaturan dan izinkan akses kamera untuk aplikasi ini.';
}
