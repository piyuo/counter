// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class LocalizationFi extends Localization {
  LocalizationFi([String locale = 'fi']) : super(locale);

  @override
  String get product_name => 'Laskuri';

  @override
  String get product_desc => 'Käyttää konenäköä ja tekoälyä laskemaan ihmisiä, ajoneuvoja, lemmikkejä ja muuta.';

  @override
  String get product_copyright => 'Tekijänoikeus © 2025';

  @override
  String get video_sources_webcam => 'Webkamera';

  @override
  String get video_sources_live_stream => 'Suoratoistolinkin URL';

  @override
  String get video_sources_file => 'Tiedosto';

  @override
  String get video_sources_camera => 'Kamera';

  @override
  String get video_sources_camera_not_found_title => 'Kameraa ei löydy';

  @override
  String get video_sources_camera_not_found_message => 'Kameran käyttö vaatii kameraoikeuksien hyväksymisen';

  @override
  String get video_sources_webcam_not_found_title => 'Webkameraa ei löydy';

  @override
  String get video_sources_webcam_not_found_message => 'Tarkista, että webkamera on kytketty';

  @override
  String get wizard_screen_desc => 'Luo uusi projekti aloittaaksesi laskemisen.';

  @override
  String get wizard_screen_new_project_from => 'Uusi projekti lähteestä';

  @override
  String get wizard_screen_language => 'Kieli';

  @override
  String get wizard_screen_about => 'Tietoja';

  @override
  String get wizard_screen_open_projects_tip => 'Kaikki projektit tallennetaan automaattisesti paikallisesti';

  @override
  String get wizard_screen_open_projects => 'Avaa olemassa oleva projekti';

  @override
  String get wizard_screen_email_us => 'Lähetä sähköpostia';

  @override
  String get language_screen_language => 'Kieli';

  @override
  String get project_view_no_videos => 'Ei videolähdettä saatavilla.';

  @override
  String get about_screen_title => 'Tietoja';

  @override
  String get about_screen_platform => 'Alusta';

  @override
  String get about_screen_app_version => 'Sovelluksen versio';

  @override
  String get about_screen_models => 'Kohteiden tunnistusmallit';

  @override
  String get about_screen_benchmark => 'Suorituskykytesti';

  @override
  String get about_screen_opencv_build_info => 'OpenCV-koontitiedot';

  @override
  String get benchmark_screen_title => 'Mallien suorituskykytestit';

  @override
  String get benchmark_screen_recommended => 'Suositeltu malli';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Aloita suorituskykytesti';

  @override
  String get benchmark_screen_start_failed => 'Suorituskykytestin käynnistys epäonnistui, virhekoodi on';

  @override
  String get benchmark_screen_models => 'Kohteiden tunnistusmallit';

  @override
  String get project_screen_title => 'Projekti';

  @override
  String get project_screen_exit_confirm_title => 'Vahvista projektista poistuminen';

  @override
  String get project_screen_exit_confirm_content => 'Projektista poistuminen lopettaa laskemisen. Haluatko varmasti jatkaa?';

  @override
  String get project_screen_exit_button => 'Poistu';

  @override
  String get project_screen_add_video_button => 'Lisää videolähde';

  @override
  String get project_screen_from_desc => 'Pidämme 24 tunnin jatkuvan tallenteen, joten voit tarkastella mitä tahansa ajanjaksoa.';

  @override
  String get project_screen_report_settings => 'Asetukset';

  @override
  String get filter_screen_title => 'Suodatin';

  @override
  String get filter_screen_desc => 'Valitse suodatusalue alla olevasta luettelosta';

  @override
  String get filter_screen_error_title => 'Suodatin';

  @override
  String get filter_screen_error_content => 'Loppuajan on oltava suurempi kuin aloitusaika';

  @override
  String get filter_screen_error_custom => 'Mukautettu';

  @override
  String get filter_screen_error_start => 'Aloitus';

  @override
  String get filter_screen_error_end => 'Lopetus';

  @override
  String get settings_screen_title => 'Asetukset';

  @override
  String get settings_screen_desc => 'Aseta projektin nimi, tunnistusparametrit, laskurien nollaus.';

  @override
  String get settings_screen_project_id => 'Projektin tunnus';

  @override
  String get settings_screen_project_name => 'Projektin nimi';

  @override
  String get settings_screen_project_name_place_holder => 'Mannerheimintiellä 123 tai Kauppatorin puisto';

  @override
  String get settings_screen_project_error => 'Projektin nimi ei voi olla tyhjä';

  @override
  String get settings_screen_random_count_button => 'Lisää satunnaisia laskentoja';

  @override
  String get settings_screen_reset_count_header => 'Nollaa kaikki laskennat tässä projektissa';

  @override
  String get settings_screen_reset_count_button => 'Nollaa laskennat';

  @override
  String get settings_screen_reset_count_content => 'Haluatko varmasti nollata kaikki laskennat?';

  @override
  String get settings_screen_delete_header => 'Poista tämä projekti';

  @override
  String get settings_screen_delete_content => 'Haluatko varmasti poistaa tämän projektin?';

  @override
  String get settings_screen_delete_button => 'Poista';

  @override
  String get settings_screen_center_point_title => 'Keskipiste kohteessa';

  @override
  String get settings_screen_center_point_desc => 'Keskipiste auttaa määrittämään, onko kohde osuma-alueella.';

  @override
  String get settings_screen_center_point_button => 'Näytä keskipiste kohteessa';

  @override
  String get settings_screen_lost_target_title => 'Kadotettu kohde';

  @override
  String get settings_screen_lost_target_desc => 'Kun kohteiden seuranta kadottaa kohteen, tämä asetus tekee sen näkyväksi. Oletusarvoisesti kadotettuja kohteita ei näytetä.';

  @override
  String get settings_screen_lost_target_button => 'Näytä kadotettu kohde';

  @override
  String get detection_screen_title => 'Tunnistusasetukset';

  @override
  String get detection_screen_models => 'Mallit';

  @override
  String get detection_screen_confidence => 'Luotettavuus';

  @override
  String get detection_screen_confidence_desc => 'Yli #0 luotettavuus katsotaan kelvolliseksi tunnistukseksi';

  @override
  String get detection_screen_low => 'Matala';

  @override
  String get detection_screen_high => 'Korkea';

  @override
  String get detection_screen_nms => 'Ei-maksimaalinen suppressio';

  @override
  String get detection_screen_nms_desc => '#0 Matalampi NMS-kynnysarvo (esim. 30%) poistaa päällekkäiset rajauslaatikot aggressiivisemmin, kun taas korkeampi NMS-kynnysarvo (esim. 0,6) sallii enemmän päällekkäisyyttä';

  @override
  String get detection_screen_match => 'Vastaavuus';

  @override
  String get detection_screen_match_desc => 'Yli #0 vastaavuus katsotaan samaksi kohteeksi.';

  @override
  String get detection_screen_lost => 'Kadotettu';

  @override
  String get detection_screen_lost_desc => 'Seurattu kohde poistetaan, jos se on kadoksissa #0';

  @override
  String get detection_screen_consider_valid => 'Pidä kelvollisena';

  @override
  String get detection_screen_consider_valid_desc => 'Seurattu kohde katsotaan kelvolliseksi #0 jälkeen';

  @override
  String get detection_screen_reset => 'Nollaa';

  @override
  String get detection_screen_reset_content => 'Haluatko varmasti nollata tunnistusasetukset?';

  @override
  String get url_screen_title => 'Suoratoistolinkin URL';

  @override
  String get url_screen_desc => 'Syötä suoratoistolinkin URL';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream tai rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Lisää videolähde';

  @override
  String get add_video_screen_from => 'Lisää videolähde kohteesta';

  @override
  String get webcam_screen_add_title => 'Lisää webkamera';

  @override
  String get webcam_screen_edit_title => 'Valitse webkamera';

  @override
  String get webcam_manager_webcam => 'Webkamera';

  @override
  String get camera_screen_front_camera => 'Etukamera';

  @override
  String get camera_screen_back_camera => 'Takakamera';

  @override
  String get camera_screen_add_title => 'Lisää kamera';

  @override
  String get camera_screen_edit_title => 'Valitse kamera';

  @override
  String get camera_screen_zoom_level => 'Zoomaustaso';

  @override
  String get video_screen_name_empty => 'Videolähteen nimi ei voi olla tyhjä.';

  @override
  String get video_screen_desc => 'Hallitse videolähteitä, lisää tai muokkaa tunnistusalueita.';

  @override
  String get video_screen_video_name => 'Videolähteen nimi';

  @override
  String get video_screen_edit_placeholder => 'Etuoven kamera tai Parkkipaikan kamera';

  @override
  String get video_screen_change_file => 'Vaihda tiedosto';

  @override
  String get video_screen_add_zone => 'Lisää tunnistusalue';

  @override
  String get video_screen_zones => 'Tunnistusalueet';

  @override
  String get video_screen_zones_desc => 'Käytä vedä ja pudota -toimintoa alueiden säätämiseen';

  @override
  String get video_screen_tools => 'Työkalut';

  @override
  String get video_screen_move_bottom => 'Siirrä nykyinen alue alas';

  @override
  String get video_screen_add_point => 'Lisää piste nykyiselle alueelle';

  @override
  String get video_screen_remove_point => 'Poista piste nykyiseltä alueelta';

  @override
  String get video_screen_playback_speed => 'Toistonopeus';

  @override
  String get video_screen_playback_current => 'nykyinen: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Poista tämä videolähde';

  @override
  String get video_screen_delete_content => 'Haluatko varmasti poistaa tämän videolähteen?';

  @override
  String get video_screen_delete_button => 'Poista';

  @override
  String get video_screen_sources => 'Määritä kuvalähde, tunnistuskohteet ja malliparametrit.';

  @override
  String get video_screen_targets => 'Tunnistuskohteet';

  @override
  String get video_screen_detection => 'Malliparametrit';

  @override
  String get color_screen_title => 'Valitse väri';

  @override
  String get zone_screen_desc => 'Tunnistusalueella voit määrittää tunnistettavien kohteiden tyypit ja valita näytettävät laskurit, kuten Havaitut, Ilmestyneet ja Saapuneet.';

  @override
  String get zone_screen_name_placeholder => 'Alueen nimi, kuten Jalkakäytävä tai Parkkipaikka';

  @override
  String get zone_screen_zone_color => 'Alueen väri';

  @override
  String get zone_screen_color => 'Väri';

  @override
  String get zone_screen_delete_header => 'Poista tämä alue';

  @override
  String get zone_screen_delete_content => 'Haluatko varmasti poistaa tämän alueen?';

  @override
  String get zone_screen_delete_button => 'Poista';

  @override
  String get zone_screen_can_not_delete => 'Aluetta ei voi poistaa';

  @override
  String get zone_screen_one_zone_required => 'Vähintään yksi alue vaaditaan.';

  @override
  String get zone_screen_zone_name_required => 'Alueen nimi ei voi olla tyhjä';

  @override
  String get counter_screen_show_on => 'Näytä ruudulla';

  @override
  String get counter_screen_enabled => 'Käytössä';

  @override
  String get counter_screen_reentry_threshold => 'Uudelleensaapumisen kynnysarvo';

  @override
  String get counter_screen_reentry_desc => 'Kohteiden on saavuttava #0 kertaa, joiden välillä on #1 sekunnin jäähdytysaika jokaisen poistumisen ja uudelleensaapumisen välillä, jotta uudelleensaapuminen käynnistyy';

  @override
  String get counter_screen_reentry_title => 'Uudelleensaapumislaskuri';

  @override
  String get counter_screen_cooldown_threshold => 'Jäähdytysajan kynnysarvo';

  @override
  String get counter_screen_cooldown_desc => 'Uudelleensaapuminen vaatii #0 sekunnin jäähdytysajan tunnistusalueelta poistumisen jälkeen';

  @override
  String get counter_screen_cooldown_time => 'Jäähdytysaika';

  @override
  String get counter_screen_cooldown_in_seconds => 'sekunteina';

  @override
  String get counter_screen_stagnant_threshold => 'Pysähtyneisyyden kynnysarvo';

  @override
  String get counter_screen_stagnant_desc => 'Kohteet, jotka pysyvät paikallaan yli #0 sekuntia, katsotaan pysähtyneiksi';

  @override
  String get counter_screen_stagnant_consider => 'Katso pysähtyneeksi';

  @override
  String get counter_screen_stagnant_in_seconds => 'sekunteina';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Kuvauksen etuliite';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Kuvauksen jälkiliite';

  @override
  String get counter_screen_name_error => 'Laskurin nimi ei voi olla tyhjä';

  @override
  String get counter_screen_enabled_error => 'Virhe';

  @override
  String get counter_screen_enabled_error_content => 'Sinun täytyy ensin ottaa käyttöön muu laskuri, sitten voit poistaa tämän laskurin käytöstä';

  @override
  String get objects_screen_title => 'Kohteet';

  @override
  String get objects_screen_desc => 'Valitse tunnistuskohteet kuten henkilö, auto, bussi, jne.';

  @override
  String get open_project_screen_title => 'Avaa projekti';

  @override
  String get open_project_screen_desc => 'Avaa aiemmin luotuja projekteja, säilyttäen vain 20 viimeisintä.';

  @override
  String get open_project_screen_no_project => 'Projekteja ei löytynyt.';

  @override
  String get default_project_name => 'Projekti';

  @override
  String get default_video_name => 'Videolähde';

  @override
  String get default_zone_name => 'Tunnistusalue';

  @override
  String get error_oops => 'Hups, jokin meni pieleen';

  @override
  String get error_content => 'Tapahtui odottamaton virhe. Haluatko lähettää sähköpostiraportin?';

  @override
  String get error_report => 'Lähetä sähköpostia';

  @override
  String get submit => 'Lähetä';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Peruuta';

  @override
  String get yes => 'Kyllä';

  @override
  String get no => 'Ei';

  @override
  String get close => 'Sulje';

  @override
  String get back => 'Takaisin';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Alue';

  @override
  String get zone_screen_zone_show_summary => 'Näytä yhteenveto ruudulla';
}
