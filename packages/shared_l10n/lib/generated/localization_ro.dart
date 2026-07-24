// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class LocalizationRo extends Localization {
  LocalizationRo([String locale = 'ro']) : super(locale);

  @override
  String get about_screen_app_version => 'Versiune aplicație';

  @override
  String get about_screen_email_us => 'Trimite-ne un email';

  @override
  String get about_screen_platform => 'Platformă';

  @override
  String get appeared => 'Au apărut';

  @override
  String get appeared_help =>
      'Numără persoanele sau vehiculele a căror primă poziție detectată a fost în această zonă.\\n\\nUtil pentru a înțelege unde începe urmărirea.\\n\\n(În principal pentru utilizatori avansați)';

  @override
  String get average_occupancy => 'Număr mediu de persoane';

  @override
  String get average_occupancy_help =>
      'Afișează numărul mediu de persoane sau vehicule din această zonă în timpul ferestrei curente de numărare.\\n\\nAjută la evaluarea cât de aglomerată a fost zona pe întreaga perioadă de numărare.';

  @override
  String get average_stay => 'Durata medie de staționare';

  @override
  String get average_stay_help =>
      'Afișează timpul mediu petrecut de persoane sau vehicule în această zonă.\\n\\nO durată medie mai mare poate indica faptul că vizitatorii petrec mai mult timp în această zonă.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter folosește camera și AI-ul de pe dispozitiv pentru a număra persoane. Mai întâi, să verificăm dacă dispozitivul dvs. este compatibil.';

  @override
  String get camera_test_screen_instruction =>
      'Îndreptați camera spre persoane. Aplicația va desena cadre în jurul celor detectați.';

  @override
  String get camera_test_screen_next => 'Atingeți Următorul pentru a continua.';

  @override
  String get camera_test_screen_start =>
      'Atingeți Start. Dacă vi se solicită, permiteți accesul la cameră.';

  @override
  String get camera_test_screen_test_failed => 'Test eșuat!';

  @override
  String get camera_test_screen_test_passed => 'Test reușit!';

  @override
  String get camera_test_screen_title => 'Test cameră AI';

  @override
  String get camera_test_screen_wait =>
      'Se așteaptă ca AI-ul să detecteze persoane…';

  @override
  String get cta_screen_custom => 'Utilizați propriul server';

  @override
  String get cta_screen_custom_help =>
      'Trimiteți datele de trafic direct către backendul sau baza dvs. de date.';

  @override
  String get cta_screen_footer =>
      'Continuând, sunteți de acord cu Termenii de utilizare, Politica de confidențialitate și Acordul privind prelucrarea datelor.';

  @override
  String get cta_screen_invitation => 'Utilizați un cod de invitație';

  @override
  String get cta_screen_invitation_help =>
      'Alăturați-vă unei organizații existente folosind o invitație de la administrator.';

  @override
  String get cta_screen_local => 'Doar pe acest dispozitiv';

  @override
  String get cta_screen_local_help =>
      'Stocați datele de trafic doar pe acest dispozitiv. Nimic nu este încărcat.';

  @override
  String get cta_screen_piyuo => 'Utilizați Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Stocați datele de trafic în Piyuo Cloud cu tablouri de bord și informații de afaceri.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter creează statistici anonime de trafic la fiecare 5 minute.\\nAlegeți cum doriți să stocați și să accesați datele.';

  @override
  String get current_occupancy => 'Număr curent';

  @override
  String get current_occupancy_help =>
      'Afișează numărul curent de persoane sau vehicule din această zonă.\\n\\nAcest număr este actualizat în timp real și ajută la verificarea faptului că detectarea AI corespunde cu ceea ce vedeți pe ecran. Nu este inclus în datele de telemetrie încărcate.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Se salvează...';

  @override
  String get custom_server_screen_server_url_label => 'URL server';

  @override
  String get detection_screen_confidence => 'Prag de încredere';

  @override
  String get detection_screen_confidence_dialog =>
      'Controlează cât de sigură trebuie să fie IA înainte de a număra o persoană sau un vehicul.\\nValori mai mici\\n• Detectează mai multe obiecte\\n• Mai bune pentru obiecte îndepărtate sau parțial ascunse\\n• Pot crește detectările false\\nValori mai mari\\n• Numără doar detectările cu încredere ridicată\\n• Reduc detectările false\\n• Pot rata obiecte mici sau dificile\\nFolosește o valoare mai mică dacă aplicația ratează persoane sau vehicule.\\nFolosește o valoare mai mare dacă aplicația numără umbre, reflexii sau alte obiecte false.';

  @override
  String get detection_screen_confidence_help =>
      'Nivelul minim de încredere necesar pentru detectarea unui obiect.';

  @override
  String get detection_screen_confidence_max_label => 'Strict';

  @override
  String get detection_screen_confidence_min_label => 'Permisiv';

  @override
  String get detection_screen_disappear => 'Limită de timp pentru dispariție';

  @override
  String get detection_screen_disappear_dialog =>
      'Determină cât timp așteaptă IA înainte de a marca un obiect ca dispărut după ce nu mai este detectat.\\nValori mai scurte\\n• Marchează obiectele ca dispărute mai repede\\n• Mai bune pentru trafic rapid\\n• Pot marca obiecte ascunse temporar ca dispărute\\nValori mai lungi\\n• Așteaptă mai mult înainte de a marca obiectele ca dispărute\\n• Mai bune când obiectele sunt blocate sau ratate scurt\\n• Întârzie evenimentele de dispariție';

  @override
  String get detection_screen_disappear_help =>
      'Cât timp așteaptă AI înainte de a marca un obiect ca dispărut după ce nu îl mai detectează.';

  @override
  String get detection_screen_disappear_max_label => 'Lent';

  @override
  String get detection_screen_disappear_min_label => 'Rapid';

  @override
  String get detection_screen_memory_dialog =>
      'Controlează cât timp IA reține un obiect după ce dispare.\\nMărește această valoare dacă persoanele sau vehiculele sunt adesea ascunse în spatele altor obiecte.\\nMicșorează această valoare dacă obiectele sunt legate incorect după ce părăsesc scena.';

  @override
  String get detection_screen_min_presence => 'Timp minim de prezență';

  @override
  String get detection_screen_min_presence_help =>
      'Un obiect trebuie să rămână vizibil înainte de a fi numărat. Valorile mai mari ajută la reducerea detecțiilor false de scurtă durată.';

  @override
  String get detection_screen_min_presence_max_label => 'Mai sigur';

  @override
  String get detection_screen_min_presence_min_label => 'Mai rapid';

  @override
  String get detection_screen_minimum_visible =>
      'Obiectele trebuie să rămână vizibile atât timp înainte de a fi numărate.\\nMărește această valoare pentru a ignora detectările false scurte.\\nMicșorează această valoare dacă persoanele sau vehiculele care se mișcă rapid sunt ratate.';

  @override
  String get detection_screen_new_track => 'Prag pentru urmărire nouă';

  @override
  String get detection_screen_new_track_help =>
      'Nivelul minim de încredere necesar pentru a începe urmărirea unui obiect nou. Valorile mici pot crea urmăriri duplicate.';

  @override
  String get detection_screen_new_track_max_label => 'Conservator';

  @override
  String get detection_screen_new_track_min_label => 'Agresiv';

  @override
  String get detection_screen_reset => 'Resetare';

  @override
  String get detection_screen_reset_content =>
      'Sunteți sigur că doriți să resetați setările de detectare?';

  @override
  String get detection_screen_show_track_id => 'Afișare ID-ul urmăririi';

  @override
  String get detection_screen_show_track_id_help =>
      'Activați această opțiune pentru a afișa ID-uri de urmărire unice pentru fiecare obiect urmărit.';

  @override
  String get detection_screen_stay => 'Timp de staționare';

  @override
  String get detection_screen_stay_help =>
      'Cât timp trebuie să rămână un obiect în zonă înainte de a fi considerat staționare.';

  @override
  String get detection_screen_stay_max_label => 'Întârziat';

  @override
  String get detection_screen_stay_min_label => 'Imediat';

  @override
  String get detection_screen_stay_threshold =>
      'Determină când un obiect contribuie la numărătoarea de Ședere.\\nValori mai scurte\\n• Numără șederea imediat\\n• Mai bune pentru analiză rapidă\\nValori mai lungi\\n• Ignoră traficul scurt de trecere\\n• Mai bune pentru măsurarea ocupării';

  @override
  String get detection_screen_subtitle =>
      'Ajustați modul în care AI detectează și urmărește obiectele.';

  @override
  String get detection_screen_title => 'Urmărire și numărare';

  @override
  String get detection_screen_track_dialog =>
      'Controlează când un obiect nou detectat devine o nouă urmă.\\nValori mai mici\\n• Urmărirea începe mai devreme\\n• Mai bune pentru obiecte care se mișcă rapid\\n• Pot crea urme duplicate\\nValori mai mari\\n• Necesită dovezi mai puternice înainte de a crea o urmă nouă\\n• Reduc urmele duplicate\\n• Pot întârzia urmărirea obiectelor noi';

  @override
  String get detection_screen_track_memory => 'Memorie de urmărire';

  @override
  String get detection_screen_track_memory_help =>
      'Cât timp să continue urmărirea unui obiect după ce este pierdut temporar. Valorile mai mari ajută la recuperare după scurte obstrucții.';

  @override
  String get detection_screen_track_memory_max_label => 'Lung';

  @override
  String get detection_screen_track_memory_min_label => 'Scurt';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter folosește camera pentru a detecta pietoni și vehicule în timp real. Acest dispozitiv nu are o cameră disponibilă.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Încercați să deschideți această aplicație pe telefonul dvs.';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Un smartphone sau tabletă cu cameră';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Se recomandă un dispozitiv iOS sau Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'De ce aveți nevoie';

  @override
  String get device_not_supported_screen_title => 'Camera nu a fost găsită';

  @override
  String get disappeared => 'Dispăruți';

  @override
  String get disappeared_help =>
      'Numără persoanele sau vehiculele a căror ultimă poziție detectată a fost în această zonă.\\n\\nUrmărirea se încheie după timpul de dispariție configurat dacă persoana sau vehiculul nu mai este detectat.\\n\\n(În principal pentru utilizatori avansați)';

  @override
  String get dpa => 'Acord privind prelucrarea datelor';

  @override
  String get durationDaysShort => '%sz';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ssec';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Au intrat';

  @override
  String get entered_help =>
      'Numără persoanele sau vehiculele care au intrat în această zonă în timpul ferestrei curente de numărare.\\n\\nO intrare este înregistrată atunci când o persoană sau un vehicul se deplasează din exterior în interiorul zonei.';

  @override
  String get exited => 'Au ieșit';

  @override
  String get exited_help =>
      'Numără persoanele sau vehiculele care au ieșit din această zonă în timpul ferestrei curente de numărare.\\n\\nO ieșire este înregistrată atunci când o persoană sau un vehicul se deplasează din interiorul zonei spre exterior.';

  @override
  String get language_screen_language => 'Limbă';

  @override
  String get language_screen_subtitle => 'Alege limba utilizată în aplicație.';

  @override
  String get local_only_screen_body =>
      'Modul Doar dispozitiv local îți permite să testezi detectarea și urmărirea prin cameră cu AI fără a încărca date. Toate statisticile de trafic pietonal sunt procesate doar pe acest dispozitiv, perfect pentru testare înainte de a te conecta la un server.';

  @override
  String get local_only_screen_use_action =>
      'Utilizați doar dispozitivul local';

  @override
  String get local_screen_text =>
      'Piyuo Counter va funcționa în întregime pe acest dispozitiv.\\nStatisticile de trafic vor fi stocate doar pe acest dispozitiv și nu vor fi încărcate.\\nMai târziu vă puteți conecta la Piyuo Cloud sau la propriul server din Setări.';

  @override
  String get maximum_occupancy => 'Număr maxim de persoane';

  @override
  String get maximum_occupancy_help =>
      'Afișează cel mai mare număr de persoane sau vehicule aflate simultan în această zonă în timpul ferestrei curente de numărare.\\n\\nUtil pentru identificarea perioadelor de vârf ale aglomerației sau traficului.';

  @override
  String get maximum_stay => 'Durata maximă de staționare';

  @override
  String get maximum_stay_help =>
      'Afișează cea mai lungă perioadă în care o persoană sau un vehicul a rămas în această zonă în timpul ferestrei curente de numărare.\\n\\nUtil pentru identificarea vizitelor sau opririlor neobișnuit de lungi.';

  @override
  String get metric_events => 'Evenimente';

  @override
  String get metric_live => 'Live';

  @override
  String get metric_show_less => 'Afișează mai puțin';

  @override
  String get metric_show_more => 'Afișează mai mult';

  @override
  String get metric_statistics => 'Statistici';

  @override
  String get metrics_counting_all => 'Toate';

  @override
  String get metrics_counting_done => 'Finalizat';

  @override
  String get metrics_counting_in_progress => 'În desfășurare';

  @override
  String get metrics_counting_missing => 'Lipsă';

  @override
  String get metrics_counting_window =>
      'Statistici pentru fiecare perioadă de 5 minute';

  @override
  String get onboarding_back_action => 'Înapoi';

  @override
  String get onboarding_cta_no_server => 'Preferați să nu încărcați date?';

  @override
  String get onboarding_cta_title => 'Unde ar trebui trimise datele dvs.?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter folosește camera telefonului tău și o IA integrată pentru a recunoaște oameni și vehicule pe loc.\\nCu tehnologie de detectare și urmărire, numără automat fluxul de pietoni și vehicule — totul se procesează chiar pe telefonul tău.';

  @override
  String get onboarding_intro_text2 =>
      'Toată procesarea IA are loc local, pe telefonul tău. Nu se încarcă niciun videoclip, imagine, față sau identitate.\\nSe partajează doar rezumate anonime la fiecare 5 minute, cu statistici despre numărători, ocupare, intrări, ieșiri și timp de ședere.';

  @override
  String get onboarding_intro_text3 =>
      'Este suficient să pornești aplicația și să o lași să ruleze. Piyuo Counter colectează și salvează automat datele de trafic în mod continuu.\\nRezumatele de date sunt salvate la fiecare 5 minute și încărcate în fiecare oră pe Piyuo Cloud sau pe serverul tău propriu.';

  @override
  String get onboarding_intro_title1 => 'Numărare trafic cu AI';

  @override
  String get onboarding_intro_title2 => 'Confidențialitate din proiectare';

  @override
  String get onboarding_intro_title3 => 'Rulează automat 24/7';

  @override
  String get onboarding_next_action => 'Următorul';

  @override
  String get onboarding_skip_action => 'Omite introducerea';

  @override
  String get onboarding_start_action => 'Pornește';

  @override
  String get passed_by => 'Trecuți';

  @override
  String get passed_by_help =>
      'Numără persoanele sau vehiculele care au trecut prin această zonă în timpul ferestrei curente de numărare.\\n\\nFiecare persoană sau vehicul este numărat o singură dată pentru fiecare trecere prin zonă.';

  @override
  String get payloads_screen_area => 'Zonă';

  @override
  String get payloads_screen_confidence => 'Încredere';

  @override
  String get payloads_screen_coverage => 'Acoperire';

  @override
  String get payloads_screen_delivered => 'Livrat';

  @override
  String get payloads_screen_failed_load =>
      'Încărcarea payload-urilor recente a eșuat';

  @override
  String get payloads_screen_frame_processed => 'Cadre procesate';

  @override
  String get payloads_screen_hour_not_exists => 'Această oră nu mai există.';

  @override
  String get payloads_screen_missing_time => 'Timp lipsă';

  @override
  String get payloads_screen_no_payloads => 'Încă nu există payload-uri.';

  @override
  String get payloads_screen_partial =>
      'Fereastra s-a încheiat mai devreme (parțial)';

  @override
  String get payloads_screen_partially => 'Livrat parțial';

  @override
  String get payloads_screen_payload_not_exists =>
      'Acest payload nu mai există.';

  @override
  String get payloads_screen_pending => 'În așteptarea livrării';

  @override
  String get payloads_screen_process_fps => 'FPS procesare';

  @override
  String get payloads_screen_resend => 'Retrimite';

  @override
  String get payloads_screen_select_first =>
      'Selectați mai întâi cel puțin o dată sau o oră.';

  @override
  String get payloads_screen_subtitle =>
      'Selectați după dată sau oră pentru retrimitere';

  @override
  String get payloads_screen_title => 'Payload-uri recente';

  @override
  String get personal_custom_screen_build_server =>
      'Aveți nevoie de ajutor pentru configurarea propriului server?\\nConsultați documentația API și exemplele de server.';

  @override
  String get personal_custom_screen_help_action => 'Deschide documentația API';

  @override
  String get personal_custom_screen_reset_action => 'Începeți din nou';

  @override
  String get personal_custom_success_screen_help =>
      'Apăsați Start mai jos pentru a începe numărarea.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Statisticile de trafic sunt încărcate automat în fiecare oră.\\nLe puteți încărca și manual din ecranul Jurnale de încărcare.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Serverul dvs. nu trebuie să fie încă online.\\nÎncepeți numărarea acum. Puteți termina configurarea și testarea serverului mai târziu. Statisticile de trafic vor rămâne pe acest dispozitiv până când vor fi încărcate cu succes.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Statisticile de trafic vor fi trimise către';

  @override
  String get personal_custom_success_screen_title =>
      'Serverul dvs. este pregătit';

  @override
  String get piyuo_server_screen_cloud_url_label => 'URL-ul dvs. Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Copiază URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copiat';

  @override
  String get piyuo_server_screen_saving_action => 'Se salvează...';

  @override
  String get piyuo_server_screen_start =>
      'Apăsați pe \"Start\" de mai jos pentru a începe numărarea.';

  @override
  String get piyuo_server_screen_url_help =>
      'Panoul dvs. personal Piyuo Cloud este disponibil la acest URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Salvați acest URL pentru a accesa tabloul de bord al traficului de pe alt dispozitiv.';

  @override
  String get piyuo_server_screen_use_action => 'Folosește Piyuo Cloud';

  @override
  String get privacy => 'Politica de confidențialitate';

  @override
  String get product_copyright => 'Drepturi de autor © 2026';

  @override
  String get product_desc =>
      'Numărarea persoanelor și vehiculelor cu ajutorul IA.';

  @override
  String get settings_screen_custom_subtitle =>
      'Trimiteți datele de trafic direct către backend-ul sau baza dvs. de date.';

  @override
  String get settings_screen_custom_title => 'Folosește server personalizat';

  @override
  String get settings_screen_data_server_label => 'Server de date';

  @override
  String get settings_screen_detection_target => 'Țintă detectare';

  @override
  String get settings_screen_language_title => 'Limbă';

  @override
  String get settings_screen_local_subtitle =>
      'Stocați datele de trafic doar pe acest dispozitiv. Nimic nu este încărcat.';

  @override
  String get settings_screen_local_title => 'Doar dispozitiv local';

  @override
  String get settings_screen_misc_label => 'Diverse';

  @override
  String get settings_screen_object_detection => 'Detectarea obiectelor';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Stocați datele de trafic în Piyuo Cloud cu tablouri de bord și informații utile pentru afacere.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Această acțiune va șterge toate datele și va începe de la zero. Această acțiune nu poate fi anulată.';

  @override
  String get settings_screen_reset_all_data_title => 'Resetați toate datele?';

  @override
  String get settings_screen_subscription_body =>
      'Gestionați abonamentul și detaliile de facturare';

  @override
  String get settings_screen_subscription_title => 'Abonament';

  @override
  String get start_screen_about => 'Despre';

  @override
  String get start_screen_server_none =>
      'Datele sunt stocate doar pe acest dispozitiv';

  @override
  String get start_screen_server_personal =>
      'Datele sunt încărcate la fiecare oră către';

  @override
  String get start_screen_settings => 'Setări';

  @override
  String get start_screen_upload_logs => 'Încarcă jurnalele';

  @override
  String get start_screen_video_sources => 'Surse video';

  @override
  String get stayed => 'Rămași';

  @override
  String get stayed_help =>
      'Numără persoanele sau vehiculele care au rămas în această zonă cel puțin timpul de staționare configurat.\\n\\nTimpul implicit de staționare este de 15 secunde și poate fi modificat din Setări.';

  @override
  String get target_pedestrian => 'Pieton';

  @override
  String get target_pedestrian_help =>
      'Numărați persoanele folosind modelul de detectare a pietonilor';

  @override
  String get target_screen_subtitle =>
      'Alegeți modelul de detectare pe care doriți să îl utilizați';

  @override
  String get target_vehicle => 'Vehicul';

  @override
  String get target_vehicle_help =>
      'Numărați mașinile și alte vehicule folosind modelul de detectare a vehiculelor';

  @override
  String get telemetry_error_connection_refused =>
      'Nu s-a putut contacta serverul. Este posibil să fie offline momentan.';

  @override
  String get telemetry_error_connection_reset =>
      'Conexiunea a fost resetată. Verifică conexiunea la internet și încearcă din nou.';

  @override
  String get telemetry_error_connection_timeout =>
      'Conexiunea a durat prea mult să răspundă. Verifică conexiunea la internet și încearcă din nou.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Adresa serverului nu a fost găsită. Verifică conexiunea la internet sau URL-ul serverului.';

  @override
  String get telemetry_error_http_error_status =>
      'Serverul a respins cererea. Încearcă din nou mai târziu.';

  @override
  String get telemetry_error_http_unknown_error =>
      'A apărut o eroare neașteptată în timpul comunicării cu serverul.';

  @override
  String get telemetry_error_invalid_url =>
      'Adresa serverului este nevalidă. Verifică setările.';

  @override
  String get telemetry_error_network_error =>
      'A apărut o eroare de rețea. Verifică conexiunea la internet și încearcă din nou.';

  @override
  String get telemetry_error_socket_error =>
      'A apărut o problemă de conexiune la rețea. Verifică conexiunea la internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Ceva nu a funcționat la trimiterea datelor. Încearcă din nou.';

  @override
  String get terms => 'Termeni de utilizare';

  @override
  String get upload_screen_attempt_time => 'Ora încercării:';

  @override
  String get upload_screen_error => 'Eroare:';

  @override
  String get upload_screen_failed => 'Eșuat';

  @override
  String get upload_screen_load_error =>
      'Nu se pot încărca jurnalele de încărcare.';

  @override
  String get upload_screen_log_not_exists =>
      'Jurnalul de încărcare nu mai este disponibil.';

  @override
  String get upload_screen_next => 'Următoarea încărcare la ...';

  @override
  String get upload_screen_next_upload_prefix => 'Următoarea încărcare la ';

  @override
  String get upload_screen_no_data_server =>
      'Setați mai întâi serverul de date.';

  @override
  String get upload_screen_no_logs => 'Nu există încă jurnale de încărcare.';

  @override
  String get upload_screen_payload_count => 'Număr de payload-uri';

  @override
  String get upload_screen_payload_count_label => 'Număr de payload-uri:';

  @override
  String get upload_screen_payload_size => 'Dimensiune payload:';

  @override
  String get upload_screen_result => 'Rezultat:';

  @override
  String get upload_screen_retry => 'Număr de reîncercări:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Succes';

  @override
  String get upload_screen_today => 'Astăzi';

  @override
  String get upload_screen_upload_now => 'Încarcă acum';

  @override
  String get upload_screen_upload_success => 'Încărcare reușită.';

  @override
  String get upload_screen_uploading => 'Se încarcă...';

  @override
  String get upload_screen_yesterday => 'Ieri';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URL-urile RTSP trebuie să includă un nume de gazdă.';

  @override
  String get url_screen_invalid_url_error =>
      'Introduceți un URL valid cu o schemă acceptată.';

  @override
  String get url_screen_subtitle =>
      'Vă rugăm să introduceți URL-ul fluxului live';

  @override
  String get url_screen_title => 'URL flux live';

  @override
  String get url_screen_unsupported_scheme_error =>
      ' RTSP et RTSPS sont prises en charge.';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Introduceți o adresă URL pentru transmisia live.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://exemplu.com/flux sau rtsp://exemplu.com/flux';

  @override
  String get video_sources_back_camera => 'Camera din spate';

  @override
  String get video_sources_camera => 'Cameră';

  @override
  String get video_sources_file => 'Fișier';

  @override
  String get video_sources_front_camera => 'Camera frontală';

  @override
  String get video_sources_live_stream => 'URL flux live';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Trebuie să acordați permisiunea pentru cameră pentru a o putea utiliza';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Camera nu a fost găsită';

  @override
  String get video_sources_screen_import_error =>
      'Nu s-a putut importa fișierul video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Mergeți la setări și permiteți accesul la fotografii pentru această aplicație.';

  @override
  String get video_sources_screen_select_camera =>
      'Atinge pentru a selecta această cameră';

  @override
  String get video_sources_screen_select_file =>
      'Atinge pentru a alege un fișier';

  @override
  String get video_sources_screen_select_live =>
      'Atinge pentru a seta adresa URL a transmisiei live';

  @override
  String get video_sources_webcam => 'Webcam';
}
