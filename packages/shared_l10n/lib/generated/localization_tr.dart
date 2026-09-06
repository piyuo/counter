// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class LocalizationTr extends Localization {
  LocalizationTr([String locale = 'tr']) : super(locale);

  @override
  String get about_screen_app_version => 'Uygulama Sürümü';

  @override
  String get about_screen_email_us => 'Bize e-posta gönderin';

  @override
  String get about_screen_platform => 'Platform';

  @override
  String get appeared => 'Göründü';

  @override
  String get appeared_help =>
      'İlk algılanan konumu bu alanın içinde olan kişi veya araçları sayar.\\n\\nTakibin nerede başladığını anlamaya yardımcı olur.\\n\\n(Temel olarak ileri düzey kullanıcılar içindir)';

  @override
  String get average_occupancy => 'Ortalama Kişi Sayısı';

  @override
  String get average_occupancy_help =>
      'Geçerli sayım penceresi boyunca bu alandaki ortalama kişi veya araç sayısını gösterir.\\n\\nBu, alanın tüm sayım süresi boyunca ne kadar yoğun olduğunu anlamanıza yardımcı olur.';

  @override
  String get average_stay => 'Ortalama Kalış Süresi';

  @override
  String get average_stay_help =>
      'Bu alanda kişi veya araçların ortalama kalış süresini gösterir.\\n\\nDaha uzun ortalama kalış süresi, müşterilerin bu alanda daha fazla zaman geçirdiğini gösterebilir.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter, kameranızı ve cihaz üzerindeki yapay zekâyı kullanarak insanları sayar. Önce cihazınızın uyumlu olduğundan emin olalım.';

  @override
  String get camera_test_screen_instruction =>
      'Kamerayı insanlara doğrultun. Uygulama algıladığı kişilerin etrafına kutular çizer.';

  @override
  String get camera_test_screen_next => 'Devam etmek için İleri\'ye dokunun.';

  @override
  String get camera_test_screen_start =>
      'Başlat\'a dokunun. İstenirse kamera erişimine izin verin.';

  @override
  String get camera_test_screen_test_failed => 'Test başarısız!';

  @override
  String get camera_test_screen_test_passed => 'Test başarılı!';

  @override
  String get camera_test_screen_title => 'Yapay Zekâ Kamera Testi';

  @override
  String get camera_test_screen_wait =>
      'Yapay zekânın insanları algılaması bekleniyor…';

  @override
  String get cta_screen_custom => 'Kendi Sunucunuzu Kullanın';

  @override
  String get cta_screen_custom_help =>
      'Trafik verilerini doğrudan kendi arka ucunuza veya veritabanınıza gönderin.';

  @override
  String get cta_screen_footer =>
      'Devam ederek Hizmet Şartları, Gizlilik Politikası ve Veri İşleme Sözleşmesini kabul etmiş olursunuz.';

  @override
  String get cta_screen_invitation => 'Davet Kodunu Kullan';

  @override
  String get cta_screen_invitation_help =>
      'Yöneticinizden aldığınız davetle mevcut bir kuruluşa katılın.';

  @override
  String get cta_screen_local => 'Yalnızca Bu Cihaz';

  @override
  String get cta_screen_local_help =>
      'Yalnızca bu cihazda trafik verilerini saklayın. Hiçbir veri yüklenmez.';

  @override
  String get cta_screen_piyuo => 'Piyuo Cloud\'u Kullan';

  @override
  String get cta_screen_piyuo_help =>
      'Trafik verilerini Piyuo Cloud\'da saklayın; panolar ve iş analizlerinden yararlanın.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter her 5 dakikada anonim trafik istatistikleri oluşturur.\\nVerilerinizi nasıl saklamak ve erişmek istediğinizi seçin.';

  @override
  String get current_occupancy => 'Güncel Sayı';

  @override
  String get current_occupancy_help =>
      'Bu alandaki kişi veya araçların güncel sayısını gösterir.\\n\\nBu sayı gerçek zamanlı olarak güncellenir ve AI algılamasının ekranda gördüğünüzle eşleşip eşleşmediğini kontrol etmenize yardımcı olur. Yüklenen telemetri verilerine dahil edilmez.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Kaydediliyor...';

  @override
  String get custom_server_screen_server_url_label => 'Sunucu URL\'si';

  @override
  String get detection_screen_confidence => 'Güven Eşiği';

  @override
  String get detection_screen_confidence_dialog =>
      'Bir kişiyi veya aracı saymadan önce yapay zekanın ne kadar emin olması gerektiğini kontrol eder.\\nDaha düşük değerler\\n• Daha fazla nesne algılar\\n• Uzak veya kısmen gizli nesneler için daha iyidir\\n• Yanlış algılamaları artırabilir\\nDaha yüksek değerler\\n• Yalnızca yüksek güvenilirlikli algılamaları sayar\\n• Yanlış algılamaları azaltır\\n• Küçük veya zor nesneleri kaçırabilir\\nUygulama insanları veya araçları kaçırıyorsa daha düşük bir değer kullanın.\\nUygulama gölgeleri, yansımaları veya diğer yanlış nesneleri sayıyorsa daha yüksek bir değer kullanın.';

  @override
  String get detection_screen_confidence_help =>
      'Bir nesneyi algılamak için gereken minimum güven seviyesi.';

  @override
  String get detection_screen_confidence_max_label => 'Sıkı';

  @override
  String get detection_screen_confidence_min_label => 'Gevşek';

  @override
  String get detection_screen_disappear => 'Kaybolma Zaman Aşımı';

  @override
  String get detection_screen_disappear_dialog =>
      'Bir nesne artık algılanmadıktan sonra yapay zekanın onu kayboldu olarak işaretlemeden önce ne kadar beklediğini belirler.\\nDaha kısa değerler\\n• Nesneleri daha erken kayboldu olarak işaretler\\n• Hızlı trafik için daha iyidir\\n• Geçici olarak gizlenen nesneleri yanlışlıkla kayboldu olarak işaretleyebilir\\nDaha uzun değerler\\n• Nesneleri kayboldu olarak işaretlemeden önce daha uzun bekler\\n• Nesneler kısa süreliğine engellendiğinde veya kaçırıldığında daha iyidir\\n• Kayboluş olaylarını geciktirir';

  @override
  String get detection_screen_disappear_help =>
      'Yapay zekânın artık algılayamadığı bir nesneyi kaybolmuş olarak işaretlemeden önce ne kadar bekleyeceğini belirler.';

  @override
  String get detection_screen_disappear_max_label => 'Yavaş';

  @override
  String get detection_screen_disappear_min_label => 'Hızlı';

  @override
  String get detection_screen_memory_dialog =>
      'Bir nesne kaybolduktan sonra yapay zekanın onu ne kadar süre hatırladığını kontrol eder.\\nİnsanlar veya araçlar sık sık diğer nesnelerin arkasında gizleniyorsa bu değeri artırın.\\nNesneler sahneden ayrıldıktan sonra yanlış bağlanıyorsa bu değeri azaltın.';

  @override
  String get detection_screen_min_presence => 'Minimum Görünme Süresi';

  @override
  String get detection_screen_min_presence_help =>
      'Bir nesne sayılmadan önce görünür kalmalıdır. Daha yüksek değerler kısa süreli yanlış algılamaları azaltmaya yardımcı olur.';

  @override
  String get detection_screen_min_presence_max_label => 'Daha Güvenli';

  @override
  String get detection_screen_min_presence_min_label => 'Daha Hızlı';

  @override
  String get detection_screen_minimum_visible =>
      'Nesneler sayılmadan önce bu kadar süre görünür kalmalıdır.\\nKısa süreli yanlış algılamaları göz ardı etmek için bu değeri artırın.\\nHızlı hareket eden insanlar veya araçlar kaçırılıyorsa bu değeri azaltın.';

  @override
  String get detection_screen_new_track => 'Yeni İzleme Eşiği';

  @override
  String get detection_screen_new_track_help =>
      'Yeni bir nesneyi izlemeye başlamak için gereken minimum güven seviyesi. Düşük değerler yinelenen izler oluşturabilir.';

  @override
  String get detection_screen_new_track_max_label => 'Muhafazakâr';

  @override
  String get detection_screen_new_track_min_label => 'Agresif';

  @override
  String get detection_screen_reset => 'Sıfırla';

  @override
  String get detection_screen_reset_content =>
      'Algılama ayarlarını sıfırlamak istediğinizden emin misiniz?';

  @override
  String get detection_screen_show_track_id => 'Track ID\'sini Göster';

  @override
  String get detection_screen_show_track_id_help =>
      'Bu seçeneği etkinleştirerek, izlenen her nesne için benzersiz track ID\'lerini görüntüleyin.';

  @override
  String get detection_screen_stay => 'Kalma Süresi';

  @override
  String get detection_screen_stay_help =>
      'Bir nesnenin kalma olarak sayılması için alanda ne kadar süre kalması gerektiğini belirler.';

  @override
  String get detection_screen_stay_max_label => 'Gecikmeli';

  @override
  String get detection_screen_stay_min_label => 'Anında';

  @override
  String get detection_screen_stay_threshold =>
      'Bir nesnenin ne zaman Kalış sayımına katkıda bulunduğunu belirler.\\nDaha kısa değerler\\n• Kalışı hemen sayar\\n• Hızlı analiz için daha iyidir\\nDaha uzun değerler\\n• Kısa geçiş trafiğini yok sayar\\n• Doluluk ölçümü için daha iyidir';

  @override
  String get detection_screen_subtitle =>
      'Yapay zekânın nesneleri algılama ve takip etme şeklini ayarlayın.';

  @override
  String get detection_screen_title => 'Takip ve Sayma';

  @override
  String get detection_screen_track_dialog =>
      'Yeni algılanan bir nesnenin ne zaman yeni bir iz haline geldiğini kontrol eder.\\nDaha düşük değerler\\n• İzleme daha erken başlar\\n• Hızlı hareket eden nesneler için daha iyidir\\n• Yinelenen izler oluşturabilir\\nDaha yüksek değerler\\n• Yeni bir iz oluşturmadan önce daha güçlü kanıt gerektirir\\n• Yinelenen izleri azaltır\\n• Yeni nesnelerin izlenmesini geciktirebilir';

  @override
  String get detection_screen_track_memory => 'İzleme Belleği';

  @override
  String get detection_screen_track_memory_help =>
      'Bir nesne geçici olarak kaybolduktan sonra izlemenin ne kadar sürdürüleceğini belirler. Daha yüksek değerler kısa süreli engellerden sonra takibi geri kazanmaya yardımcı olur.';

  @override
  String get detection_screen_track_memory_max_label => 'Uzun';

  @override
  String get detection_screen_track_memory_min_label => 'Kısa';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter, yayaları ve araçları gerçek zamanlı algılamak için kameranızı kullanır. Bu cihazda kullanılabilir bir kamera yok.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Bu uygulamayı telefonunuzda açmayı deneyin';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Kameralı bir akıllı telefon veya tablet';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'iOS veya Android cihaz önerilir';

  @override
  String get device_not_supported_screen_requirements_title =>
      'İhtiyacınız olanlar';

  @override
  String get device_not_supported_screen_title => 'Kamera bulunamadı';

  @override
  String get disappeared => 'Kayboldu';

  @override
  String get disappeared_help =>
      'Son algılanan konumu bu alanın içinde olan kişi veya araçları sayar.\\n\\nKişi veya araç artık algılanmazsa, izleme ayarlanan Kaybolma Süresi sonunda sona erer.\\n\\n(Temel olarak ileri düzey kullanıcılar içindir)';

  @override
  String get dpa => 'Veri İşleme Sözleşmesi';

  @override
  String get durationDaysShort => '%sg';

  @override
  String get durationHoursShort => '%ssa';

  @override
  String get durationMinutesShort => '%sdk';

  @override
  String get durationSecondsShort => '%ssn';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Girdi';

  @override
  String get entered_help =>
      'Geçerli sayım penceresi sırasında bu alana giren kişi veya araçları sayar.\\n\\nBir kişi veya araç alanın dışından içine geçtiğinde bir giriş sayılır.';

  @override
  String get exited => 'Çıktı';

  @override
  String get exited_help =>
      'Bu alandan geçerli sayım penceresi sırasında çıkan kişi veya araçları sayar.\\n\\nBir kişi veya araç alanın içinden dışına geçtiğinde bir çıkış sayılır.';

  @override
  String get language_screen_language => 'Dil';

  @override
  String get language_screen_subtitle => 'Uygulamada kullanılacak dili seçin.';

  @override
  String get local_only_screen_body =>
      '\'Yalnızca Yerel Cihaz\' modu, herhangi bir veri yüklemeden AI kamera algılama ve izlemeyi denemenizi sağlar. Tüm yaya trafiği istatistikleri yalnızca bu cihazda işlenir, sunucuya bağlanmadan önce test etmek için idealdir.';

  @override
  String get local_only_screen_use_action => 'Yalnızca Yerel Cihazı Kullan';

  @override
  String get local_screen_text =>
      'Piyuo Counter tamamen bu cihazda çalışacaktır.\\nTrafik istatistikleri yalnızca bu cihazda saklanacak ve yüklenmeyecektir.\\nDaha sonra Ayarlar\'dan Piyuo Cloud veya kendi sunucunuza bağlanabilirsiniz.';

  @override
  String get maximum_occupancy => 'Maksimum Kişi Sayısı';

  @override
  String get maximum_occupancy_help =>
      'Geçerli sayım penceresi sırasında aynı anda bu alanda bulunan en yüksek kişi veya araç sayısını gösterir.\\n\\nEn yoğun kalabalık veya trafik seviyelerini belirlemek için kullanışlıdır.';

  @override
  String get maximum_stay => 'Maksimum Kalış Süresi';

  @override
  String get maximum_stay_help =>
      'Geçerli sayım penceresi sırasında bir kişi veya aracın bu alanda kaldığı en uzun süreyi gösterir.\\n\\nOlağan dışı uzun ziyaretleri veya duraklamaları belirlemek için kullanışlıdır.';

  @override
  String get metric_events => 'Olaylar';

  @override
  String get metric_live => 'Canlı';

  @override
  String get metric_show_less => 'Daha az göster';

  @override
  String get metric_show_more => 'Daha fazla göster';

  @override
  String get metric_statistics => 'İstatistikler';

  @override
  String get metrics_counting_all => 'Tümü';

  @override
  String get metrics_counting_done => 'Tamamlandı';

  @override
  String get metrics_counting_in_progress => 'Sürüyor';

  @override
  String get metrics_counting_missing => 'Eksik';

  @override
  String get metrics_counting_window =>
      'Her 5 dakikalık dönem için istatistikler';

  @override
  String get onboarding_back_action => 'Geri';

  @override
  String get onboarding_cta_no_server => 'Veri yüklemek istemiyor musunuz?';

  @override
  String get onboarding_cta_title => 'Verileriniz nereye gönderilsin?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter, cihazının kamerasını ve yerleşik yapay zekayı kullanarak insanları ve araçları anında tanır.\\nAlgılama ve izleme teknolojisiyle yaya ve araç trafiğini otomatik olarak sayar — hepsi doğrudan cihazında işlenir.';

  @override
  String get onboarding_intro_text2 =>
      'Tüm yapay zeka işlemleri cihazında yerel olarak gerçekleşir. Hiçbir video, görüntü, yüz veya kimlik yüklenmez.\\nYalnızca 5 dakikalık anonim özetler paylaşılır; bunlara sayım, doluluk, giriş, çıkış ve kalış süresi istatistikleri dahildir.';

  @override
  String get onboarding_intro_text3 =>
      'Uygulamayı başlatıp çalışır durumda bırakman yeterli. Piyuo Counter trafik verilerini otomatik olarak sürekli toplar ve kaydeder.\\nVeri özetleri her 5 dakikada bir kaydedilir ve her saat Piyuo Cloud\'a veya kendi sunucuna yüklenir.';

  @override
  String get onboarding_intro_title1 => 'Yapay Zekâ ile Trafik Sayımı';

  @override
  String get onboarding_intro_title2 => 'Gizlilik Önceliklidir';

  @override
  String get onboarding_intro_title3 => '7/24 Otomatik Çalışır';

  @override
  String get onboarding_next_action => 'İleri';

  @override
  String get onboarding_skip_action => 'Girişi Atla';

  @override
  String get onboarding_start_action => 'Başlat';

  @override
  String get passed_by => 'Geçenler';

  @override
  String get passed_by_help =>
      'Geçerli sayım penceresi sırasında bu alandan geçen kişi veya araçları sayar.\\n\\nHer kişi veya araç, alandan her geçişinde yalnızca bir kez sayılır.';

  @override
  String get payloads_screen_area => 'Alan';

  @override
  String get payloads_screen_confidence => 'Güven';

  @override
  String get payloads_screen_coverage => 'Kapsam';

  @override
  String get payloads_screen_delivered => 'Teslim edildi';

  @override
  String get payloads_screen_failed_load => 'Son payload\'lar yüklenemedi';

  @override
  String get payloads_screen_frame_processed => 'İşlenen kareler';

  @override
  String get payloads_screen_hour_not_exists => 'Bu saat artık mevcut değil.';

  @override
  String get payloads_screen_missing_time => 'Eksik süre';

  @override
  String get payloads_screen_no_payloads => 'Daha payload yok.';

  @override
  String get payloads_screen_partial => 'Pencere erken sona erdi (kısmi)';

  @override
  String get payloads_screen_partially => 'Kısmen teslim edildi';

  @override
  String get payloads_screen_payload_not_exists =>
      'Bu payload artık mevcut değil.';

  @override
  String get payloads_screen_pending => 'Teslimat bekliyor';

  @override
  String get payloads_screen_process_fps => 'İşleme FPS';

  @override
  String get payloads_screen_resend => 'Yeniden gönder';

  @override
  String get payloads_screen_select_first =>
      'Önce en az bir tarih veya saat seçin.';

  @override
  String get payloads_screen_subtitle =>
      'Tekrar göndermek için tarih veya saat seçin';

  @override
  String get payloads_screen_title => 'Son payload\'lar';

  @override
  String get personal_custom_screen_build_server =>
      'Kendi sunucunuzu kurmak için yardıma mı ihtiyacınız var?\\nAPI belgelerimizi ve sunucu örneklerini inceleyin.';

  @override
  String get personal_custom_screen_help_action => 'API Belgelerini Aç';

  @override
  String get personal_custom_screen_reset_action => 'Baştan Başla';

  @override
  String get personal_custom_success_screen_help =>
      'Saymaya başlamak için aşağıdaki Start düğmesine dokunun.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Trafik istatistikleri her saat otomatik olarak yüklenir.\\nİsterseniz bunları Yükleme Günlükleri ekranından manuel olarak da yükleyebilirsiniz.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Sunucunuzun henüz çevrimiçi olması gerekmez.\\nSaymaya hemen başlayın. Sunucunuzu daha sonra tamamlayıp test edebilirsiniz. Trafik istatistikleri başarıyla yüklenene kadar bu cihazda tutulacaktır.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Trafik istatistikleri şuraya gönderilecek';

  @override
  String get personal_custom_success_screen_title => 'Sunucunuz Hazır';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Piyuo Cloud URL\'niz';

  @override
  String get piyuo_server_screen_copy_action => 'URL\'yi kopyala';

  @override
  String get piyuo_server_screen_copy_success => 'URL kopyalandı';

  @override
  String get piyuo_server_screen_saving_action => 'Kaydediliyor...';

  @override
  String get piyuo_server_screen_start =>
      'Sayımı başlatmak için aşağıdaki \"Start\" düğmesine basın.';

  @override
  String get piyuo_server_screen_url_help =>
      'Kişisel Piyuo Cloud kontrol paneliniz bu URL\'de hazır.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Bu URL\'yi kaydedin, böylece trafik kontrol panelinize başka bir cihazdan erişebilirsiniz.';

  @override
  String get piyuo_server_screen_use_action => 'Piyuo Cloud\'u Kullan';

  @override
  String get privacy => 'Gizlilik Politikası';

  @override
  String get product_copyright => 'Telif Hakkı © 2026';

  @override
  String get product_desc => 'Yapay zekâ destekli insan ve araç sayımı.';

  @override
  String get settings_screen_custom_subtitle =>
      'Gönderileri doğrudan kendi arka ucunuza veya veritabanınıza gönderin.';

  @override
  String get settings_screen_custom_title => 'Özel Sunucu Kullan';

  @override
  String get settings_screen_data_server_label => 'Veri Sunucusu';

  @override
  String get settings_screen_detection_target => 'Algılama Hedefi';

  @override
  String get settings_screen_language_title => 'Dil';

  @override
  String get settings_screen_local_subtitle =>
      'Trafik verilerini yalnızca bu cihazda saklayın. Hiçbir şey yüklenmez.';

  @override
  String get settings_screen_local_title => 'Yalnızca Yerel Cihaz';

  @override
  String get settings_screen_misc_label => 'Diğer';

  @override
  String get settings_screen_object_detection => 'Nesne Algılama';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Trafik verilerinizi Piyuo Cloud\'da saklayın; gösterge panoları ve iş analizlerinden yararlanın.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Bu işlem tüm verileri silecek ve yeniden başlayacaktır. Bu işlem geri alınamaz.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Tüm veriler sıfırlansın mı?';

  @override
  String get settings_screen_subscription_body =>
      'Aboneliğinizi ve fatura bilgilerinizi yönetin';

  @override
  String get settings_screen_subscription_title => 'Abonelik';

  @override
  String get start_screen_about => 'Hakkında';

  @override
  String get start_screen_server_none => 'Veriler yalnızca bu cihazda saklanır';

  @override
  String get start_screen_server_personal =>
      'Veriler her saat şu adrese yüklenir';

  @override
  String get start_screen_settings => 'Ayarlar';

  @override
  String get start_screen_upload_logs => 'Bağlantı günlüklerini yükle';

  @override
  String get start_screen_video_sources => 'Video kaynakları';

  @override
  String get stayed => 'Kaldı';

  @override
  String get stayed_help =>
      'Bu alanda en az ayarlanan Bekleme Süresi kadar kalan kişi veya araçları sayar.\\n\\nVarsayılan Bekleme Süresi 15 saniyedir ve Ayarlar\'dan değiştirilebilir.';

  @override
  String get target_pedestrian => 'Yaya';

  @override
  String get target_pedestrian_help =>
      'Yaya algılama modeliyle insanları sayın';

  @override
  String get target_screen_subtitle => 'Kullanılacak algılama modelini seçin';

  @override
  String get target_vehicle => 'Araç';

  @override
  String get target_vehicle_help =>
      'Araç modeliyle otomobil ve diğer araçları sayın';

  @override
  String get telemetry_error_connection_refused =>
      'Sunucuya ulaşılamadı. Şu anda çevrimdışı olabilir.';

  @override
  String get telemetry_error_connection_reset =>
      'Bağlantı sıfırlandı. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get telemetry_error_connection_timeout =>
      'Bağlantının yanıt vermesi çok uzun sürdü. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get telemetry_error_database_error =>
      'Veritabanına yazma işlemi başarısız oldu.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Sunucu adresi bulunamadı. Lütfen internet bağlantınızı veya sunucu URL\'sini kontrol edin.';

  @override
  String get telemetry_error_http_error_status =>
      'Sunucu isteği reddetti. Lütfen daha sonra tekrar deneyin.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Sunucuyla iletişim kurulurken beklenmeyen bir hata oluştu.';

  @override
  String get telemetry_error_invalid_url =>
      'Sunucu adresi geçersiz. Lütfen ayarlarınızı kontrol edin.';

  @override
  String get telemetry_error_network_error =>
      'Bir ağ hatası oluştu. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get telemetry_error_socket_error =>
      'Bir ağ bağlantısı sorunu oluştu. Lütfen internet bağlantınızı kontrol edin.';

  @override
  String get telemetry_error_transport_exception =>
      'Veri gönderilirken bir sorun oluştu. Lütfen tekrar deneyin.';

  @override
  String get telemetry_error_unknown_error => 'Beklenmeyen bir hata oluştu.';

  @override
  String get terms => 'Hizmet Koşulları';

  @override
  String get upload_screen_attempt_time => 'Deneme zamanı:';

  @override
  String get upload_screen_error => 'Hata:';

  @override
  String get upload_screen_failed => 'Başarısız';

  @override
  String get upload_screen_load_error => 'Yükleme kayıtları yüklenemedi.';

  @override
  String get upload_screen_log_not_exists =>
      'Yükleme kaydı artık kullanılamıyor.';

  @override
  String get upload_screen_next => 'Sonraki yükleme ...';

  @override
  String get upload_screen_next_upload_prefix => 'Sonraki yükleme ';

  @override
  String get upload_screen_no_data_server =>
      'Lütfen önce Veri Sunucusunu ayarlayın.';

  @override
  String get upload_screen_no_logs => 'Henüz yükleme kaydı yok.';

  @override
  String get upload_screen_payload_count => 'Payload Sayısı';

  @override
  String get upload_screen_payload_count_label => 'Payload sayısı:';

  @override
  String get upload_screen_payload_size => 'Payload boyutu:';

  @override
  String get upload_screen_result => 'Sonuç:';

  @override
  String get upload_screen_retry => 'Yeniden deneme sayısı:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Başarılı';

  @override
  String get upload_screen_today => 'Bugün';

  @override
  String get upload_screen_upload_now => 'Şimdi yükle';

  @override
  String get upload_screen_upload_success => 'Yükleme başarılı.';

  @override
  String get upload_screen_uploading => 'Yükleniyor...';

  @override
  String get upload_screen_yesterday => 'Dün';

  @override
  String get url_screen_invalid_rtsp_error =>
      'RTSP URL\'leri bir ana bilgisayar adı içermelidir.';

  @override
  String get url_screen_invalid_url_error =>
      'Desteklenen bir şemaya sahip geçerli bir URL girin.';

  @override
  String get url_screen_subtitle => 'Lütfen canlı yayın URL\'sini girin';

  @override
  String get url_screen_title => 'Canlı yayın URL\'si';

  @override
  String get url_screen_unsupported_scheme_error => 'केवल HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Lütfen bir canlı yayın URL\'si girin.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream veya rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Arka kamera';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_file => 'Dosya';

  @override
  String get video_sources_front_camera => 'Ön kamera';

  @override
  String get video_sources_live_stream => 'Canlı yayın URL\'si';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Kamerayı kullanmak için kamera izni vermeniz gerekiyor';

  @override
  String get video_sources_screen_camera_not_found_title => 'Kamera bulunamadı';

  @override
  String get video_sources_screen_import_error =>
      'Video dosyası içe aktarılamadı.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Lütfen ayarlara gidin ve bu uygulama için fotoğraflara erişim izni verin.';

  @override
  String get video_sources_screen_select_camera =>
      'Bu kamerayı seçmek için dokunun';

  @override
  String get video_sources_screen_select_file => 'Dosya seçmek için dokunun';

  @override
  String get video_sources_screen_select_live =>
      'Canlı yayın URL\'sini ayarlamak için dokunun';

  @override
  String get video_sources_webcam => 'Web Kamerası';
}
