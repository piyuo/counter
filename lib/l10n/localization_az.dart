// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class LocalizationAz extends Localization {
  LocalizationAz([String locale = 'az']) : super(locale);

  @override
  String get product_name => 'Sayğac';

  @override
  String get product_desc => 'Kompüter görmə və süni intellektdən istifadə edərək insanları, nəqliyyat vasitələrini, ev heyvanlarını və digərlərini saymaq üçün.';

  @override
  String get product_copyright => 'Müəllif hüququ © 2025';

  @override
  String get video_sources_webcam => 'Veb-kamera';

  @override
  String get video_sources_live_stream => 'Canlı yayım URL';

  @override
  String get video_sources_file => 'Fayl';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kamera tapılmadı';

  @override
  String get video_sources_camera_not_found_message => 'Kameradan istifadə etmək üçün kamera icazəsi tələb olunur';

  @override
  String get video_sources_webcam_not_found_title => 'Veb-kamera tapılmadı';

  @override
  String get video_sources_webcam_not_found_message => 'Xahiş edirik hər hansı veb-kameranın qoşulu olduğunu yoxlayın';

  @override
  String get wizard_screen_desc => 'Saymağa başlamaq üçün aşağıda yeni layihə yaradın.';

  @override
  String get wizard_screen_new_project_from => 'Yeni Layihə mənbəyi';

  @override
  String get wizard_screen_language => 'Dil';

  @override
  String get wizard_screen_about => 'Haqqında';

  @override
  String get wizard_screen_open_projects_tip => 'Bütün layihələr avtomatik olaraq yerli cihazda saxlanılacaq';

  @override
  String get wizard_screen_open_projects => 'Mövcud layihəni açın';

  @override
  String get wizard_screen_email_us => 'Bizə yazın';

  @override
  String get language_screen_language => 'Dil';

  @override
  String get project_view_no_videos => 'Video mənbəyi mövcud deyil.';

  @override
  String get about_screen_title => 'Haqqında';

  @override
  String get about_screen_platform => 'Platforma';

  @override
  String get about_screen_app_version => 'Tətbiq Versiyası';

  @override
  String get about_screen_models => 'Obyekt aşkarlama modelləri';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'OpenCV Quraşdırma Məlumatı';

  @override
  String get benchmark_screen_title => 'Model Benchmark-ları';

  @override
  String get benchmark_screen_recommended => 'Tövsiyə olunan Model';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Benchmark-a Başla';

  @override
  String get benchmark_screen_start_failed => 'Benchmark başlamadı, xəta kodu';

  @override
  String get benchmark_screen_models => 'Obyekt aşkarlama modelləri';

  @override
  String get project_screen_title => 'Layihə';

  @override
  String get project_screen_exit_confirm_title => 'Layihədən çıxışı təsdiqləyin';

  @override
  String get project_screen_exit_confirm_content => 'Layihədən çıxmaq saymanı dayandıracaq. Davam etmək istədiyinizə əminsiniz?';

  @override
  String get project_screen_exit_button => 'Çıxış';

  @override
  String get project_screen_add_video_button => 'Video mənbəyi əlavə edin';

  @override
  String get project_screen_from_desc => '24 saatlıq davamlı qeyd saxlayırıq, belə ki, ehtiyacınız olan istənilən vaxt parçasını görə bilərsiniz.';

  @override
  String get project_screen_report_settings => 'Parametrlər';

  @override
  String get filter_screen_title => 'Filtr';

  @override
  String get filter_screen_desc => 'Aşağıdakı siyahıdan bir filtr aralığı seçin';

  @override
  String get filter_screen_error_title => 'Filtr';

  @override
  String get filter_screen_error_content => 'Bitmə vaxtı başlama vaxtından böyük olmalıdır';

  @override
  String get filter_screen_error_custom => 'Xüsusi';

  @override
  String get filter_screen_error_start => 'Başlanğıc';

  @override
  String get filter_screen_error_end => 'Son';

  @override
  String get settings_screen_title => 'Parametrlər';

  @override
  String get settings_screen_desc => 'Layihə adı, aşkarlama parametrləri, sayım təmizləməsini təyin edin.';

  @override
  String get settings_screen_project_id => 'Layihə İd';

  @override
  String get settings_screen_project_name => 'Layihə Adı';

  @override
  String get settings_screen_project_name_place_holder => '123 Əsas Küçə və ya İstiqlaliyyət Prospekti';

  @override
  String get settings_screen_project_error => 'Layihə adı boş ola bilməz';

  @override
  String get settings_screen_random_count_button => 'Təsadüfi saylar əlavə edin';

  @override
  String get settings_screen_reset_count_header => 'Bu layihədəki bütün sayımları sıfırlayın';

  @override
  String get settings_screen_reset_count_button => 'Sayımları sıfırlayın';

  @override
  String get settings_screen_reset_count_content => 'Bütün sayımları sıfırlamaq istədiyinizə əminsiniz?';

  @override
  String get settings_screen_delete_header => 'Bu layihəni silin';

  @override
  String get settings_screen_delete_content => 'Bu layihəni silmək istədiyinizə əminsiniz?';

  @override
  String get settings_screen_delete_button => 'Silin';

  @override
  String get settings_screen_center_point_title => 'Hədəfdə Mərkəz Nöqtəsi';

  @override
  String get settings_screen_center_point_desc => 'Mərkəz nöqtəsi hədəfin vuruş zonasında olub-olmadığını müəyyən etməyə kömək edir.';

  @override
  String get settings_screen_center_point_button => 'Hədəfdə Mərkəz Nöqtəsini Göstərin';

  @override
  String get settings_screen_lost_target_title => 'İtirilmiş Hədəf';

  @override
  String get settings_screen_lost_target_desc => 'Obyekt izləmə hədəfi itirəndə, bu seçim onu görünən edir. Susmaya görə, itirilmiş hədəflər göstərilmir.';

  @override
  String get settings_screen_lost_target_button => 'İtirilmiş Hədəfi Göstərin';

  @override
  String get detection_screen_title => 'Aşkarlama Parametrləri';

  @override
  String get detection_screen_models => 'Modellər';

  @override
  String get detection_screen_confidence => 'Etibarlılıq';

  @override
  String get detection_screen_confidence_desc => 'etibarlılıq #0-dan yuxarı etibarlı hesab edilir';

  @override
  String get detection_screen_low => 'Aşağı';

  @override
  String get detection_screen_high => 'Yüksək';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Daha aşağı NMS hədd (məs., 30%) üst-üstə düşən sərhəd qutularını daha aqressiv şəkildə siləcək, daha yüksək NMS hədd (məs., 0.6) daha çox üst-üstə düşməyə icazə verəcək';

  @override
  String get detection_screen_match => 'Uyğunluq';

  @override
  String get detection_screen_match_desc => 'Uyğunluq #0-dan çox olduqda eyni obyekt hesab edilir.';

  @override
  String get detection_screen_lost => 'İtirilmə';

  @override
  String get detection_screen_lost_desc => 'İzlənən obyekt #0 qədər itirildikdə silinəcək';

  @override
  String get detection_screen_consider_valid => 'Etibarlı hesab edilmə müddəti';

  @override
  String get detection_screen_consider_valid_desc => 'İzlənən obyekt #0 sonra etibarlı hesab ediləcək';

  @override
  String get detection_screen_reset => 'Sıfırla';

  @override
  String get detection_screen_reset_content => 'Aşkarlama parametrlərini sıfırlamaq istədiyinizə əminsiniz?';

  @override
  String get url_screen_title => 'Canlı yayım URL';

  @override
  String get url_screen_desc => 'Zəhmət olmasa canlı yayım URL daxil edin';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream və ya rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Video mənbəyi əlavə edin';

  @override
  String get add_video_screen_from => 'Video mənbəyini buradan əlavə edin';

  @override
  String get webcam_screen_add_title => 'Veb-kamera əlavə edin';

  @override
  String get webcam_screen_edit_title => 'Veb-kamera seçin';

  @override
  String get webcam_manager_webcam => 'Veb-kamera';

  @override
  String get camera_screen_front_camera => 'Ön Kamera';

  @override
  String get camera_screen_back_camera => 'Arxa Kamera';

  @override
  String get camera_screen_add_title => 'Kamera əlavə edin';

  @override
  String get camera_screen_edit_title => 'Kamera seçin';

  @override
  String get camera_screen_zoom_level => 'Zoom Səviyyəsi';

  @override
  String get video_screen_name_empty => 'Video adı boş ola bilməz.';

  @override
  String get video_screen_desc => 'Video mənbələrini idarə edin, aşkarlama zonalarını əlavə edin və ya dəyişdirin.';

  @override
  String get video_screen_video_name => 'Video mənbəyi adı';

  @override
  String get video_screen_edit_placeholder => 'Ön Qapı Kamerası və ya Avtomobil Dayanacağı Kamerası';

  @override
  String get video_screen_change_file => 'Faylı dəyişdirin';

  @override
  String get video_screen_add_zone => 'Aşkarlama zonası əlavə edin';

  @override
  String get video_screen_zones => 'Aşkarlama zonaları';

  @override
  String get video_screen_zones_desc => 'Zonaları tənzimləmək üçün sürüklə-burax istifadə edin';

  @override
  String get video_screen_tools => 'Alətlər';

  @override
  String get video_screen_move_bottom => 'Cari zonanı aşağıya köçürün';

  @override
  String get video_screen_add_point => 'Cari zonaya nöqtə əlavə edin';

  @override
  String get video_screen_remove_point => 'Cari zonadan nöqtəni silin';

  @override
  String get video_screen_playback_speed => 'Oynatma Sürəti';

  @override
  String get video_screen_playback_current => 'cari: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Bu video mənbəyini silin';

  @override
  String get video_screen_delete_content => 'Bu video mənbəyini silmək istədiyinizə əminsiniz?';

  @override
  String get video_screen_delete_button => 'Silin';

  @override
  String get video_screen_sources => 'Şəkil mənbəyi, aşkarlama hədəfləri və model parametrlərini konfiqurasiya edin.';

  @override
  String get video_screen_targets => 'Aşkarlama hədəfləri';

  @override
  String get video_screen_detection => 'Model parametrləri';

  @override
  String get color_screen_title => 'Rəng seçin';

  @override
  String get zone_screen_desc => 'Aşkarlama zonası aşkarlanacaq obyekt növlərini təyin edə və hansı sayğacların, məsələn, Aşkar edilmiş, Yaradılmış və Daxil olmuş kimi göstəriləcəyini seçə bilər.';

  @override
  String get zone_screen_name_placeholder => 'Zonanın adı, Səki və ya Avtomobil Dayanacağı kimi';

  @override
  String get zone_screen_zone_color => 'Zona rəngi';

  @override
  String get zone_screen_color => 'Rəng';

  @override
  String get zone_screen_delete_header => 'Bu zonanı silin';

  @override
  String get zone_screen_delete_content => 'Bu zonanı silmək istədiyinizə əminsiniz?';

  @override
  String get zone_screen_delete_button => 'Silin';

  @override
  String get zone_screen_can_not_delete => 'Zona silinə bilməz';

  @override
  String get zone_screen_one_zone_required => 'Ən azı bir zona tələb olunur.';

  @override
  String get zone_screen_zone_name_required => 'Zona adı boş ola bilməz';

  @override
  String get counter_screen_show_on => 'Ekranda göstərin';

  @override
  String get counter_screen_enabled => 'Aktivdir';

  @override
  String get counter_screen_reentry_threshold => 'Yenidən giriş hədd';

  @override
  String get counter_screen_reentry_desc => 'Obyektlər yenidən girişi aktivləşdirmək üçün hər çıxış və yenidən giriş arasında #1 saniyəlik soyuma ilə #0 dəfə daxil olmalıdır';

  @override
  String get counter_screen_reentry_title => 'Yenidən giriş sayı';

  @override
  String get counter_screen_cooldown_threshold => 'Soyuma müddəti hədd';

  @override
  String get counter_screen_cooldown_desc => 'Yenidən giriş aşkarlama zonasından çıxdıqdan sonra #0 saniyəlik soyuma tələb edir';

  @override
  String get counter_screen_cooldown_time => 'Soyuma vaxtı';

  @override
  String get counter_screen_cooldown_in_seconds => 'saniyələrlə';

  @override
  String get counter_screen_stagnant_threshold => 'Durğunluq hədd';

  @override
  String get counter_screen_stagnant_desc => '#0 saniyədən çox hərəkətsiz qalan obyektlər durğun hesab ediləcək';

  @override
  String get counter_screen_stagnant_consider => 'Durğun hesab edin';

  @override
  String get counter_screen_stagnant_in_seconds => 'saniyələrlə';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Təsvir Prefiksi';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Təsvir Suffiksi';

  @override
  String get counter_screen_name_error => 'Sayğac adı boş ola bilməz';

  @override
  String get counter_screen_enabled_error => 'Xəta';

  @override
  String get counter_screen_enabled_error_content => 'Əvvəlcə digər sayğacı aktiv etməlisiniz, sonra bu sayğacı deaktiv edə bilərsiniz';

  @override
  String get objects_screen_title => 'Obyektlər';

  @override
  String get objects_screen_desc => 'İnsan, avtomobil, avtobus və s. kimi aşkarlama hədəflərini seçin.';

  @override
  String get open_project_screen_title => 'Layihə Açın';

  @override
  String get open_project_screen_desc => 'Əvvəlcədən yaradılmış layihələri açın, yalnız ən son 20-ni saxlayın.';

  @override
  String get open_project_screen_no_project => 'Layihə tapılmadı.';

  @override
  String get default_project_name => 'Layihə';

  @override
  String get default_video_name => 'Video mənbəyi';

  @override
  String get default_zone_name => 'Aşkarlama zonası';

  @override
  String get error_oops => 'Bağışlayın, xəta baş verdi';

  @override
  String get error_content => 'Gözlənilməz xəta baş verdi. E-poçt hesabatı göndərmək istəyirsiniz?';

  @override
  String get error_report => 'Bizə yazın';

  @override
  String get submit => 'Təqdim edin';

  @override
  String get ok => 'Oldu';

  @override
  String get cancel => 'Ləğv edin';

  @override
  String get yes => 'Bəli';

  @override
  String get no => 'Xeyr';

  @override
  String get close => 'Bağlayın';

  @override
  String get back => 'Geri';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zona';

  @override
  String get zone_screen_zone_show_summary => 'Ekranda xülasə göstər';
}
