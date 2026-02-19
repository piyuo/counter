// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class LocalizationMs extends Localization {
  LocalizationMs([String locale = 'ms']) : super(locale);

  @override
  String get about_screen_app_version => 'Versi Aplikasi';

  @override
  String get about_screen_benchmark => 'Penanda aras';

  @override
  String get about_screen_models => 'Model pengesanan objek';

  @override
  String get about_screen_opencv_build_info => 'Maklumat Binaan OpenCV';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_title => 'Tentang';

  @override
  String get add_video_screen_from => 'Tambah sumber video dari';

  @override
  String get add_video_screen_title => 'Tambah sumber Video';

  @override
  String get back => 'Kembali';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_models => 'Model pengesanan objek';

  @override
  String get benchmark_screen_recommended => 'Model Disyorkan';

  @override
  String get benchmark_screen_start_button => 'Mulakan Penanda Aras';

  @override
  String get benchmark_screen_start_failed =>
      'Gagal memulakan penanda aras, kod ralat ialah';

  @override
  String get benchmark_screen_title => 'Penanda Aras Model';

  @override
  String get camera_screen_add_title => 'Tambah Kamera';

  @override
  String get camera_screen_back_camera => 'Kamera Belakang';

  @override
  String get camera_screen_edit_title => 'Pilih Kamera';

  @override
  String get camera_screen_front_camera => 'Kamera Hadapan';

  @override
  String get camera_screen_zoom_level => 'Tahap Zum';

  @override
  String get cancel => 'Batal';

  @override
  String get close => 'Tutup';

  @override
  String get color_screen_title => 'Pilih warna';

  @override
  String get counter_screen_cooldown_desc =>
      'Masuk semula memerlukan masa tenang #0 saat selepas keluar dari zon pengesanan';

  @override
  String get counter_screen_cooldown_in_seconds => 'dalam saat';

  @override
  String get counter_screen_cooldown_threshold => 'Ambang Masa Tenang';

  @override
  String get counter_screen_cooldown_time => 'Masa Tenang';

  @override
  String get counter_screen_enabled => 'Diaktifkan';

  @override
  String get counter_screen_enabled_error => 'Ralat';

  @override
  String get counter_screen_enabled_error_content =>
      'Anda perlu mengaktifkan kaunter lain dahulu, kemudian anda boleh menyahaktifkan kaunter ini';

  @override
  String get counter_screen_name_error => 'Nama kaunter tidak boleh kosong';

  @override
  String get counter_screen_reentry_desc =>
      'Objek mesti masuk #0 kali, dengan masa tenang #1 saat antara setiap keluar dan masuk semula, untuk mencetuskan masuk semula';

  @override
  String get counter_screen_reentry_threshold => 'Ambang Masuk Semula';

  @override
  String get counter_screen_reentry_title => 'Kiraan masuk semula';

  @override
  String get counter_screen_show_on => 'Tunjukkan di skrin';

  @override
  String get counter_screen_stagnant_consider => 'Anggap sebagai pegun';

  @override
  String get counter_screen_stagnant_desc =>
      'Objek yang kekal tidak bergerak selama lebih daripada #0 saat akan dianggap pegun';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Awalan Penerangan';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Akhiran Penerangan';

  @override
  String get counter_screen_stagnant_in_seconds => 'dalam saat';

  @override
  String get counter_screen_stagnant_threshold => 'Ambang Pegun';

  @override
  String get default_project_name => 'Projek';

  @override
  String get default_video_name => 'Sumber video';

  @override
  String get default_zone_name => 'Zon pengesanan';

  @override
  String get detection_screen_confidence => 'Keyakinan';

  @override
  String get detection_screen_confidence_desc =>
      'keyakinan melebihi #0 dianggap sebagai pengesanan yang sah';

  @override
  String get detection_screen_consider_valid => 'Anggap sah selepas';

  @override
  String get detection_screen_consider_valid_desc =>
      'Objek jejak akan dianggap sah selepas #0';

  @override
  String get detection_screen_high => 'Tinggi';

  @override
  String get detection_screen_lost => 'Hilang';

  @override
  String get detection_screen_lost_desc =>
      'Menentukan masa penghapusan objek yang hilang secara dinamik antara #0 dan #1 berdasarkan kelajuan pergerakan';

  @override
  String get detection_screen_low => 'Rendah';

  @override
  String get detection_screen_match => 'Padanan';

  @override
  String get detection_screen_match_desc =>
      '#0 matchThreshold ialah parameter utama dalam penjejakan objek yang mengukur tahap padanan antara kotak pengesanan berbeza. Nilai lebih rendah memudahkan pengaitan objek tetapi meningkatkan risiko pengaitan yang salah. Nilai lebih tinggi lebih ketat pada pengaitan objek tetapi mungkin terlepas beberapa padanan sebenar.';

  @override
  String get detection_screen_models => 'Model';

  @override
  String get detection_screen_nms => 'Penindasan Bukan Maksimum';

  @override
  String get detection_screen_nms_desc =>
      '#0 Ambang NMS yang lebih rendah (cth. 0.3-0.4) membuang kotak bertindih dengan lebih ketat dan mengurangkan positif palsu tetapi mungkin terlepas pandang orang bertindih. Ambang yang lebih tinggi (0.7-0.9) mengekalkan lebih banyak kotak yang mungkin meningkatkan positif palsu tetapi mengesan orang bertindih dengan lebih baik.';

  @override
  String get detection_screen_reset => 'Set semula';

  @override
  String get detection_screen_reset_content =>
      'Adakah anda pasti mahu menetapkan semula tetapan pengesanan?';

  @override
  String get detection_screen_title => 'Tetapan Pengesanan';

  @override
  String get error_content =>
      'Ralat tidak dijangka telah berlaku. Adakah anda ingin menghantar laporan e-mel?';

  @override
  String get error_oops => 'Ups, ada masalah';

  @override
  String get error_report => 'E-mel kami';

  @override
  String get filter_screen_desc => 'Pilih julat tapis dari senarai di bawah';

  @override
  String get filter_screen_error_content =>
      'Masa tamat mestilah lebih besar daripada masa mula';

  @override
  String get filter_screen_error_custom => 'Tersuai';

  @override
  String get filter_screen_error_end => 'Tamat';

  @override
  String get filter_screen_error_start => 'Mula';

  @override
  String get filter_screen_error_title => 'Tapisan';

  @override
  String get filter_screen_title => 'Tapis';

  @override
  String get language_screen_language => 'Bahasa';

  @override
  String get main_screen_booting => 'Sedang memulakan...';

  @override
  String get main_screen_checking_hardware => 'Memeriksa perkakasan...';

  @override
  String get no => 'Tidak';

  @override
  String get objects_screen_desc =>
      'Pilih sasaran pengesanan seperti orang, kereta, bas, dan sebagainya.';

  @override
  String get objects_screen_title => 'Objek';

  @override
  String get ok => 'OK';

  @override
  String get open_project_screen_desc =>
      'Buka projek yang dibuat sebelum ini, hanya menyimpan 20 yang terkini.';

  @override
  String get open_project_screen_no_project => 'Tiada projek dijumpai.';

  @override
  String get open_project_screen_title => 'Buka Projek';

  @override
  String get product_copyright => 'Hak Cipta © 2025';

  @override
  String get product_desc =>
      'Menggunakan penglihatan komputer dan kecerdasan buatan untuk mengira orang, kenderaan, haiwan peliharaan, dan banyak lagi.';

  @override
  String get product_name => 'Pengira';

  @override
  String get project_screen_add_video_button => 'Tambah sumber video';

  @override
  String get project_screen_exit_button => 'Keluar';

  @override
  String get project_screen_exit_confirm_content =>
      'Meninggalkan projek akan menghentikan Pengiraan. Adakah anda pasti mahu meneruskan?';

  @override
  String get project_screen_exit_confirm_title => 'Sahkan keluar dari projek';

  @override
  String get project_screen_from_desc =>
      'Kami menyimpan rekod berputar 24 jam, jadi anda boleh melihat mana-mana tempoh masa yang diperlukan.';

  @override
  String get project_screen_report_settings => 'Tetapan';

  @override
  String get project_screen_title => 'Projek';

  @override
  String get project_view_no_videos => 'Tiada sumber video tersedia.';

  @override
  String get settings_screen_center_point_button =>
      'Tunjukkan Titik Tengah pada Sasaran';

  @override
  String get settings_screen_center_point_desc =>
      'Titik tengah membantu menentukan sama ada sasaran berada dalam zon hentaman.';

  @override
  String get settings_screen_center_point_title => 'Titik Tengah pada Sasaran';

  @override
  String get settings_screen_delete_button => 'Padam';

  @override
  String get settings_screen_delete_content =>
      'Adakah anda pasti mahu memadamkan projek ini?';

  @override
  String get settings_screen_delete_header => 'Padam projek ini';

  @override
  String get settings_screen_desc =>
      'Tetapkan nama Projek, parameter pengesanan, pengosongan kiraan.';

  @override
  String get settings_screen_lost_target_button => 'Tunjukkan Sasaran Hilang';

  @override
  String get settings_screen_lost_target_desc =>
      'Apabila penjejakan objek kehilangan sasaran, pilihan ini menjadikannya kelihatan. Secara lalai, sasaran yang hilang tidak ditunjukkan.';

  @override
  String get settings_screen_lost_target_title => 'Sasaran Hilang';

  @override
  String get settings_screen_project_error => 'Nama projek tidak boleh kosong';

  @override
  String get settings_screen_project_id => 'ID Projek';

  @override
  String get settings_screen_project_name => 'Nama Projek';

  @override
  String get settings_screen_project_name_place_holder =>
      '123 Jalan Utama atau Taman Merdeka';

  @override
  String get settings_screen_random_count_button => 'Tambah kiraan rawak';

  @override
  String get settings_screen_reset_count_button => 'Set semula kiraan';

  @override
  String get settings_screen_reset_count_content =>
      'Adakah anda pasti mahu menetapkan semula semua kiraan?';

  @override
  String get settings_screen_reset_count_header =>
      'Set semula semua kiraan dalam projek ini';

  @override
  String get settings_screen_title => 'Tetapan';

  @override
  String get submit => 'Hantar';

  @override
  String get url_screen_desc => 'Sila masukkan URL strim langsung';

  @override
  String get url_screen_title => 'URL Strim Langsung';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream atau rtsp://example.com/stream';

  @override
  String get video_screen_add_point => 'Tambah titik ke zon semasa';

  @override
  String get video_screen_add_zone => 'Tambah zon pengesanan';

  @override
  String get video_screen_change_file => 'Tukar Fail';

  @override
  String get video_screen_delete_button => 'Padam';

  @override
  String get video_screen_delete_content =>
      'Adakah anda pasti mahu memadamkan sumber video ini?';

  @override
  String get video_screen_delete_header => 'Padam sumber video ini';

  @override
  String get video_screen_desc =>
      'Urus sumber video, tambah atau ubah suai zon pengesanan.';

  @override
  String get video_screen_detection => 'Parameter model';

  @override
  String get video_screen_edit_placeholder =>
      'Kamera Pintu Depan atau Kamera Tempat Letak Kereta';

  @override
  String get video_screen_move_bottom => 'Alihkan zon semasa ke bawah';

  @override
  String get video_screen_name_empty => 'Nama video tidak boleh kosong.';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_playback_current => 'semasa: ';

  @override
  String get video_screen_playback_speed => 'Kelajuan Main Balik';

  @override
  String get video_screen_remove_point => 'Buang titik dari zon semasa';

  @override
  String get video_screen_sources =>
      'Konfigurasikan sumber imej, sasaran pengesanan, dan parameter model.';

  @override
  String get video_screen_targets => 'Sasaran pengesanan';

  @override
  String get video_screen_tools => 'Alat';

  @override
  String get video_screen_video_name => 'Nama sumber video';

  @override
  String get video_screen_zones => 'Zon pengesanan';

  @override
  String get video_screen_zones_desc =>
      'Gunakan seret dan lepas untuk melaraskan zon';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_denied => 'Akses ke kamera dinafikan';

  @override
  String get video_sources_camera_denied_msg =>
      'Sila pergi ke tetapan dan benarkan kebenaran akses kamera untuk aplikasi ini.';

  @override
  String get video_sources_camera_not_found_message =>
      'Perlu memberi kebenaran kamera untuk menggunakan kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera tidak dijumpai';

  @override
  String get video_sources_file => 'Fail';

  @override
  String get video_sources_live_stream => 'URL strim langsung';

  @override
  String get video_sources_photos_denied => 'Akses ke foto dinafikan';

  @override
  String get video_sources_photos_denied_msg =>
      'Sila pergi ke tetapan dan benarkan kebenaran akses foto untuk aplikasi ini.';

  @override
  String get video_sources_photos_goto_settings => 'Pergi ke tetapan';

  @override
  String get video_sources_webcam => 'Kamera web';

  @override
  String get video_sources_webcam_not_found_message =>
      'Semak izin aplikasi dan sambungan kamera web';

  @override
  String get video_sources_webcam_not_found_title =>
      'Kamera web tidak dijumpai';

  @override
  String get webcam_manager_webcam => 'Kamera Web';

  @override
  String get webcam_screen_add_title => 'Tambah Kamera Web';

  @override
  String get webcam_screen_edit_title => 'Pilih Kamera Web';

  @override
  String get wizard_screen_about => 'Tentang';

  @override
  String get wizard_screen_desc =>
      'Cipta projek baharu di bawah untuk mula mengira.';

  @override
  String get wizard_screen_email_us => 'E-mel kami';

  @override
  String get wizard_screen_language => 'Bahasa';

  @override
  String get wizard_screen_new_project_from => 'Projek Baharu dari';

  @override
  String get wizard_screen_open_projects => 'Buka projek sedia ada';

  @override
  String get wizard_screen_open_projects_tip =>
      'Semua projek akan disimpan secara automatik dalam peranti';

  @override
  String get yes => 'Ya';

  @override
  String get zone_screen_can_not_delete => 'Tidak boleh memadamkan zon';

  @override
  String get zone_screen_color => 'Warna';

  @override
  String get zone_screen_delete_button => 'Padam';

  @override
  String get zone_screen_delete_content =>
      'Adakah anda pasti mahu memadamkan zon ini?';

  @override
  String get zone_screen_delete_header => 'Padam zon ini';

  @override
  String get zone_screen_desc =>
      'Zon pengesanan boleh menetapkan jenis objek untuk dikesan dan memilih kounter mana yang akan dipaparkan, seperti Dikesan, Tercipta, dan Masuk.';

  @override
  String get zone_screen_name_placeholder =>
      'Nama zon, seperti Kaki Lima atau Tempat Letak Kereta';

  @override
  String get zone_screen_one_zone_required =>
      'Sekurang-kurangnya satu zon diperlukan.';

  @override
  String get zone_screen_zone => 'Zon';

  @override
  String get zone_screen_zone_color => 'Warna zon';

  @override
  String get zone_screen_zone_name_required => 'Nama zon tidak boleh kosong';

  @override
  String get zone_screen_zone_show_summary => 'Papar ringkasan pada skrin';
}
