// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class LocalizationIt extends Localization {
  LocalizationIt([String locale = 'it']) : super(locale);

  @override
  String get about_screen_app_version => 'Versione dell\'app';

  @override
  String get about_screen_email_us => 'Contattaci via email';

  @override
  String get about_screen_platform => 'Piattaforma';

  @override
  String get appeared => 'Comparsi';

  @override
  String get appeared_help =>
      'Conta le persone o i veicoli la cui prima posizione rilevata era all\'interno di quest\'area.\\n\\nUtile per capire dove inizia il tracciamento.\\n\\n(Principalmente per utenti avanzati)';

  @override
  String get average_occupancy => 'Occupazione media';

  @override
  String get average_occupancy_help =>
      'Mostra il numero medio di persone o veicoli presenti in quest\'area durante l\'attuale finestra di conteggio.\\n\\nAiuta a capire quanto è stata frequentata l\'area durante l\'intero periodo di conteggio.';

  @override
  String get average_stay => 'Tempo medio di permanenza';

  @override
  String get average_stay_help =>
      'Mostra il tempo medio di permanenza di persone o veicoli in quest\'area.\\n\\nUn tempo medio più lungo può indicare che i clienti trascorrono più tempo in quest\'area.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter utilizza la fotocamera e l\'IA sul dispositivo per contare le persone. Per prima cosa, verifichiamo che il dispositivo sia compatibile.';

  @override
  String get camera_test_screen_instruction =>
      'Punta la fotocamera verso le persone. L\'app disegnerà riquadri intorno a chi rileva.';

  @override
  String get camera_test_screen_next => 'Tocca Avanti per continuare.';

  @override
  String get camera_test_screen_start =>
      'Tocca Avvia. Se richiesto, consenti l\'accesso alla fotocamera.';

  @override
  String get camera_test_screen_test_failed => 'Test non riuscito!';

  @override
  String get camera_test_screen_test_passed => 'Test superato!';

  @override
  String get camera_test_screen_title => 'Test fotocamera IA';

  @override
  String get camera_test_screen_wait =>
      'In attesa che l\'IA rilevi le persone…';

  @override
  String get cta_screen_custom => 'Usa il tuo server';

  @override
  String get cta_screen_custom_help =>
      'Invia i dati sul traffico direttamente al tuo backend o database.';

  @override
  String get cta_screen_footer =>
      'Continuando, accetti i Termini di servizio, l\'Informativa sulla privacy e l\'Accordo sul trattamento dei dati.';

  @override
  String get cta_screen_invitation => 'Usa un codice di invito';

  @override
  String get cta_screen_invitation_help =>
      'Unisciti a un\'organizzazione esistente utilizzando un invito dell\'amministratore.';

  @override
  String get cta_screen_local => 'Solo su questo dispositivo';

  @override
  String get cta_screen_local_help =>
      'Archivia i dati sul traffico solo su questo dispositivo. Nessun dato viene caricato.';

  @override
  String get cta_screen_piyuo => 'Usa Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Archivia i dati sul traffico in Piyuo Cloud con dashboard e analisi aziendali.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter crea statistiche anonime sul traffico ogni 5 minuti.\\nScegli come desideri archiviare e accedere ai tuoi dati.';

  @override
  String get current_occupancy => 'Conteggio attuale';

  @override
  String get current_occupancy_help =>
      'Mostra il numero attuale di persone o veicoli in quest\'area.\\n\\nQuesto numero viene aggiornato in tempo reale ed è utile per verificare che il rilevamento dell\'IA corrisponda a ciò che vedi sullo schermo. Non viene incluso nei dati di telemetria caricati.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Salvataggio...';

  @override
  String get custom_server_screen_server_url_label => 'URL del server';

  @override
  String get detection_screen_confidence => 'Soglia di confidenza';

  @override
  String get detection_screen_confidence_dialog =>
      'Controlla quanto deve essere sicura l\'IA prima di contare una persona o un veicolo.\\nValori più bassi\\n• Rilevano più oggetti\\n• Migliori per oggetti distanti o parzialmente nascosti\\n• Possono aumentare le rilevazioni false\\nValori più alti\\n• Contano solo rilevazioni ad alta affidabilità\\n• Riducono le rilevazioni false\\n• Possono perdere oggetti piccoli o difficili\\nUsa un valore più basso se l\'app non rileva persone o veicoli.\\nUsa un valore più alto se l\'app conta ombre, riflessi o altri oggetti falsi.';

  @override
  String get detection_screen_confidence_help =>
      'Confidenza minima richiesta per rilevare un oggetto.';

  @override
  String get detection_screen_confidence_max_label => 'Rigido';

  @override
  String get detection_screen_confidence_min_label => 'Flessibile';

  @override
  String get detection_screen_disappear => 'Timeout di scomparsa';

  @override
  String get detection_screen_disappear_dialog =>
      'Determina quanto tempo l\'IA attende prima di contrassegnare un oggetto come scomparso dopo che non viene più rilevato.\\nValori più brevi\\n• Contrassegnano gli oggetti come scomparsi prima\\n• Migliori per traffico veloce\\n• Possono contrassegnare oggetti temporaneamente nascosti come scomparsi\\nValori più lunghi\\n• Attendono più a lungo prima di contrassegnare gli oggetti come scomparsi\\n• Migliori quando gli oggetti sono brevemente bloccati o persi\\n• Ritardano gli eventi di scomparsa';

  @override
  String get detection_screen_disappear_help =>
      'Quanto tempo l\'AI attende prima di contrassegnare un oggetto come scomparso dopo aver smesso di rilevarlo.';

  @override
  String get detection_screen_disappear_max_label => 'Lento';

  @override
  String get detection_screen_disappear_min_label => 'Veloce';

  @override
  String get detection_screen_memory_dialog =>
      'Controlla per quanto tempo l\'IA ricorda un oggetto dopo che scompare.\\nAumenta questo valore se persone o veicoli sono spesso nascosti dietro altri oggetti.\\nDiminuisci questo valore se gli oggetti vengono collegati in modo errato dopo aver lasciato la scena.';

  @override
  String get detection_screen_min_presence => 'Tempo minimo di presenza';

  @override
  String get detection_screen_min_presence_help =>
      'Un oggetto deve rimanere visibile prima di essere conteggiato. Valori più alti aiutano a ridurre i falsi rilevamenti brevi.';

  @override
  String get detection_screen_min_presence_max_label => 'Più sicuro';

  @override
  String get detection_screen_min_presence_min_label => 'Più veloce';

  @override
  String get detection_screen_minimum_visible =>
      'Gli oggetti devono rimanere visibili per questo tempo prima di essere contati.\\nAumenta questo valore per ignorare brevi rilevazioni false.\\nDiminuisci questo valore se persone o veicoli in rapido movimento vengono persi.';

  @override
  String get detection_screen_new_track => 'Soglia nuovo tracciamento';

  @override
  String get detection_screen_new_track_help =>
      'Confidenza minima richiesta per iniziare a seguire un nuovo oggetto. Valori bassi possono creare tracciamenti duplicati.';

  @override
  String get detection_screen_new_track_max_label => 'Conservativo';

  @override
  String get detection_screen_new_track_min_label => 'Aggressivo';

  @override
  String get detection_screen_reset => 'Ripristina';

  @override
  String get detection_screen_reset_content =>
      'Sei sicuro di voler ripristinare le impostazioni di rilevamento?';

  @override
  String get detection_screen_show_track_id => 'Mostra ID tracciamento';

  @override
  String get detection_screen_show_track_id_help =>
      'Abilita questa opzione per mostrare ID di tracciamento univoci per ogni oggetto tracciato.';

  @override
  String get detection_screen_stay => 'Tempo di permanenza';

  @override
  String get detection_screen_stay_help =>
      'Quanto tempo un oggetto deve rimanere nell\'area prima di essere conteggiato come permanenza.';

  @override
  String get detection_screen_stay_max_label => 'Ritardato';

  @override
  String get detection_screen_stay_min_label => 'Immediato';

  @override
  String get detection_screen_stay_threshold =>
      'Determina quando un oggetto contribuisce al conteggio di Permanenza.\\nValori più brevi\\n• Contano la permanenza immediatamente\\n• Migliori per analisi rapide\\nValori più lunghi\\n• Ignorano il traffico di passaggio breve\\n• Migliori per la misurazione dell\'occupazione';

  @override
  String get detection_screen_subtitle =>
      'Regola il modo in cui l\'AI rileva e segue gli oggetti.';

  @override
  String get detection_screen_title => 'Tracciamento e conteggio';

  @override
  String get detection_screen_track_dialog =>
      'Controlla quando un oggetto appena rilevato diventa un nuovo tracciamento.\\nValori più bassi\\n• Il tracciamento inizia prima\\n• Migliori per oggetti in movimento veloce\\n• Possono creare tracciamenti duplicati\\nValori più alti\\n• Richiedono prove più solide prima di creare un nuovo tracciamento\\n• Riducono i tracciamenti duplicati\\n• Possono ritardare il tracciamento di nuovi oggetti';

  @override
  String get detection_screen_track_memory => 'Memoria di tracciamento';

  @override
  String get detection_screen_track_memory_help =>
      'Per quanto tempo continuare a seguire un oggetto dopo una perdita temporanea. Valori più alti aiutano a recuperarlo dopo brevi ostruzioni.';

  @override
  String get detection_screen_track_memory_max_label => 'Lungo';

  @override
  String get detection_screen_track_memory_min_label => 'Breve';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter utilizza la fotocamera per rilevare pedoni e veicoli in tempo reale. Questo dispositivo non dispone di una fotocamera.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Prova ad aprire questa app sul tuo telefono';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Uno smartphone o tablet con fotocamera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Si consiglia un dispositivo iOS o Android';

  @override
  String get device_not_supported_screen_requirements_title => 'Cosa ti serve';

  @override
  String get device_not_supported_screen_title => 'Fotocamera non trovata';

  @override
  String get disappeared => 'Scomparsi';

  @override
  String get disappeared_help =>
      'Conta le persone o i veicoli la cui ultima posizione rilevata era all\'interno di quest\'area.\\n\\nIl tracciamento termina dopo il Tempo di Scomparsa configurato se la persona o il veicolo non viene più rilevato.\\n\\n(Principalmente per utenti avanzati)';

  @override
  String get dpa => 'Accordo sul trattamento dei dati';

  @override
  String get durationDaysShort => '%sg';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Entrati';

  @override
  String get entered_help =>
      'Conta le persone o i veicoli che sono entrati in quest\'area durante l\'attuale finestra di conteggio.\\n\\nUn ingresso viene conteggiato quando una persona o un veicolo si sposta dall\'esterno all\'interno dell\'area.';

  @override
  String get exited => 'Usciti';

  @override
  String get exited_help =>
      'Conta le persone o i veicoli che sono usciti da quest\'area durante l\'attuale finestra di conteggio.\\n\\nUn\'uscita viene conteggiata quando una persona o un veicolo si sposta dall\'interno verso l\'esterno dell\'area.';

  @override
  String get language_screen_language => 'Lingua';

  @override
  String get language_screen_subtitle =>
      'Scegli la lingua utilizzata nell\'app.';

  @override
  String get local_only_screen_body =>
      'La modalità Solo dispositivo locale ti permette di provare il rilevamento e il tracciamento con telecamera AI senza caricare alcun dato. Tutte le statistiche sul traffico pedonale vengono elaborate solo su questo dispositivo, ideale per fare test prima di collegarti a un server.';

  @override
  String get local_only_screen_use_action => 'Usa solo il dispositivo locale';

  @override
  String get local_screen_text =>
      'Piyuo Counter funzionerà interamente su questo dispositivo.\\nLe statistiche sul traffico saranno archiviate solo su questo dispositivo e non verranno caricate.\\nPotrai collegarti a Piyuo Cloud o al tuo server dalle Impostazioni in qualsiasi momento.';

  @override
  String get maximum_occupancy => 'Occupazione massima';

  @override
  String get maximum_occupancy_help =>
      'Mostra il numero massimo di persone o veicoli presenti contemporaneamente in quest\'area durante l\'attuale finestra di conteggio.\\n\\nUtile per identificare i momenti di maggiore affluenza o traffico.';

  @override
  String get maximum_stay => 'Tempo massimo di permanenza';

  @override
  String get maximum_stay_help =>
      'Mostra il tempo massimo di permanenza di una persona o di un veicolo in quest\'area durante l\'attuale finestra di conteggio.\\n\\nUtile per individuare visite o soste insolitamente lunghe.';

  @override
  String get metric_events => 'Eventi';

  @override
  String get metric_live => 'Live';

  @override
  String get metric_show_less => 'Mostra meno';

  @override
  String get metric_show_more => 'Mostra di più';

  @override
  String get metric_statistics => 'Statistiche';

  @override
  String get metrics_counting_all => 'Tutti';

  @override
  String get metrics_counting_done => 'Completato';

  @override
  String get metrics_counting_in_progress => 'In corso';

  @override
  String get metrics_counting_missing => 'Mancante';

  @override
  String get metrics_counting_window =>
      'Statistiche per ogni periodo di 5 minuti';

  @override
  String get onboarding_back_action => 'Indietro';

  @override
  String get onboarding_cta_no_server => 'Preferisci non caricare dati?';

  @override
  String get onboarding_cta_title => 'Dove devono essere inviati i tuoi dati?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter usa la fotocamera del tuo dispositivo e un\'IA integrata per riconoscere persone e veicoli in tempo reale.\\nGrazie alla tecnologia di rilevamento e tracciamento, conta automaticamente il flusso di pedoni e veicoli — tutto elaborato direttamente sul tuo dispositivo.';

  @override
  String get onboarding_intro_text2 =>
      'Tutta l\'elaborazione IA avviene localmente sul tuo dispositivo. Nessun video, immagine, volto o identità viene caricato.\\nVengono condivisi solo riepiloghi anonimi ogni 5 minuti, con statistiche su conteggi, occupazione, ingressi, uscite e tempo di permanenza.';

  @override
  String get onboarding_intro_text3 =>
      'Basta avviare l\'app e lasciarla in esecuzione. Piyuo Counter raccoglie e salva automaticamente i dati sul traffico in modo continuo.\\nI riepiloghi dei dati vengono salvati ogni 5 minuti e caricati ogni ora su Piyuo Cloud o sul tuo server personale.';

  @override
  String get onboarding_intro_title1 => 'Conteggio del traffico con IA';

  @override
  String get onboarding_intro_title2 => 'Privacy fin dalla progettazione';

  @override
  String get onboarding_intro_title3 => 'Funziona automaticamente 24/7';

  @override
  String get onboarding_next_action => 'Avanti';

  @override
  String get onboarding_skip_action => 'Salta introduzione';

  @override
  String get onboarding_start_action => 'Avvia';

  @override
  String get passed_by => 'Passati';

  @override
  String get passed_by_help =>
      'Conta le persone o i veicoli che sono passati attraverso quest\'area durante l\'attuale finestra di conteggio.\\n\\nOgni persona o veicolo viene conteggiato una sola volta per ogni passaggio nell\'area.';

  @override
  String get payloads_screen_area => 'Area';

  @override
  String get payloads_screen_confidence => 'Affidabilità';

  @override
  String get payloads_screen_coverage => 'Copertura';

  @override
  String get payloads_screen_delivered => 'Consegnato';

  @override
  String get payloads_screen_failed_load =>
      'Impossibile caricare i payload recenti';

  @override
  String get payloads_screen_frame_processed => 'Frame elaborati';

  @override
  String get payloads_screen_hour_not_exists => 'Quest\'ora non esiste più.';

  @override
  String get payloads_screen_missing_time => 'Tempo mancante';

  @override
  String get payloads_screen_no_payloads => 'Nessun payload disponibile.';

  @override
  String get payloads_screen_partial =>
      'Finestra terminata in anticipo (parziale)';

  @override
  String get payloads_screen_partially => 'Consegnato parzialmente';

  @override
  String get payloads_screen_payload_not_exists =>
      'Questo payload non esiste più.';

  @override
  String get payloads_screen_pending => 'In attesa di consegna';

  @override
  String get payloads_screen_process_fps => 'FPS di elaborazione';

  @override
  String get payloads_screen_resend => 'Invia di nuovo';

  @override
  String get payloads_screen_select_first =>
      'Seleziona prima almeno una data o un\'ora.';

  @override
  String get payloads_screen_subtitle =>
      'Seleziona per data o ora per inviare di nuovo';

  @override
  String get payloads_screen_title => 'Payload recenti';

  @override
  String get personal_custom_screen_build_server =>
      'Hai bisogno di aiuto per configurare il tuo server?\\nConsulta la documentazione API e gli esempi di server.';

  @override
  String get personal_custom_screen_help_action => 'Apri documentazione API';

  @override
  String get personal_custom_screen_reset_action => 'Ricomincia';

  @override
  String get personal_custom_success_screen_help =>
      'Tocca Start qui sotto per iniziare il conteggio.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Le statistiche sul traffico vengono caricate automaticamente ogni ora.\\nPuoi anche caricarle manualmente dalla schermata Registro caricamenti.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Il tuo server non deve ancora essere online.\\nInizia subito il conteggio. Potrai completare il server e testarlo più tardi. Le statistiche sul traffico rimarranno su questo dispositivo finché non saranno caricate con successo.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Le statistiche sul traffico verranno inviate a';

  @override
  String get personal_custom_success_screen_title => 'Il tuo server è pronto';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Il tuo URL Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Copia URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copiato';

  @override
  String get piyuo_server_screen_saving_action => 'Salvataggio...';

  @override
  String get piyuo_server_screen_start =>
      'Premi \"Start\" qui sotto per iniziare il conteggio.';

  @override
  String get piyuo_server_screen_url_help =>
      'La tua dashboard personale Piyuo Cloud è pronta a questo URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Salva questo URL per accedere alla dashboard del traffico da un altro dispositivo.';

  @override
  String get piyuo_server_screen_use_action => 'Usa Piyuo Cloud';

  @override
  String get privacy => 'Informativa sulla privacy';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'Conteggio di persone e veicoli con IA.';

  @override
  String get settings_screen_custom_subtitle =>
      'Invia i dati sul traffico direttamente al tuo backend o database.';

  @override
  String get settings_screen_custom_title => 'Usa server personalizzato';

  @override
  String get settings_screen_data_server_label => 'Server dati';

  @override
  String get settings_screen_detection_target => 'Obiettivo di rilevamento';

  @override
  String get settings_screen_language_title => 'Lingua';

  @override
  String get settings_screen_local_subtitle =>
      'Memorizza i dati sul traffico solo su questo dispositivo. Nulla verrà caricato.';

  @override
  String get settings_screen_local_title => 'Solo dispositivo locale';

  @override
  String get settings_screen_misc_label => 'Varie';

  @override
  String get settings_screen_object_detection => 'Rilevamento oggetti';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Archivia i dati sul traffico in Piyuo Cloud con dashboard e analisi aziendali.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Questa operazione eliminerà tutti i dati e ricomincerà da capo. L\'azione non può essere annullata.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Reimpostare tutti i dati?';

  @override
  String get settings_screen_subscription_body =>
      'Gestisci il tuo abbonamento e i dati di fatturazione';

  @override
  String get settings_screen_subscription_title => 'Abbonamento';

  @override
  String get start_screen_about => 'Informazioni';

  @override
  String get start_screen_server_none =>
      'I dati vengono salvati solo su questo dispositivo';

  @override
  String get start_screen_server_personal =>
      'I dati vengono caricati ogni ora su';

  @override
  String get start_screen_settings => 'Impostazioni';

  @override
  String get start_screen_upload_logs => 'Carica registri';

  @override
  String get start_screen_video_sources => 'Sorgenti video';

  @override
  String get stayed => 'Rimasti';

  @override
  String get stayed_help =>
      'Conta le persone o i veicoli rimasti in quest\'area per almeno il Tempo di Permanenza configurato.\\n\\nIl Tempo di Permanenza predefinito è di 15 secondi e può essere modificato nelle Impostazioni.';

  @override
  String get target_pedestrian => 'Pedone';

  @override
  String get target_pedestrian_help =>
      'Conta le persone con il modello di rilevamento pedoni';

  @override
  String get target_screen_subtitle =>
      'Scegli il modello di rilevamento da usare';

  @override
  String get target_vehicle => 'Veicolo';

  @override
  String get target_vehicle_help =>
      'Conta auto e altri veicoli con il modello di rilevamento veicoli';

  @override
  String get telemetry_error_connection_refused =>
      'Impossibile raggiungere il server. Potrebbe essere offline al momento.';

  @override
  String get telemetry_error_connection_reset =>
      'La connessione è stata reimpostata. Controlla la connessione internet e riprova.';

  @override
  String get telemetry_error_connection_timeout =>
      'La connessione ha impiegato troppo tempo a rispondere. Controlla la connessione internet e riprova.';

  @override
  String get telemetry_error_database_error =>
      'Scrittura nel database non riuscita.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Impossibile trovare l\'indirizzo del server. Controlla la connessione internet o l\'URL del server.';

  @override
  String get telemetry_error_http_error_status =>
      'Il server ha rifiutato la richiesta. Riprova più tardi.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Si è verificato un errore imprevisto durante la comunicazione con il server.';

  @override
  String get telemetry_error_invalid_url =>
      'L\'indirizzo del server non è valido. Controlla le impostazioni.';

  @override
  String get telemetry_error_network_error =>
      'Si è verificato un errore di rete. Controlla la connessione internet e riprova.';

  @override
  String get telemetry_error_socket_error =>
      'Si è verificato un problema di connessione di rete. Controlla la connessione internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Si è verificato un problema durante l\'invio dei dati. Riprova.';

  @override
  String get telemetry_error_unknown_error =>
      'Si è verificato un errore imprevisto.';

  @override
  String get terms => 'Termini di servizio';

  @override
  String get upload_screen_attempt_time => 'Ora del tentativo:';

  @override
  String get upload_screen_error => 'Errore:';

  @override
  String get upload_screen_failed => 'Non riuscito';

  @override
  String get upload_screen_load_error =>
      'Impossibile caricare i registri di caricamento.';

  @override
  String get upload_screen_log_not_exists =>
      'Il registro di caricamento non è più disponibile.';

  @override
  String get upload_screen_next => 'Prossimo caricamento alle ...';

  @override
  String get upload_screen_next_upload_prefix => 'Prossimo caricamento alle ';

  @override
  String get upload_screen_no_data_server => 'Imposta prima il server dati.';

  @override
  String get upload_screen_no_logs => 'Nessun registro di caricamento.';

  @override
  String get upload_screen_payload_count => 'Numero di payload';

  @override
  String get upload_screen_payload_count_label => 'Numero di payload:';

  @override
  String get upload_screen_payload_size => 'Dimensione payload:';

  @override
  String get upload_screen_result => 'Risultato:';

  @override
  String get upload_screen_retry => 'Numero di tentativi:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Riuscito';

  @override
  String get upload_screen_today => 'Oggi';

  @override
  String get upload_screen_upload_now => 'Carica ora';

  @override
  String get upload_screen_upload_success => 'Caricamento riuscito.';

  @override
  String get upload_screen_uploading => 'Caricamento...';

  @override
  String get upload_screen_yesterday => 'Ieri';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Gli URL RTSP devono includere un nome host.';

  @override
  String get url_screen_invalid_url_error =>
      'Inserisci un URL valido con uno schema supportato.';

  @override
  String get url_screen_subtitle => 'Inserisci l\'URL dello streaming live';

  @override
  String get url_screen_title => 'URL streaming live';

  @override
  String get url_screen_unsupported_scheme_error => ' RTSP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Inserisci un URL per lo streaming live.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://esempio.com/stream o rtsp://esempio.com/stream';

  @override
  String get video_sources_back_camera => 'Fotocamera posteriore';

  @override
  String get video_sources_camera => 'Fotocamera';

  @override
  String get video_sources_file => 'File';

  @override
  String get video_sources_front_camera => 'Fotocamera anteriore';

  @override
  String get video_sources_live_stream => 'URL di streaming live';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'È necessario concedere i permessi per utilizzare la fotocamera';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Fotocamera non trovata';

  @override
  String get video_sources_screen_import_error =>
      'Impossibile importare il file video.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Vai su impostazioni e consenti l\'accesso alle foto per questa app.';

  @override
  String get video_sources_screen_select_camera =>
      'Tocca per selezionare questa fotocamera';

  @override
  String get video_sources_screen_select_file => 'Tocca per scegliere un file';

  @override
  String get video_sources_screen_select_live =>
      'Tocca per impostare l\'URL dello streaming live';

  @override
  String get video_sources_webcam => 'Webcam';
}
