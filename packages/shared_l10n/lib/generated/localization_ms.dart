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
  String get about_screen_email_us => 'E-mel kami';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Muncul';

  @override
  String get appeared_help =>
      'Mengira bilangan orang atau kenderaan yang kedudukan pertama dikesan berada di dalam kawasan ini.\\n\\nMembantu memahami di mana penjejakan bermula.\\n\\n(Untuk pengguna lanjutan)';

  @override
  String get average_occupancy => 'Purata Bilangan';

  @override
  String get average_occupancy_help =>
      'Menunjukkan purata bilangan orang atau kenderaan di kawasan ini sepanjang tetingkap pengiraan semasa.\\n\\nIni membantu menunjukkan tahap kesibukan kawasan sepanjang tempoh pengiraan.';

  @override
  String get average_stay => 'Purata Tempoh Tinggal';

  @override
  String get average_stay_help =>
      'Menunjukkan purata tempoh orang atau kenderaan berada di kawasan ini.\\n\\nPurata tempoh yang lebih lama mungkin menunjukkan pelanggan meluangkan lebih banyak masa di kawasan ini.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter menggunakan kamera dan AI pada peranti untuk mengira orang. Mula-mula, pastikan peranti anda serasi.';

  @override
  String get camera_test_screen_instruction =>
      'Halakan kamera ke arah orang. Aplikasi akan melukis kotak di sekeliling orang yang dikesan.';

  @override
  String get camera_test_screen_next => 'Ketik Seterusnya untuk meneruskan.';

  @override
  String get camera_test_screen_start =>
      'Ketik Mula. Jika diminta, benarkan akses kamera.';

  @override
  String get camera_test_screen_test_failed => 'Ujian gagal!';

  @override
  String get camera_test_screen_test_passed => 'Ujian berjaya!';

  @override
  String get camera_test_screen_title => 'Ujian Kamera AI';

  @override
  String get camera_test_screen_wait => 'Menunggu AI mengesan orang…';

  @override
  String get cta_screen_custom => 'Gunakan Pelayan Sendiri';

  @override
  String get cta_screen_custom_help =>
      'Hantar data trafik terus ke backend atau pangkalan data anda.';

  @override
  String get cta_screen_footer =>
      'Dengan meneruskan, anda bersetuju dengan Syarat Perkhidmatan, Dasar Privasi dan Perjanjian Pemprosesan Data.';

  @override
  String get cta_screen_invitation => 'Gunakan Kod Jemputan';

  @override
  String get cta_screen_invitation_help =>
      'Sertai organisasi sedia ada menggunakan jemputan daripada pentadbir.';

  @override
  String get cta_screen_local => 'Peranti Ini Sahaja';

  @override
  String get cta_screen_local_help =>
      'Simpan data trafik hanya pada peranti ini. Tiada data dimuat naik.';

  @override
  String get cta_screen_piyuo => 'Pilih Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Simpan data trafik di Piyuo Cloud dengan papan pemuka dan cerapan perniagaan.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter menghasilkan statistik trafik tanpa nama setiap 5 minit.\\nPilih cara anda mahu menyimpan dan mengakses data anda.';

  @override
  String get current_occupancy => 'Bilangan Semasa';

  @override
  String get current_occupancy_help =>
      'Menunjukkan bilangan semasa orang atau kenderaan di kawasan ini.\\n\\nNombor ini dikemas kini secara masa nyata dan membantu memastikan pengesanan AI sepadan dengan apa yang anda lihat pada skrin. Ia tidak disertakan dalam data telemetri yang dimuat naik.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Menyimpan...';

  @override
  String get custom_server_screen_server_url_label => 'URL Pelayan';

  @override
  String get detection_screen_confidence => 'Ambang Keyakinan';

  @override
  String get detection_screen_confidence_dialog =>
      'Mengawal sejauh mana AI perlu yakin sebelum mengira seseorang atau kenderaan.\\nNilai lebih rendah\\n• Mengesan lebih banyak objek\\n• Lebih baik untuk objek jauh atau separa tersembunyi\\n• Boleh meningkatkan pengesanan palsu\\nNilai lebih tinggi\\n• Hanya mengira pengesanan keyakinan tinggi\\n• Mengurangkan pengesanan palsu\\n• Boleh terlepas objek kecil atau sukar\\nGunakan nilai lebih rendah jika apl terlepas orang atau kenderaan.\\nGunakan nilai lebih tinggi jika apl mengira bayangan, pantulan, atau objek palsu lain.';

  @override
  String get detection_screen_confidence_help =>
      'Keyakinan minimum yang diperlukan untuk mengesan objek.';

  @override
  String get detection_screen_confidence_max_label => 'Ketat';

  @override
  String get detection_screen_confidence_min_label => 'Longgar';

  @override
  String get detection_screen_disappear => 'Tempoh Tamat Hilang';

  @override
  String get detection_screen_disappear_dialog =>
      'Menentukan berapa lama AI menunggu sebelum menandakan objek sebagai hilang selepas ia tidak lagi dikesan.\\nNilai lebih pendek\\n• Menandakan objek hilang dengan lebih cepat\\n• Lebih baik untuk trafik pantas\\n• Boleh menandakan objek yang tersembunyi sementara sebagai hilang\\nNilai lebih panjang\\n• Menunggu lebih lama sebelum menandakan objek hilang\\n• Lebih baik apabila objek dihalang atau terlepas seketika\\n• Melewatkan peristiwa kehilangan';

  @override
  String get detection_screen_disappear_help =>
      'Berapa lama AI menunggu sebelum menandakan objek sebagai hilang selepas tidak lagi mengesannya.';

  @override
  String get detection_screen_disappear_max_label => 'Perlahan';

  @override
  String get detection_screen_disappear_min_label => 'Pantas';

  @override
  String get detection_screen_memory_dialog =>
      'Mengawal berapa lama AI mengingati objek selepas ia hilang.\\nTingkatkan nilai ini jika orang atau kenderaan kerap tersembunyi di belakang objek lain.\\nKurangkan nilai ini jika objek disambungkan secara salah selepas meninggalkan tempat kejadian.';

  @override
  String get detection_screen_min_presence => 'Tempoh Kehadiran Minimum';

  @override
  String get detection_screen_min_presence_help =>
      'Objek mesti kekal kelihatan sebelum dikira. Nilai lebih tinggi membantu mengurangkan pengesanan palsu yang singkat.';

  @override
  String get detection_screen_min_presence_max_label => 'Lebih Selamat';

  @override
  String get detection_screen_min_presence_min_label => 'Lebih Pantas';

  @override
  String get detection_screen_minimum_visible =>
      'Objek mesti kekal kelihatan selama tempoh ini sebelum dikira.\\nTingkatkan nilai ini untuk mengabaikan pengesanan palsu yang singkat.\\nKurangkan nilai ini jika orang atau kenderaan yang bergerak pantas terlepas.';

  @override
  String get detection_screen_new_track => 'Ambang Jejak Baharu';

  @override
  String get detection_screen_new_track_help =>
      'Keyakinan minimum untuk mula menjejak objek baharu. Nilai rendah boleh menghasilkan jejak pendua.';

  @override
  String get detection_screen_new_track_max_label => 'Konservatif';

  @override
  String get detection_screen_new_track_min_label => 'Agresif';

  @override
  String get detection_screen_reset => 'Set semula';

  @override
  String get detection_screen_reset_content =>
      'Adakah anda pasti mahu menetapkan semula tetapan pengesanan?';

  @override
  String get detection_screen_show_track_id => 'Tampilkan ID Penjejakan';

  @override
  String get detection_screen_show_track_id_help =>
      'Aktifkan pilihan ini untuk menampilkan ID penjejakan unik untuk setiap objek yang dijejaki.';

  @override
  String get detection_screen_stay => 'Tempoh Tinggal';

  @override
  String get detection_screen_stay_help =>
      'Berapa lama objek mesti berada dalam kawasan sebelum dikira sebagai tinggal.';

  @override
  String get detection_screen_stay_max_label => 'Ditunda';

  @override
  String get detection_screen_stay_min_label => 'Serta-merta';

  @override
  String get detection_screen_stay_threshold =>
      'Menentukan bila objek menyumbang kepada kiraan Stay (Tinggal).\\nNilai lebih pendek\\n• Mengira tinggal serta-merta\\n• Lebih baik untuk analisis pantas\\nNilai lebih panjang\\n• Mengabaikan lalu lintas laluan sekilas\\n• Lebih baik untuk pengukuran penghunian';

  @override
  String get detection_screen_subtitle =>
      'Laraskan cara AI mengesan dan menjejak objek.';

  @override
  String get detection_screen_title => 'Penjejakan & Pengiraan';

  @override
  String get detection_screen_track_dialog =>
      'Mengawal bila objek yang baru dikesan menjadi trek baharu.\\nNilai lebih rendah\\n• Penjejakan bermula lebih awal\\n• Lebih baik untuk objek yang bergerak pantas\\n• Boleh mencipta trek berganda\\nNilai lebih tinggi\\n• Memerlukan bukti lebih kukuh sebelum mencipta trek baharu\\n• Mengurangkan trek berganda\\n• Boleh melewatkan penjejakan objek baharu';

  @override
  String get detection_screen_track_memory => 'Memori Penjejakan';

  @override
  String get detection_screen_track_memory_help =>
      'Berapa lama objek terus dijejak selepas hilang sementara. Nilai lebih tinggi membantu memulihkan penjejakan selepas halangan singkat.';

  @override
  String get detection_screen_track_memory_max_label => 'Panjang';

  @override
  String get detection_screen_track_memory_min_label => 'Pendek';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter menggunakan kamera anda untuk mengesan pejalan kaki dan kenderaan dalam masa nyata. Peranti ini tidak mempunyai kamera yang tersedia.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Cuba buka aplikasi ini pada telefon anda';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Telefon pintar atau tablet dengan kamera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Peranti iOS atau Android disyorkan';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Apa yang anda perlukan';

  @override
  String get device_not_supported_screen_title => 'Kamera tidak ditemui';

  @override
  String get disappeared => 'Hilang';

  @override
  String get disappeared_help =>
      'Mengira bilangan orang atau kenderaan yang kedudukan terakhir dikesan berada di dalam kawasan ini.\\n\\nPenjejakan berakhir selepas Tempoh Hilang yang ditetapkan jika orang atau kenderaan tidak lagi dikesan.\\n\\n(Untuk pengguna lanjutan)';

  @override
  String get dpa => 'Perjanjian Pemprosesan Data';

  @override
  String get durationDaysShort => '%sh';

  @override
  String get durationHoursShort => '%sj';

  @override
  String get durationMinutesShort => '%sm';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Masuk';

  @override
  String get entered_help =>
      'Mengira bilangan orang atau kenderaan yang memasuki kawasan ini semasa tetingkap pengiraan semasa.\\n\\nSatu kemasukan dikira apabila seseorang atau kenderaan bergerak dari luar kawasan ke dalam kawasan.';

  @override
  String get exited => 'Keluar';

  @override
  String get exited_help =>
      'Mengira bilangan orang atau kenderaan yang keluar dari kawasan ini semasa tetingkap pengiraan semasa.\\n\\nSatu keluar dikira apabila seseorang atau kenderaan bergerak dari dalam kawasan ke luar kawasan.';

  @override
  String get language_screen_language => 'Bahasa';

  @override
  String get language_screen_subtitle =>
      'Pilih bahasa yang digunakan dalam aplikasi.';

  @override
  String get local_only_screen_body =>
      'Mod Peranti Tempatan Sahaja membolehkan anda mencuba pengesanan dan penjejakan kamera AI tanpa memuat naik sebarang data. Semua statistik lalu lintas pejalan kaki diproses hanya pada peranti ini, sesuai untuk diuji sebelum menyambung ke pelayan.';

  @override
  String get local_only_screen_use_action => 'Gunakan Peranti Tempatan Sahaja';

  @override
  String get local_screen_text =>
      'Piyuo Counter akan berjalan sepenuhnya pada peranti ini.\\nStatistik trafik hanya disimpan pada peranti ini dan tidak akan dimuat naik.\\nAnda boleh menyambung ke Piyuo Cloud atau pelayan sendiri kemudian melalui Tetapan.';

  @override
  String get maximum_occupancy => 'Bilangan Maksimum';

  @override
  String get maximum_occupancy_help =>
      'Menunjukkan bilangan tertinggi orang atau kenderaan yang berada di kawasan ini pada masa yang sama sepanjang tetingkap pengiraan semasa.\\n\\nBerguna untuk mengenal pasti waktu paling sibuk.';

  @override
  String get maximum_stay => 'Tempoh Tinggal Maksimum';

  @override
  String get maximum_stay_help =>
      'Menunjukkan tempoh paling lama seseorang atau kenderaan berada di kawasan ini sepanjang tetingkap pengiraan semasa.\\n\\nBerguna untuk mengenal pasti lawatan atau hentian yang luar biasa lama.';

  @override
  String get metric_events => 'Peristiwa';

  @override
  String get metric_live => 'Langsung';

  @override
  String get metric_show_less => 'Tunjuk kurang';

  @override
  String get metric_show_more => 'Tunjuk lagi';

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
  String get metrics_counting_window => 'Statistik bagi setiap tempoh 5 minit';

  @override
  String get onboarding_back_action => 'Kembali';

  @override
  String get onboarding_cta_no_server => 'Tidak mahu memuat naik data?';

  @override
  String get onboarding_cta_title => 'Ke manakah data anda hendak dihantar?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter menggunakan kamera peranti anda dan AI terbina dalam untuk mengesan orang dan kenderaan secara langsung.\\nMelalui teknologi pengesanan dan penjejakan, ia secara automatik mengira aliran pejalan kaki dan kenderaan — semuanya diproses terus di peranti anda.';

  @override
  String get onboarding_intro_text2 =>
      'Semua pemprosesan AI berlaku secara tempatan di peranti anda. Tiada video, imej, wajah atau identiti dimuat naik.\\nHanya ringkasan tanpa nama setiap 5 minit dikongsi, termasuk statistik kiraan, penghunian, kemasukan, keluar, dan masa tinggal.';

  @override
  String get onboarding_intro_text3 =>
      'Cukup mulakan aplikasi dan biarkan ia berjalan. Piyuo Counter secara automatik terus mengumpul dan menyimpan data trafik.\\nRingkasan data disimpan setiap 5 minit dan dimuat naik setiap jam ke Piyuo Cloud atau pelayan anda sendiri.';

  @override
  String get onboarding_intro_title1 => 'Pengiraan Trafik AI';

  @override
  String get onboarding_intro_title2 => 'Direka untuk Privasi';

  @override
  String get onboarding_intro_title3 => 'Berjalan Automatik 24/7';

  @override
  String get onboarding_next_action => 'Seterusnya';

  @override
  String get onboarding_skip_action => 'Langkau Pengenalan';

  @override
  String get onboarding_start_action => 'Mula';

  @override
  String get passed_by => 'Melepasi';

  @override
  String get passed_by_help =>
      'Mengira bilangan orang atau kenderaan yang melalui kawasan ini semasa tetingkap pengiraan semasa.\\n\\nSetiap orang atau kenderaan dikira sekali sahaja bagi setiap kali melalui kawasan ini.';

  @override
  String get payloads_screen_area => 'Kawasan';

  @override
  String get payloads_screen_confidence => 'Tahap keyakinan';

  @override
  String get payloads_screen_coverage => 'Liputan';

  @override
  String get payloads_screen_delivered => 'Berjaya dihantar';

  @override
  String get payloads_screen_failed_load => 'Gagal memuat payload terkini';

  @override
  String get payloads_screen_frame_processed => 'Bingkai diproses';

  @override
  String get payloads_screen_hour_not_exists => 'Jam ini tidak lagi wujud.';

  @override
  String get payloads_screen_missing_time => 'Masa yang hilang';

  @override
  String get payloads_screen_no_payloads => 'Belum ada payload.';

  @override
  String get payloads_screen_partial =>
      'Tetingkap tamat lebih awal (sebahagian)';

  @override
  String get payloads_screen_partially => 'Sebahagian berjaya dihantar';

  @override
  String get payloads_screen_payload_not_exists =>
      'Payload ini tidak lagi wujud.';

  @override
  String get payloads_screen_pending => 'Menunggu penghantaran';

  @override
  String get payloads_screen_process_fps => 'FPS pemprosesan';

  @override
  String get payloads_screen_resend => 'Hantar semula';

  @override
  String get payloads_screen_select_first =>
      'Pilih sekurang-kurangnya satu tarikh atau jam terlebih dahulu.';

  @override
  String get payloads_screen_subtitle =>
      'Pilih mengikut tarikh atau jam untuk hantar semula';

  @override
  String get payloads_screen_title => 'Payload terkini';

  @override
  String get personal_custom_screen_build_server =>
      'Perlu bantuan menyediakan pelayan anda sendiri?\\nLihat dokumentasi API dan contoh pelayan kami.';

  @override
  String get personal_custom_screen_help_action => 'Buka Dokumentasi API';

  @override
  String get personal_custom_screen_reset_action => 'Mula Semula';

  @override
  String get personal_custom_success_screen_help =>
      'Ketik Start di bawah untuk mula mengira.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Statistik trafik dimuat naik secara automatik setiap jam.\\nAnda juga boleh memuat naiknya secara manual daripada skrin Log Muat Naik.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Pelayan anda belum perlu berada dalam talian.\\nMula mengira sekarang. Anda boleh menyiapkan dan menguji pelayan anda kemudian. Statistik trafik akan kekal pada peranti ini sehingga berjaya dimuat naik.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Statistik trafik akan dihantar ke';

  @override
  String get personal_custom_success_screen_title => 'Pelayan Anda Sedia';

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
      'Tekan \"Start\" di bawah untuk mula mengira.';

  @override
  String get piyuo_server_screen_url_help =>
      'Papan pemuka peribadi Piyuo Cloud anda tersedia di URL ini.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Simpan URL ini untuk mengakses papan pemuka trafik anda daripada peranti lain.';

  @override
  String get piyuo_server_screen_use_action => 'Gunakan Piyuo Cloud';

  @override
  String get privacy => 'Dasar Privasi';

  @override
  String get product_copyright => 'Hak Cipta © 2026';

  @override
  String get product_desc => 'Pengiraan orang dan kenderaan berkuasa AI.';

  @override
  String get settings_screen_custom_subtitle =>
      'Hantar data trafik terus ke backend atau pangkalan data anda.';

  @override
  String get settings_screen_custom_title => 'Gunakan Pelayan Tersuai';

  @override
  String get settings_screen_data_server_label => 'Pelayan Data';

  @override
  String get settings_screen_detection_target => 'Sasaran Pengesanan';

  @override
  String get settings_screen_language_title => 'Bahasa';

  @override
  String get settings_screen_local_subtitle =>
      'Simpan data trafik pada peranti ini sahaja. Tiada apa-apa dimuat naik.';

  @override
  String get settings_screen_local_title => 'Hanya Peranti Tempatan';

  @override
  String get settings_screen_misc_label => 'Lain-lain';

  @override
  String get settings_screen_object_detection => 'Pengesanan Objek';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Simpan data trafik di Piyuo Cloud dengan papan pemuka dan cerapan perniagaan.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Ini akan memadam semua data dan bermula semula. Tindakan ini tidak boleh dibatalkan.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Tetapkan semula semua data?';

  @override
  String get settings_screen_subscription_body =>
      'Urus langganan dan maklumat pengebilan anda';

  @override
  String get settings_screen_subscription_title => 'Langganan';

  @override
  String get start_screen_about => 'Tentang';

  @override
  String get start_screen_server_none =>
      'Data disimpan pada peranti ini sahaja';

  @override
  String get start_screen_server_personal => 'Data dimuat naik setiap jam ke';

  @override
  String get start_screen_settings => 'Tetapan';

  @override
  String get start_screen_upload_logs => 'Muat Naik Log';

  @override
  String get start_screen_video_sources => 'Sumber video';

  @override
  String get stayed => 'Kekal';

  @override
  String get stayed_help =>
      'Mengira bilangan orang atau kenderaan yang berada di kawasan ini sekurang-kurangnya selama Tempoh Tinggal yang ditetapkan.\\n\\nTempoh Tinggal lalai ialah 15 saat dan boleh diubah dalam Tetapan.';

  @override
  String get target_pedestrian => 'Pejalan kaki';

  @override
  String get target_pedestrian_help =>
      'Kira orang menggunakan model pengesanan pejalan kaki';

  @override
  String get target_screen_subtitle => 'Pilih model pengesanan untuk digunakan';

  @override
  String get target_vehicle => 'Kenderaan';

  @override
  String get target_vehicle_help =>
      'Kira kereta dan kenderaan lain menggunakan model kenderaan';

  @override
  String get telemetry_error_connection_refused =>
      'Tidak dapat menghubungi pelayan. Mungkin pelayan sedang luar talian.';

  @override
  String get telemetry_error_connection_reset =>
      'Sambungan telah ditetapkan semula. Sila semak sambungan internet anda dan cuba lagi.';

  @override
  String get telemetry_error_connection_timeout =>
      'Sambungan mengambil masa terlalu lama untuk bertindak balas. Sila semak sambungan internet anda dan cuba lagi.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Alamat pelayan tidak dapat ditemui. Sila semak sambungan internet atau URL pelayan anda.';

  @override
  String get telemetry_error_http_error_status =>
      'Pelayan menolak permintaan tersebut. Sila cuba lagi kemudian.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Ralat tidak dijangka berlaku semasa berkomunikasi dengan pelayan.';

  @override
  String get telemetry_error_invalid_url =>
      'Alamat pelayan tidak sah. Sila semak tetapan anda.';

  @override
  String get telemetry_error_network_error =>
      'Ralat rangkaian berlaku. Sila semak sambungan internet anda dan cuba lagi.';

  @override
  String get telemetry_error_socket_error =>
      'Berlaku masalah sambungan rangkaian. Sila semak sambungan internet anda.';

  @override
  String get telemetry_error_transport_exception =>
      'Sesuatu tidak kena semasa menghantar data. Sila cuba lagi.';

  @override
  String get terms => 'Terma Perkhidmatan';

  @override
  String get upload_screen_attempt_time => 'Masa percubaan:';

  @override
  String get upload_screen_error => 'Ralat:';

  @override
  String get upload_screen_failed => 'Gagal';

  @override
  String get upload_screen_load_error => 'Gagal memuat log muat naik.';

  @override
  String get upload_screen_log_not_exists =>
      'Log muat naik tidak lagi tersedia.';

  @override
  String get upload_screen_next => 'Muat naik seterusnya ...';

  @override
  String get upload_screen_next_upload_prefix => 'Muat naik seterusnya ';

  @override
  String get upload_screen_no_data_server =>
      'Sila tetapkan Pelayan Data terlebih dahulu.';

  @override
  String get upload_screen_no_logs => 'Belum ada log muat naik.';

  @override
  String get upload_screen_payload_count => 'Bilangan Payload';

  @override
  String get upload_screen_payload_count_label => 'Bilangan payload:';

  @override
  String get upload_screen_payload_size => 'Saiz payload:';

  @override
  String get upload_screen_result => 'Keputusan:';

  @override
  String get upload_screen_retry => 'Bilangan cubaan semula:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Berjaya';

  @override
  String get upload_screen_today => 'Hari Ini';

  @override
  String get upload_screen_upload_now => 'Muat naik sekarang';

  @override
  String get upload_screen_upload_success => 'Muat naik berjaya.';

  @override
  String get upload_screen_uploading => 'Sedang memuat naik...';

  @override
  String get upload_screen_yesterday => 'Semalam';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URL RTSP mesti mengandungi nama hos.';

  @override
  String get url_screen_invalid_url_error =>
      'Masukkan URL yang sah dengan skema yang disokong.';

  @override
  String get url_screen_subtitle => 'Sila masukkan URL strim langsung';

  @override
  String get url_screen_title => 'URL Strim Langsung';

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
  String get video_sources_file => 'Fail';

  @override
  String get video_sources_front_camera => 'Kamera hadapan';

  @override
  String get video_sources_live_stream => 'URL strim langsung';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Perlu memberi kebenaran kamera untuk menggunakan kamera';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Kamera tidak dijumpai';

  @override
  String get video_sources_screen_import_error =>
      'Gagal mengimport fail video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Sila pergi ke tetapan dan benarkan kebenaran akses foto untuk aplikasi ini.';

  @override
  String get video_sources_screen_select_camera =>
      'Ketik untuk memilih kamera ini';

  @override
  String get video_sources_screen_select_file => 'Ketik untuk memilih fail';

  @override
  String get video_sources_screen_select_live =>
      'Ketik untuk menetapkan URL siaran langsung';

  @override
  String get video_sources_webcam => 'Kamera web';
}
