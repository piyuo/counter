// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationIt extends AppLocalization {
  AppLocalizationIt([String locale = 'it']) : super(locale);

  @override
  String get product_name => 'Contatore Visivo';

  @override
  String get product_desc => 'Utilizza la visione artificiale e l\'IA per contare persone, veicoli, animali domestici e altro.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL di streaming live';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_camera => 'Fotocamera';

  @override
  String get video_sources_camera_not_found_title => 'Fotocamera non trovata';

  @override
  String get video_sources_camera_not_found_message => 'È necessario concedere i permessi per utilizzare la fotocamera';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam non trovata';

  @override
  String get video_sources_webcam_not_found_message => 'Verificare che una webcam sia collegata';

  @override
  String get wizard_screen_desc => 'Crea un nuovo progetto per iniziare a contare.';

  @override
  String get wizard_screen_new_project_from => 'Nuovo progetto da';

  @override
  String get wizard_screen_language => 'Lingua';

  @override
  String get wizard_screen_about => 'Informazioni';

  @override
  String get wizard_screen_open_projects_tip => 'Tutti i progetti verranno salvati automaticamente in locale';

  @override
  String get wizard_screen_open_projects => 'Apri progetto esistente';

  @override
  String get wizard_screen_email_us => 'Contattaci via email';

  @override
  String get language_screen_language => 'Lingua';

  @override
  String get project_view_no_videos => 'Nessuna fonte video disponibile.';

  @override
  String get about_screen_title => 'Informazioni';

  @override
  String get about_screen_platform => 'Piattaforma';

  @override
  String get about_screen_app_version => 'Versione dell\'app';

  @override
  String get about_screen_models => 'Modelli di rilevamento oggetti';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informazioni di build OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmark dei modelli';

  @override
  String get benchmark_screen_recommended => 'Modello consigliato';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Avvia benchmark';

  @override
  String get benchmark_screen_start_failed => 'Impossibile avviare il benchmark, il codice di errore è';

  @override
  String get benchmark_screen_models => 'Modelli di rilevamento oggetti';

  @override
  String get project_screen_title => 'Progetto';

  @override
  String get project_screen_exit_confirm_title => 'Conferma uscita dal progetto';

  @override
  String get project_screen_exit_confirm_content => 'Lasciando il progetto il conteggio verrà interrotto. Sei sicuro di voler continuare?';

  @override
  String get project_screen_exit_button => 'Esci';

  @override
  String get project_screen_add_video_button => 'Aggiungi fonte video';

  @override
  String get project_screen_from_desc => 'Conserviamo una registrazione delle ultime 24 ore, così puoi visualizzare qualsiasi periodo temporale necessario.';

  @override
  String get project_screen_report_settings => 'Impostazioni';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get filter_screen_desc => 'Seleziona un intervallo di filtro dall\'elenco sottostante';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_error_content => 'L\'ora di fine deve essere successiva all\'ora di inizio';

  @override
  String get filter_screen_error_custom => 'Personalizzato';

  @override
  String get filter_screen_error_start => 'Inizio';

  @override
  String get filter_screen_error_end => 'Fine';

  @override
  String get settings_screen_title => 'Impostazioni';

  @override
  String get settings_screen_desc => 'Imposta nome del progetto, parametri di rilevamento, azzeramento conteggi.';

  @override
  String get settings_screen_project_id => 'ID Progetto';

  @override
  String get settings_screen_project_name => 'Nome Progetto';

  @override
  String get settings_screen_project_name_place_holder => 'Via Roma 123 o Parco Centrale';

  @override
  String get settings_screen_project_error => 'Il nome del progetto non può essere vuoto';

  @override
  String get settings_screen_random_count_button => 'Aggiungi conteggi casuali';

  @override
  String get settings_screen_reset_count_header => 'Azzera tutti i conteggi in questo progetto';

  @override
  String get settings_screen_reset_count_button => 'Azzera conteggi';

  @override
  String get settings_screen_reset_count_content => 'Sei sicuro di voler azzerare tutti i conteggi?';

  @override
  String get settings_screen_delete_header => 'Elimina questo progetto';

  @override
  String get settings_screen_delete_content => 'Sei sicuro di voler eliminare questo progetto?';

  @override
  String get settings_screen_delete_button => 'Elimina';

  @override
  String get settings_screen_center_point_title => 'Punto centrale sull\'obiettivo';

  @override
  String get settings_screen_center_point_desc => 'Il punto centrale aiuta a determinare se l\'obiettivo si trova all\'interno della zona di rilevamento.';

  @override
  String get settings_screen_center_point_button => 'Mostra punto centrale sull\'obiettivo';

  @override
  String get settings_screen_lost_target_title => 'Obiettivo perso';

  @override
  String get settings_screen_lost_target_desc => 'Quando il tracciamento perde un obiettivo, questa opzione lo rende visibile. Per impostazione predefinita, gli obiettivi persi non vengono mostrati.';

  @override
  String get settings_screen_lost_target_button => 'Mostra obiettivo perso';

  @override
  String get detection_screen_title => 'Impostazioni di rilevamento';

  @override
  String get detection_screen_models => 'Modelli';

  @override
  String get detection_screen_confidence => 'Confidenza';

  @override
  String get detection_screen_confidence_desc => 'confidenza superiore a #0 considerata come rilevamento valido';

  @override
  String get detection_screen_low => 'Bassa';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_nms => 'Non-Maximum Suppression';

  @override
  String get detection_screen_nms_desc => '#0 Una soglia NMS più bassa (es. 30%) rimuoverà più aggressivamente i riquadri sovrapposti, mentre una soglia NMS più alta (es. 0.6) consentirà maggiore sovrapposizione';

  @override
  String get detection_screen_match => 'Corrispondenza';

  @override
  String get detection_screen_match_desc => 'Corrispondenza superiore a #0 è considerata lo stesso oggetto.';

  @override
  String get detection_screen_lost => 'Perso';

  @override
  String get detection_screen_lost_desc => 'L\'oggetto tracciato verrà rimosso se viene perso per #0';

  @override
  String get detection_screen_consider_valid => 'Considera valido dopo';

  @override
  String get detection_screen_consider_valid_desc => 'L\'oggetto tracciato sarà considerato valido dopo #0';

  @override
  String get detection_screen_reset => 'Ripristina';

  @override
  String get detection_screen_reset_content => 'Sei sicuro di voler ripristinare le impostazioni di rilevamento?';

  @override
  String get url_screen_title => 'URL streaming live';

  @override
  String get url_screen_desc => 'Inserisci l\'URL dello streaming live';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://esempio.com/stream o rtsp://esempio.com/stream';

  @override
  String get add_video_screen_title => 'Aggiungi fonte video';

  @override
  String get add_video_screen_from => 'Aggiungi fonte video da';

  @override
  String get webcam_screen_add_title => 'Aggiungi webcam';

  @override
  String get webcam_screen_edit_title => 'Scegli webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Fotocamera frontale';

  @override
  String get camera_screen_back_camera => 'Fotocamera posteriore';

  @override
  String get camera_screen_add_title => 'Aggiungi fotocamera';

  @override
  String get camera_screen_edit_title => 'Scegli fotocamera';

  @override
  String get camera_screen_zoom_level => 'Livello zoom';

  @override
  String get video_screen_name_empty => 'Il nome della fonte video non può essere vuoto.';

  @override
  String get video_screen_desc => 'Gestisci fonti video, aggiungi o modifica zone di rilevamento.';

  @override
  String get video_screen_video_name => 'Nome fonte video';

  @override
  String get video_screen_edit_placeholder => 'Telecamera ingresso o Telecamera parcheggio';

  @override
  String get video_screen_change_file => 'Cambia file';

  @override
  String get video_screen_add_zone => 'Aggiungi zona di rilevamento';

  @override
  String get video_screen_zones => 'Zone di rilevamento';

  @override
  String get video_screen_zones_desc => 'Usa il drag and drop per regolare le zone';

  @override
  String get video_screen_tools => 'Strumenti';

  @override
  String get video_screen_move_bottom => 'Sposta zona corrente in fondo';

  @override
  String get video_screen_add_point => 'Aggiungi punto alla zona corrente';

  @override
  String get video_screen_remove_point => 'Rimuovi punto dalla zona corrente';

  @override
  String get video_screen_playback_speed => 'Velocità di riproduzione';

  @override
  String get video_screen_playback_current => 'attuale: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Elimina questa fonte video';

  @override
  String get video_screen_delete_content => 'Sei sicuro di voler eliminare questa fonte video?';

  @override
  String get video_screen_delete_button => 'Elimina';

  @override
  String get video_screen_sources => 'Configura fonte immagine, obiettivi di rilevamento e parametri del modello.';

  @override
  String get video_screen_targets => 'Obiettivi di rilevamento';

  @override
  String get video_screen_detection => 'Parametri del modello';

  @override
  String get color_screen_title => 'Scegli un colore';

  @override
  String get zone_screen_desc => 'La zona di rilevamento può impostare i tipi di oggetti da rilevare e scegliere quali contatori visualizzare, come Rilevati, Generati e Entrati.';

  @override
  String get zone_screen_name_placeholder => 'Nome della zona, come Marciapiede o Parcheggio';

  @override
  String get zone_screen_zone_color => 'Colore zona';

  @override
  String get zone_screen_color => 'Colore';

  @override
  String get zone_screen_delete_header => 'Elimina questa zona';

  @override
  String get zone_screen_delete_content => 'Sei sicuro di voler eliminare questa zona?';

  @override
  String get zone_screen_delete_button => 'Elimina';

  @override
  String get zone_screen_can_not_delete => 'Impossibile eliminare la zona';

  @override
  String get zone_screen_one_zone_required => 'È richiesta almeno una zona.';

  @override
  String get zone_screen_zone_name_required => 'Il nome della zona non può essere vuoto';

  @override
  String get counter_screen_show_on => 'Mostra sullo schermo';

  @override
  String get counter_screen_enabled => 'Abilitato';

  @override
  String get counter_screen_reentry_threshold => 'Soglia di rientro';

  @override
  String get counter_screen_reentry_desc => 'Gli oggetti devono entrare #0 volte, con un tempo di attesa di #1 secondi tra ogni uscita e rientro, per attivare il conteggio di rientro';

  @override
  String get counter_screen_reentry_title => 'Conteggio rientri';

  @override
  String get counter_screen_cooldown_threshold => 'Soglia tempo di attesa';

  @override
  String get counter_screen_cooldown_desc => 'Il rientro richiede un tempo di attesa di #0 secondi dopo l\'uscita dalla zona di rilevamento';

  @override
  String get counter_screen_cooldown_time => 'Tempo di attesa';

  @override
  String get counter_screen_cooldown_in_seconds => 'in secondi';

  @override
  String get counter_screen_stagnant_threshold => 'Soglia di stazionamento';

  @override
  String get counter_screen_stagnant_desc => 'Gli oggetti che rimangono fermi per più di #0 secondi saranno considerati stazionari';

  @override
  String get counter_screen_stagnant_consider => 'Considera come stazionario';

  @override
  String get counter_screen_stagnant_in_seconds => 'in secondi';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefisso descrizione';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffisso descrizione';

  @override
  String get counter_screen_name_error => 'Il nome del contatore non può essere vuoto';

  @override
  String get counter_screen_enabled_error => 'Errore';

  @override
  String get counter_screen_enabled_error_content => 'Devi prima abilitare un altro contatore, poi potrai disabilitare questo';

  @override
  String get objects_screen_title => 'Oggetti';

  @override
  String get objects_screen_desc => 'Scegli obiettivi di rilevamento come persone, auto, autobus, ecc.';

  @override
  String get open_project_screen_title => 'Apri progetto';

  @override
  String get open_project_screen_desc => 'Apri progetti creati in precedenza, mantenendo solo i 20 più recenti.';

  @override
  String get open_project_screen_no_project => 'Nessun progetto trovato.';

  @override
  String get default_project_name => 'Progetto';

  @override
  String get default_video_name => 'Fonte video';

  @override
  String get default_zone_name => 'Zona di rilevamento';

  @override
  String get error_oops => 'Ops, qualcosa è andato storto';

  @override
  String get error_content => 'Si è verificato un errore imprevisto. Desideri inviare una segnalazione via email?';

  @override
  String get error_report => 'Contattaci';

  @override
  String get submit => 'Invia';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annulla';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get close => 'Chiudi';

  @override
  String get back => 'Indietro';
}
