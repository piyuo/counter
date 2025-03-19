// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationRo extends AppLocalization {
  AppLocalizationRo([String locale = 'ro']) : super(locale);

  @override
  String get product_name => 'Vision Counter';

  @override
  String get product_desc => 'Folosește viziunea computerizată și inteligența artificială pentru a număra persoane, vehicule, animale de companie și multe altele.';

  @override
  String get product_copyright => 'Drepturi de autor © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL flux live';

  @override
  String get video_sources_file => 'Fișier';

  @override
  String get video_sources_camera => 'Cameră';

  @override
  String get video_sources_camera_not_found_title => 'Camera nu a fost găsită';

  @override
  String get video_sources_camera_not_found_message => 'Trebuie să acordați permisiunea pentru cameră pentru a o putea utiliza';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam-ul nu a fost găsit';

  @override
  String get video_sources_webcam_not_found_message => 'Vă rugăm să verificați dacă este conectat un webcam';

  @override
  String get wizard_screen_desc => 'Creați un proiect nou mai jos pentru a începe numărarea.';

  @override
  String get wizard_screen_new_project_from => 'Proiect nou din';

  @override
  String get wizard_screen_language => 'Limbă';

  @override
  String get wizard_screen_about => 'Despre';

  @override
  String get wizard_screen_open_projects_tip => 'Toate proiectele vor fi salvate automat local';

  @override
  String get wizard_screen_open_projects => 'Deschide proiect existent';

  @override
  String get wizard_screen_email_us => 'Trimite-ne un email';

  @override
  String get language_screen_language => 'Limbă';

  @override
  String get project_view_no_videos => 'Nu există sursă video disponibilă.';

  @override
  String get about_screen_title => 'Despre';

  @override
  String get about_screen_platform => 'Platformă';

  @override
  String get about_screen_app_version => 'Versiune aplicație';

  @override
  String get about_screen_models => 'Modele de detectare a obiectelor';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informații despre build-ul OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmark-uri modele';

  @override
  String get benchmark_screen_recommended => 'Model recomandat';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Începe benchmark';

  @override
  String get benchmark_screen_start_failed => 'Nu s-a putut porni benchmark-ul, codul de eroare este';

  @override
  String get benchmark_screen_models => 'Modele de detectare a obiectelor';

  @override
  String get project_screen_title => 'Proiect';

  @override
  String get project_screen_exit_confirm_title => 'Confirmați ieșirea din proiect';

  @override
  String get project_screen_exit_confirm_content => 'Părăsirea proiectului va opri numărarea. Sunteți sigur că doriți să continuați?';

  @override
  String get project_screen_exit_button => 'Ieșire';

  @override
  String get project_screen_add_video_button => 'Adaugă sursă video';

  @override
  String get project_screen_from_desc => 'Păstrăm o înregistrare continuă de 24 de ore, astfel încât puteți vizualiza orice segment de timp aveți nevoie.';

  @override
  String get project_screen_report_settings => 'Setări';

  @override
  String get filter_screen_title => 'Filtru';

  @override
  String get filter_screen_desc => 'Selectați un interval de filtrare din lista de mai jos';

  @override
  String get filter_screen_error_title => 'Filtru';

  @override
  String get filter_screen_error_content => 'Ora de sfârșit trebuie să fie mai mare decât ora de început';

  @override
  String get filter_screen_error_custom => 'Personalizat';

  @override
  String get filter_screen_error_start => 'Început';

  @override
  String get filter_screen_error_end => 'Sfârșit';

  @override
  String get settings_screen_title => 'Setări';

  @override
  String get settings_screen_desc => 'Setați numele proiectului, parametrii de detectare, resetarea numărării.';

  @override
  String get settings_screen_project_id => 'ID Proiect';

  @override
  String get settings_screen_project_name => 'Nume Proiect';

  @override
  String get settings_screen_project_name_place_holder => 'Strada Principală 123 sau Bulevardul Unirii';

  @override
  String get settings_screen_project_error => 'Numele proiectului nu poate fi gol';

  @override
  String get settings_screen_random_count_button => 'Adaugă numărări aleatorii';

  @override
  String get settings_screen_reset_count_header => 'Resetează toate numărările din acest proiect';

  @override
  String get settings_screen_reset_count_button => 'Resetează numărările';

  @override
  String get settings_screen_reset_count_content => 'Sunteți sigur că doriți să resetați toate numărările?';

  @override
  String get settings_screen_delete_header => 'Șterge acest proiect';

  @override
  String get settings_screen_delete_content => 'Sunteți sigur că doriți să ștergeți acest proiect?';

  @override
  String get settings_screen_delete_button => 'Șterge';

  @override
  String get settings_screen_center_point_title => 'Punct central pe țintă';

  @override
  String get settings_screen_center_point_desc => 'Punctul central ajută la determinarea dacă ținta se află în zona de detecție.';

  @override
  String get settings_screen_center_point_button => 'Arată punctul central pe țintă';

  @override
  String get settings_screen_lost_target_title => 'Țintă pierdută';

  @override
  String get settings_screen_lost_target_desc => 'Când urmărirea obiectelor pierde o țintă, această opțiune o face vizibilă. Implicit, țintele pierdute nu sunt afișate.';

  @override
  String get settings_screen_lost_target_button => 'Arată ținta pierdută';

  @override
  String get detection_screen_title => 'Setări de detectare';

  @override
  String get detection_screen_models => 'Modele';

  @override
  String get detection_screen_confidence => 'Încredere';

  @override
  String get detection_screen_confidence_desc => 'încredere peste #0 este considerată o detectare validă';

  @override
  String get detection_screen_low => 'Scăzut';

  @override
  String get detection_screen_high => 'Ridicat';

  @override
  String get detection_screen_nms => 'Supresie non-maximă';

  @override
  String get detection_screen_nms_desc => '#0 Un prag NMS mai scăzut (de ex., 30%) va elimina mai agresiv casetele de contur suprapuse, în timp ce un prag NMS mai ridicat (de ex., 0.6) va permite mai multă suprapunere';

  @override
  String get detection_screen_match => 'Potrivire';

  @override
  String get detection_screen_match_desc => 'Potrivire peste #0 este considerată același obiect.';

  @override
  String get detection_screen_lost => 'Pierdut';

  @override
  String get detection_screen_lost_desc => 'Obiectul urmărit va fi eliminat dacă este pierdut pentru #0';

  @override
  String get detection_screen_consider_valid => 'Consideră valid după';

  @override
  String get detection_screen_consider_valid_desc => 'Obiectul urmărit va fi considerat valid după #0';

  @override
  String get detection_screen_reset => 'Resetare';

  @override
  String get detection_screen_reset_content => 'Sunteți sigur că doriți să resetați setările de detectare?';

  @override
  String get url_screen_title => 'URL flux live';

  @override
  String get url_screen_desc => 'Vă rugăm să introduceți URL-ul fluxului live';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemplu.com/flux sau rtsp://exemplu.com/flux';

  @override
  String get add_video_screen_title => 'Adaugă sursă video';

  @override
  String get add_video_screen_from => 'Adaugă sursă video din';

  @override
  String get webcam_screen_add_title => 'Adaugă Webcam';

  @override
  String get webcam_screen_edit_title => 'Alege Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Camera frontală';

  @override
  String get camera_screen_back_camera => 'Camera din spate';

  @override
  String get camera_screen_add_title => 'Adaugă Cameră';

  @override
  String get camera_screen_edit_title => 'Alege Cameră';

  @override
  String get camera_screen_zoom_level => 'Nivel zoom';

  @override
  String get video_screen_name_empty => 'Numele sursei video nu poate fi gol.';

  @override
  String get video_screen_desc => 'Gestionează sursele video, adaugă sau modifică zonele de detectare.';

  @override
  String get video_screen_video_name => 'Nume sursă video';

  @override
  String get video_screen_edit_placeholder => 'Camera de la ușa din față sau Camera din parcare';

  @override
  String get video_screen_change_file => 'Schimbă fișier';

  @override
  String get video_screen_add_zone => 'Adaugă zonă de detectare';

  @override
  String get video_screen_zones => 'Zone de detectare';

  @override
  String get video_screen_zones_desc => 'Folosiți drag and drop pentru a ajusta zonele';

  @override
  String get video_screen_tools => 'Instrumente';

  @override
  String get video_screen_move_bottom => 'Mută zona curentă în partea de jos';

  @override
  String get video_screen_add_point => 'Adaugă punct la zona curentă';

  @override
  String get video_screen_remove_point => 'Elimină punct din zona curentă';

  @override
  String get video_screen_playback_speed => 'Viteză de redare';

  @override
  String get video_screen_playback_current => 'curent: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Șterge această sursă video';

  @override
  String get video_screen_delete_content => 'Sunteți sigur că doriți să ștergeți această sursă video?';

  @override
  String get video_screen_delete_button => 'Șterge';

  @override
  String get video_screen_sources => 'Configurați sursa de imagine, țintele de detectare și parametrii modelului.';

  @override
  String get video_screen_targets => 'Ținte de detectare';

  @override
  String get video_screen_detection => 'Parametri model';

  @override
  String get color_screen_title => 'Alege o culoare';

  @override
  String get zone_screen_desc => 'Zona de detectare poate seta tipurile de obiecte de detectat și poate alege ce contoare să afișeze, cum ar fi Detectate, Generate și Intrate.';

  @override
  String get zone_screen_name_placeholder => 'Numele zonei, cum ar fi Trotuar sau Parcare';

  @override
  String get zone_screen_zone_color => 'Culoarea zonei';

  @override
  String get zone_screen_color => 'Culoare';

  @override
  String get zone_screen_delete_header => 'Șterge această zonă';

  @override
  String get zone_screen_delete_content => 'Sunteți sigur că doriți să ștergeți această zonă?';

  @override
  String get zone_screen_delete_button => 'Șterge';

  @override
  String get zone_screen_can_not_delete => 'Nu se poate șterge zona';

  @override
  String get zone_screen_one_zone_required => 'Este necesară cel puțin o zonă.';

  @override
  String get zone_screen_zone_name_required => 'Numele zonei nu poate fi gol';

  @override
  String get counter_screen_show_on => 'Arată pe ecran';

  @override
  String get counter_screen_enabled => 'Activat';

  @override
  String get counter_screen_reentry_threshold => 'Prag de reintrare';

  @override
  String get counter_screen_reentry_desc => 'Obiectele trebuie să intre de #0 ori, cu o perioadă de răcire de #1 secunde între fiecare ieșire și reintrare, pentru a declanșa reintrarea';

  @override
  String get counter_screen_reentry_title => 'Numărare reintrări';

  @override
  String get counter_screen_cooldown_threshold => 'Prag perioadă de răcire';

  @override
  String get counter_screen_cooldown_desc => 'Reintrarea necesită o perioadă de răcire de #0 secunde după ieșirea din zona de detectare';

  @override
  String get counter_screen_cooldown_time => 'Timp de răcire';

  @override
  String get counter_screen_cooldown_in_seconds => 'în secunde';

  @override
  String get counter_screen_stagnant_threshold => 'Prag de stagnare';

  @override
  String get counter_screen_stagnant_desc => 'Obiectele care rămân staționare pentru mai mult de #0 secunde vor fi considerate stagnante';

  @override
  String get counter_screen_stagnant_consider => 'Consideră ca stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'în secunde';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefix descriere';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufix descriere';

  @override
  String get counter_screen_name_error => 'Numele contorului nu poate fi gol';

  @override
  String get counter_screen_enabled_error => 'Eroare';

  @override
  String get counter_screen_enabled_error_content => 'Trebuie să activați mai întâi un alt contor, apoi puteți dezactiva acest contor';

  @override
  String get objects_screen_title => 'Obiecte';

  @override
  String get objects_screen_desc => 'Alegeți ținte de detectare precum persoană, mașină, autobuz etc.';

  @override
  String get open_project_screen_title => 'Deschide Proiect';

  @override
  String get open_project_screen_desc => 'Deschideți proiecte create anterior, păstrând doar cele mai recente 20.';

  @override
  String get open_project_screen_no_project => 'Nu s-a găsit niciun proiect.';

  @override
  String get default_project_name => 'Proiect';

  @override
  String get default_video_name => 'Sursă video';

  @override
  String get default_zone_name => 'Zonă de detectare';

  @override
  String get error_oops => 'Ups, ceva nu a funcționat corect';

  @override
  String get error_content => 'A apărut o eroare neașteptată. Doriți să trimiteți un raport prin email?';

  @override
  String get error_report => 'Trimite-ne un email';

  @override
  String get submit => 'Trimite';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anulează';

  @override
  String get yes => 'Da';

  @override
  String get no => 'Nu';

  @override
  String get close => 'Închide';

  @override
  String get back => 'Înapoi';
}
