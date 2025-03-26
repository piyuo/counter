// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class LocalizationTr extends Localization {
  LocalizationTr([String locale = 'tr']) : super(locale);

  @override
  String get product_name => 'Sayaç';

  @override
  String get product_desc => 'Bilgisayarlı görü ve yapay zeka kullanarak insan, araç, evcil hayvan ve daha fazlasını sayın.';

  @override
  String get product_copyright => 'Telif Hakkı © 2025';

  @override
  String get video_sources_webcam => 'Web Kamerası';

  @override
  String get video_sources_live_stream => 'Canlı yayın URL\'si';

  @override
  String get video_sources_file => 'Dosya';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera bulunamadı';

  @override
  String get video_sources_camera_not_found_message => 'Kamerayı kullanmak için kamera izni vermeniz gerekiyor';

  @override
  String get video_sources_webcam_not_found_title => 'Web kamerası bulunamadı';

  @override
  String get video_sources_webcam_not_found_message => 'Lütfen herhangi bir web kamerasının bağlı olup olmadığını kontrol edin';

  @override
  String get wizard_screen_desc => 'Saymaya başlamak için aşağıdan yeni bir proje oluşturun.';

  @override
  String get wizard_screen_new_project_from => 'Yeni Projeyi Şuradan Oluştur';

  @override
  String get wizard_screen_language => 'Dil';

  @override
  String get wizard_screen_about => 'Hakkında';

  @override
  String get wizard_screen_open_projects_tip => 'Tüm projeler otomatik olarak yerel olarak kaydedilecektir';

  @override
  String get wizard_screen_open_projects => 'Mevcut projeyi aç';

  @override
  String get wizard_screen_email_us => 'Bize e-posta gönderin';

  @override
  String get language_screen_language => 'Dil';

  @override
  String get project_view_no_videos => 'Video kaynağı mevcut değil.';

  @override
  String get about_screen_title => 'Hakkında';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get about_screen_app_version => 'Uygulama Sürümü';

  @override
  String get about_screen_models => 'Nesne algılama modelleri';

  @override
  String get about_screen_benchmark => 'Kıyaslama';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Derleme Bilgisi';

  @override
  String get benchmark_screen_title => 'Model Kıyaslamaları';

  @override
  String get benchmark_screen_recommended => 'Önerilen Model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Kıyaslamayı Başlat';

  @override
  String get benchmark_screen_start_failed => 'Kıyaslama başlatılamadı, hata kodu';

  @override
  String get benchmark_screen_models => 'Nesne algılama modelleri';

  @override
  String get project_screen_title => 'Proje';

  @override
  String get project_screen_exit_confirm_title => 'Projeden çıkışı onaylayın';

  @override
  String get project_screen_exit_confirm_content => 'Projeden ayrılmak Sayımı durduracaktır. Devam etmek istediğinizden emin misiniz?';

  @override
  String get project_screen_exit_button => 'Çıkış';

  @override
  String get project_screen_add_video_button => 'Video kaynağı ekle';

  @override
  String get project_screen_from_desc => 'İhtiyacınız olan herhangi bir zaman dilimini görüntüleyebilmeniz için 24 saatlik kayıt tutuyoruz.';

  @override
  String get project_screen_report_settings => 'Ayarlar';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Aşağıdaki listeden bir filtre aralığı seçin';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'Bitiş zamanı başlangıç zamanından büyük olmalıdır';

  @override
  String get filter_screen_error_custom => 'Özel';

  @override
  String get filter_screen_error_start => 'Başlangıç';

  @override
  String get filter_screen_error_end => 'Bitiş';

  @override
  String get settings_screen_title => 'Ayarlar';

  @override
  String get settings_screen_desc => 'Proje adını, algılama parametrelerini, sayım temizlemeyi ayarlayın.';

  @override
  String get settings_screen_project_id => 'Proje Kimliği';

  @override
  String get settings_screen_project_name => 'Proje Adı';

  @override
  String get settings_screen_project_name_place_holder => '123 Ana Cadde veya Gezi Parkı';

  @override
  String get settings_screen_project_error => 'Proje adı boş olamaz';

  @override
  String get settings_screen_random_count_button => 'Rastgele sayımlar ekle';

  @override
  String get settings_screen_reset_count_header => 'Bu projedeki tüm sayımları sıfırla';

  @override
  String get settings_screen_reset_count_button => 'Sayımları sıfırla';

  @override
  String get settings_screen_reset_count_content => 'Tüm sayımları sıfırlamak istediğinizden emin misiniz?';

  @override
  String get settings_screen_delete_header => 'Bu projeyi sil';

  @override
  String get settings_screen_delete_content => 'Bu projeyi silmek istediğinizden emin misiniz?';

  @override
  String get settings_screen_delete_button => 'Sil';

  @override
  String get settings_screen_center_point_title => 'Hedef Üzerinde Merkez Nokta';

  @override
  String get settings_screen_center_point_desc => 'Merkez noktası, hedefin vuruş bölgesinde olup olmadığını belirlemeye yardımcı olur.';

  @override
  String get settings_screen_center_point_button => 'Hedef Üzerinde Merkez Noktayı Göster';

  @override
  String get settings_screen_lost_target_title => 'Kaybolan Hedef';

  @override
  String get settings_screen_lost_target_desc => 'Nesne izleme bir hedefi kaybettiğinde, bu seçenek onu görünür kılar. Varsayılan olarak, kaybolan hedefler gösterilmez.';

  @override
  String get settings_screen_lost_target_button => 'Kaybolan Hedefi Göster';

  @override
  String get detection_screen_title => 'Algılama Ayarları';

  @override
  String get detection_screen_models => 'Modeller';

  @override
  String get detection_screen_confidence => 'Güven';

  @override
  String get detection_screen_confidence_desc => '#0 üzerindeki güven geçerli bir algılama olarak kabul edilir';

  @override
  String get detection_screen_low => 'Düşük';

  @override
  String get detection_screen_high => 'Yüksek';

  @override
  String get detection_screen_nms => 'Maksimum Olmayan Bastırma';

  @override
  String get detection_screen_nms_desc => '#0 Daha düşük NMS eşiği (örn. %30) örtüşen sınırlayıcı kutuları daha agresif şekilde kaldırırken, daha yüksek NMS eşiği (örn. 0.6) daha fazla örtüşmeye izin verir';

  @override
  String get detection_screen_match => 'Eşleşme';

  @override
  String get detection_screen_match_desc => '#0 üzerinde eşleşme aynı nesne olarak kabul edilir.';

  @override
  String get detection_screen_lost => 'Kayıp';

  @override
  String get detection_screen_lost_desc => 'İzlenen nesne #0 süre kaybolduysa kaldırılır';

  @override
  String get detection_screen_consider_valid => 'Şu kadar sonra geçerli say';

  @override
  String get detection_screen_consider_valid_desc => 'İzlenen nesne #0 sonra geçerli kabul edilir';

  @override
  String get detection_screen_reset => 'Sıfırla';

  @override
  String get detection_screen_reset_content => 'Algılama ayarlarını sıfırlamak istediğinizden emin misiniz?';

  @override
  String get url_screen_title => 'Canlı yayın URL\'si';

  @override
  String get url_screen_desc => 'Lütfen canlı yayın URL\'sini girin';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream veya rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Video kaynağı ekle';

  @override
  String get add_video_screen_from => 'Video kaynağını şuradan ekle';

  @override
  String get webcam_screen_add_title => 'Web Kamerası Ekle';

  @override
  String get webcam_screen_edit_title => 'Web Kamerası Seç';

  @override
  String get webcam_manager_webcam => 'Web Kamerası';

  @override
  String get camera_screen_front_camera => 'Ön Kamera';

  @override
  String get camera_screen_back_camera => 'Arka Kamera';

  @override
  String get camera_screen_add_title => 'Kamera Ekle';

  @override
  String get camera_screen_edit_title => 'Kamera Seç';

  @override
  String get camera_screen_zoom_level => 'Zoom Seviyesi';

  @override
  String get video_screen_name_empty => 'Video adı boş olamaz.';

  @override
  String get video_screen_desc => 'Video kaynaklarını yönetin, algılama bölgeleri ekleyin veya değiştirin.';

  @override
  String get video_screen_video_name => 'Video kaynağı adı';

  @override
  String get video_screen_edit_placeholder => 'Ön Kapı Kamerası veya Otopark Kamerası';

  @override
  String get video_screen_change_file => 'Dosyayı Değiştir';

  @override
  String get video_screen_add_zone => 'Algılama bölgesi ekle';

  @override
  String get video_screen_zones => 'Algılama bölgeleri';

  @override
  String get video_screen_zones_desc => 'Bölgeleri ayarlamak için sürükle ve bırak kullanın';

  @override
  String get video_screen_tools => 'Araçlar';

  @override
  String get video_screen_move_bottom => 'Mevcut bölgeyi alta taşı';

  @override
  String get video_screen_add_point => 'Mevcut bölgeye nokta ekle';

  @override
  String get video_screen_remove_point => 'Mevcut bölgeden noktayı kaldır';

  @override
  String get video_screen_playback_speed => 'Oynatma Hızı';

  @override
  String get video_screen_playback_current => 'mevcut: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Bu video kaynağını sil';

  @override
  String get video_screen_delete_content => 'Bu video kaynağını silmek istediğinizden emin misiniz?';

  @override
  String get video_screen_delete_button => 'Sil';

  @override
  String get video_screen_sources => 'Görüntü kaynağını, algılama hedeflerini ve model parametrelerini yapılandırın.';

  @override
  String get video_screen_targets => 'Algılama hedefleri';

  @override
  String get video_screen_detection => 'Model parametreleri';

  @override
  String get color_screen_title => 'Bir renk seçin';

  @override
  String get zone_screen_desc => 'Algılama bölgesi, algılanacak nesne türlerini ayarlayabilir ve Algılanan, Oluşturulan ve Girilen gibi gösterilecek sayaçları seçebilir.';

  @override
  String get zone_screen_name_placeholder => 'Kaldırım veya Otopark gibi bölgenin adı';

  @override
  String get zone_screen_zone_color => 'Bölge rengi';

  @override
  String get zone_screen_color => 'Renk';

  @override
  String get zone_screen_delete_header => 'Bu bölgeyi sil';

  @override
  String get zone_screen_delete_content => 'Bu bölgeyi silmek istediğinizden emin misiniz?';

  @override
  String get zone_screen_delete_button => 'Sil';

  @override
  String get zone_screen_can_not_delete => 'Bölge silinemiyor';

  @override
  String get zone_screen_one_zone_required => 'En az bir bölge gereklidir.';

  @override
  String get zone_screen_zone_name_required => 'Bölge adı boş olamaz';

  @override
  String get counter_screen_show_on => 'Ekranda göster';

  @override
  String get counter_screen_enabled => 'Etkin';

  @override
  String get counter_screen_reentry_threshold => 'Yeniden Giriş Eşiği';

  @override
  String get counter_screen_reentry_desc => 'Nesneler yeniden girişi tetiklemek için #0 kez girmeli, her çıkış ve yeniden giriş arasında #1 saniyelik bir bekleme süresi olmalıdır';

  @override
  String get counter_screen_reentry_title => 'Yeniden giriş sayısı';

  @override
  String get counter_screen_cooldown_threshold => 'Bekleme Süresi Eşiği';

  @override
  String get counter_screen_cooldown_desc => 'Yeniden giriş için algılama bölgesinden çıktıktan sonra #0 saniyelik bir bekleme süresi gereklidir';

  @override
  String get counter_screen_cooldown_time => 'Bekleme Süresi';

  @override
  String get counter_screen_cooldown_in_seconds => 'saniye cinsinden';

  @override
  String get counter_screen_stagnant_threshold => 'Durağan Eşiği';

  @override
  String get counter_screen_stagnant_desc => '#0 saniyeden fazla hareketsiz kalan nesneler durağan kabul edilecektir';

  @override
  String get counter_screen_stagnant_consider => 'Durağan olarak kabul et';

  @override
  String get counter_screen_stagnant_in_seconds => 'saniye cinsinden';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Açıklama Öneki';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Açıklama Soneki';

  @override
  String get counter_screen_name_error => 'Sayaç adı boş olamaz';

  @override
  String get counter_screen_enabled_error => 'Hata';

  @override
  String get counter_screen_enabled_error_content => 'Önce diğer sayacı etkinleştirmeniz gerekiyor, sonra bu sayacı devre dışı bırakabilirsiniz';

  @override
  String get objects_screen_title => 'Nesneler';

  @override
  String get objects_screen_desc => 'İnsan, araba, otobüs vb. algılama hedeflerini seçin.';

  @override
  String get open_project_screen_title => 'Proje Aç';

  @override
  String get open_project_screen_desc => 'Önceden oluşturulmuş projeleri açın, yalnızca en son 20 tanesini saklayarak.';

  @override
  String get open_project_screen_no_project => 'Proje bulunamadı.';

  @override
  String get default_project_name => 'Proje';

  @override
  String get default_video_name => 'Video kaynağı';

  @override
  String get default_zone_name => 'Algılama bölgesi';

  @override
  String get error_oops => 'Hata oluştu';

  @override
  String get error_content => 'Beklenmeyen bir hata oluştu. E-posta raporu göndermek ister misiniz?';

  @override
  String get error_report => 'Bize e-posta gönderin';

  @override
  String get submit => 'Gönder';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'İptal';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get close => 'Kapat';

  @override
  String get back => 'Geri';

  @override
  String get zone_screen_zone => 'Bölge';

  @override
  String get zone_screen_zone_show_summary => 'Ekranda özet göster';

  @override
  String get video_sources_photos_denied => 'Fotoğraflara erişim reddedildi';

  @override
  String get video_sources_photos_goto_settings => 'Ayarlara git';

  @override
  String get video_sources_camera_denied => 'Kameraya erişim reddedildi';

  @override
  String get video_sources_photos_denied_msg => 'Lütfen ayarlara gidin ve bu uygulama için fotoğraflara erişim izni verin.';

  @override
  String get video_sources_camera_denied_msg => 'Lütfen ayarlara gidin ve bu uygulama için kamera erişim izni verin.';
}
