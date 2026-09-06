// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LocalizationFr extends Localization {
  LocalizationFr([String locale = 'fr']) : super(locale);

  @override
  String get about_screen_app_version => 'Version de l\'application';

  @override
  String get about_screen_email_us => 'Nous contacter';

  @override
  String get about_screen_platform => 'Plateforme';

  @override
  String get appeared => 'Apparus';

  @override
  String get appeared_help =>
      'Compte les personnes ou les véhicules dont la première position détectée se trouvait dans cette zone.\\n\\nUtile pour comprendre où commence le suivi.\\n\\n(Principalement destiné aux utilisateurs avancés)';

  @override
  String get average_occupancy => 'Occupation moyenne';

  @override
  String get average_occupancy_help =>
      'Affiche le nombre moyen de personnes ou de véhicules dans cette zone pendant la fenêtre de comptage en cours.\\n\\nCela permet de mesurer l\'activité de la zone pendant toute la durée de la fenêtre de comptage.';

  @override
  String get average_stay => 'Durée moyenne de présence';

  @override
  String get average_stay_help =>
      'Affiche la durée moyenne de présence des personnes ou des véhicules dans cette zone.\\n\\nUne durée moyenne plus longue peut indiquer que les clients passent plus de temps dans cette zone.';

  @override
  String get camera_test_screen_help =>
      'Piyuo Counter utilise votre caméra et l\'IA embarquée pour compter les personnes. Vérifions d\'abord que votre appareil est compatible.';

  @override
  String get camera_test_screen_instruction =>
      'Dirigez votre caméra vers des personnes. L\'application dessinera un cadre autour de chaque personne détectée.';

  @override
  String get camera_test_screen_next => 'Appuyez sur Suivant pour continuer.';

  @override
  String get camera_test_screen_start =>
      'Appuyez sur Démarrer. Si demandé, autorisez l\'accès à la caméra.';

  @override
  String get camera_test_screen_test_failed => 'Échec du test !';

  @override
  String get camera_test_screen_test_passed => 'Test réussi !';

  @override
  String get camera_test_screen_title => 'Test de la caméra IA';

  @override
  String get camera_test_screen_wait =>
      'En attente que l\'IA détecte des personnes…';

  @override
  String get cta_screen_custom => 'Utiliser votre propre serveur';

  @override
  String get cta_screen_custom_help =>
      'Envoyez les données de trafic directement vers votre backend ou votre base de données.';

  @override
  String get cta_screen_footer =>
      'En continuant, vous acceptez les Conditions d\'utilisation, la Politique de confidentialité et l\'Accord de traitement des données.';

  @override
  String get cta_screen_invitation => 'Utiliser un code d\'invitation';

  @override
  String get cta_screen_invitation_help =>
      'Rejoignez une organisation existante à l\'aide d\'une invitation de votre administrateur.';

  @override
  String get cta_screen_local => 'Appareil local uniquement';

  @override
  String get cta_screen_local_help =>
      'Stockez les données de trafic uniquement sur cet appareil. Aucune donnée n\'est envoyée.';

  @override
  String get cta_screen_piyuo => 'Utiliser Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Stockez les données de trafic dans Piyuo Cloud avec des tableaux de bord et des analyses métier.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Piyuo Counter crée des statistiques de trafic anonymes toutes les 5 minutes.\\nChoisissez comment vous souhaitez stocker et consulter vos données.';

  @override
  String get current_occupancy => 'Nombre actuel';

  @override
  String get current_occupancy_help =>
      'Affiche le nombre actuel de personnes ou de véhicules dans cette zone.\\n\\nCe nombre est mis à jour en temps réel et permet de vérifier que la détection par IA correspond à ce que vous voyez à l\'écran. Il n\'est pas inclus dans les données de télémétrie envoyées.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Enregistrement...';

  @override
  String get custom_server_screen_server_url_label => 'URL du serveur';

  @override
  String get detection_screen_confidence => 'Seuil de confiance';

  @override
  String get detection_screen_confidence_dialog =>
      'Détermine à quel point l\'IA doit être certaine avant de compter une personne ou un véhicule.\\nValeurs basses\\n• Détectent plus d\'objets\\n• Meilleures pour les objets éloignés ou partiellement cachés\\n• Peuvent augmenter les fausses détections\\nValeurs hautes\\n• Comptent seulement les détections très fiables\\n• Réduisent les fausses détections\\n• Peuvent manquer des objets petits ou difficiles\\nUtilisez une valeur plus basse si l\'application manque des personnes ou véhicules.\\nUtilisez une valeur plus haute si l\'application compte des ombres, des reflets ou d\'autres faux objets.';

  @override
  String get detection_screen_confidence_help =>
      'Confiance minimale requise pour détecter un objet.';

  @override
  String get detection_screen_confidence_max_label => 'Strict';

  @override
  String get detection_screen_confidence_min_label => 'Souple';

  @override
  String get detection_screen_disappear => 'Délai avant disparition';

  @override
  String get detection_screen_disappear_dialog =>
      'Détermine combien de temps l\'IA attend avant de marquer un objet comme disparu après qu\'il n\'est plus détecté.\\nValeurs courtes\\n• Marquent les objets comme disparus plus tôt\\n• Meilleures pour un trafic rapide\\n• Peuvent marquer des objets temporairement cachés comme disparus\\nValeurs longues\\n• Attendent plus longtemps avant de marquer les objets comme disparus\\n• Meilleures quand les objets sont brièvement bloqués ou manqués\\n• Retardent les événements de disparition';

  @override
  String get detection_screen_disappear_help =>
      'Temps d\'attente de l\'IA avant de marquer un objet comme disparu après ne plus le détecter.';

  @override
  String get detection_screen_disappear_max_label => 'Lent';

  @override
  String get detection_screen_disappear_min_label => 'Rapide';

  @override
  String get detection_screen_memory_dialog =>
      'Détermine combien de temps l\'IA se souvient d\'un objet après sa disparition.\\nAugmentez cette valeur si des personnes ou véhicules sont souvent cachés derrière d\'autres objets.\\nDiminuez cette valeur si des objets sont incorrectement liés après avoir quitté la scène.';

  @override
  String get detection_screen_min_presence => 'Temps de présence minimal';

  @override
  String get detection_screen_min_presence_help =>
      'Un objet doit rester visible avant d\'être compté. Des valeurs plus élevées aident à réduire les fausses détections brèves.';

  @override
  String get detection_screen_min_presence_max_label => 'Plus sûr';

  @override
  String get detection_screen_min_presence_min_label => 'Plus rapide';

  @override
  String get detection_screen_minimum_visible =>
      'Les objets doivent rester visibles pendant cette durée avant d\'être comptés.\\nAugmentez cette valeur pour ignorer les fausses détections brèves.\\nDiminuez cette valeur si des personnes ou véhicules se déplaçant rapidement sont manqués.';

  @override
  String get detection_screen_new_track => 'Seuil de nouvelle piste';

  @override
  String get detection_screen_new_track_help =>
      'Confiance minimale requise pour commencer à suivre un nouvel objet. Une valeur faible peut créer des suivis en double.';

  @override
  String get detection_screen_new_track_max_label => 'Prudent';

  @override
  String get detection_screen_new_track_min_label => 'Agressif';

  @override
  String get detection_screen_reset => 'Réinitialiser';

  @override
  String get detection_screen_reset_content =>
      'Êtes-vous sûr de vouloir réinitialiser les paramètres de détection ?';

  @override
  String get detection_screen_show_track_id => 'Afficher l\'ID de suivi';

  @override
  String get detection_screen_show_track_id_help =>
      'Activez cette option pour afficher les ID de suivi uniques de chaque objet suivi.';

  @override
  String get detection_screen_stay => 'Temps de présence';

  @override
  String get detection_screen_stay_help =>
      'Temps pendant lequel un objet doit rester dans la zone avant d\'être compté comme présence.';

  @override
  String get detection_screen_stay_max_label => 'Retardé';

  @override
  String get detection_screen_stay_min_label => 'Immédiat';

  @override
  String get detection_screen_stay_threshold =>
      'Détermine quand un objet contribue au comptage de séjour.\\nValeurs courtes\\n• Comptent le séjour immédiatement\\n• Meilleures pour une analyse rapide\\nValeurs longues\\n• Ignorent le trafic de passage bref\\n• Meilleures pour mesurer l\'occupation';

  @override
  String get detection_screen_subtitle =>
      'Ajustez la façon dont l\'IA détecte et suit les objets.';

  @override
  String get detection_screen_title => 'Suivi et comptage';

  @override
  String get detection_screen_track_dialog =>
      'Détermine à quel moment un objet nouvellement détecté devient une nouvelle piste.\\nValeurs basses\\n• Le suivi commence plus tôt\\n• Meilleures pour les objets se déplaçant rapidement\\n• Peuvent créer des pistes en double\\nValeurs hautes\\n• Exigent des preuves plus solides avant de créer une nouvelle piste\\n• Réduisent les pistes en double\\n• Peuvent retarder le suivi des nouveaux objets';

  @override
  String get detection_screen_track_memory => 'Mémoire de suivi';

  @override
  String get detection_screen_track_memory_help =>
      'Durée de conservation du suivi d\'un objet après sa perte temporaire. Une durée plus longue aide à le retrouver après une brève obstruction.';

  @override
  String get detection_screen_track_memory_max_label => 'Long';

  @override
  String get detection_screen_track_memory_min_label => 'Court';

  @override
  String get device_not_supported_screen_body =>
      'Piyuo Counter utilise votre appareil photo pour détecter les piétons et les véhicules en temps réel. Aucun appareil photo n\\\'est disponible sur cet appareil.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Essayez d\\\'ouvrir cette application sur votre téléphone';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Un smartphone ou une tablette avec appareil photo';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Appareil iOS ou Android recommandé';

  @override
  String get device_not_supported_screen_requirements_title =>
      'Ce qu’il vous faut';

  @override
  String get device_not_supported_screen_title => 'Caméra introuvable';

  @override
  String get disappeared => 'Disparus';

  @override
  String get disappeared_help =>
      'Compte les personnes ou les véhicules dont la dernière position détectée se trouvait dans cette zone.\\n\\nLe suivi se termine après le délai de disparition configuré si la personne ou le véhicule n\'est plus détecté.\\n\\n(Principalement destiné aux utilisateurs avancés)';

  @override
  String get dpa => 'Accord de traitement des données';

  @override
  String get durationDaysShort => '%sj';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Entrés';

  @override
  String get entered_help =>
      'Compte les personnes ou les véhicules qui sont entrés dans cette zone pendant la fenêtre de comptage en cours.\\n\\nUne entrée est comptabilisée lorsqu\'une personne ou un véhicule passe de l\'extérieur vers l\'intérieur de la zone.';

  @override
  String get exited => 'Sortis';

  @override
  String get exited_help =>
      'Compte les personnes ou les véhicules qui sont sortis de cette zone pendant la fenêtre de comptage en cours.\\n\\nUne sortie est comptabilisée lorsqu\'une personne ou un véhicule passe de l\'intérieur vers l\'extérieur de la zone.';

  @override
  String get language_screen_language => 'Langue';

  @override
  String get language_screen_subtitle =>
      'Choisissez la langue utilisée dans l\'application.';

  @override
  String get local_only_screen_body =>
      'Le mode Appareil local uniquement vous permet d\'essayer la détection et le suivi par caméra IA sans envoyer aucune donnée. Toutes les statistiques de fréquentation sont traitées uniquement sur cet appareil, idéal pour tester avant de vous connecter à un serveur.';

  @override
  String get local_only_screen_use_action =>
      'Utiliser uniquement l\'appareil local';

  @override
  String get local_screen_text =>
      'Piyuo Counter fonctionne entièrement sur cet appareil.\\nLes statistiques de trafic seront enregistrées uniquement sur cet appareil et ne seront pas envoyées.\\nVous pourrez connecter Piyuo Cloud ou votre propre serveur plus tard depuis les paramètres.';

  @override
  String get maximum_occupancy => 'Occupation maximale';

  @override
  String get maximum_occupancy_help =>
      'Affiche le plus grand nombre de personnes ou de véhicules présents simultanément dans cette zone pendant la fenêtre de comptage en cours.\\n\\nUtile pour identifier les périodes de forte affluence ou de trafic.';

  @override
  String get maximum_stay => 'Durée maximale de présence';

  @override
  String get maximum_stay_help =>
      'Affiche la plus longue durée de présence d\'une personne ou d\'un véhicule dans cette zone pendant la fenêtre de comptage en cours.\\n\\nUtile pour identifier les visites ou arrêts exceptionnellement longs.';

  @override
  String get metric_events => 'Événements';

  @override
  String get metric_live => 'En direct';

  @override
  String get metric_show_less => 'Afficher moins';

  @override
  String get metric_show_more => 'Afficher plus';

  @override
  String get metric_statistics => 'Statistiques';

  @override
  String get metrics_counting_all => 'Tous';

  @override
  String get metrics_counting_done => 'Terminé';

  @override
  String get metrics_counting_in_progress => 'En cours';

  @override
  String get metrics_counting_missing => 'Manquant';

  @override
  String get metrics_counting_window =>
      'Statistiques pour chaque période de 5 minutes';

  @override
  String get onboarding_back_action => 'Retour';

  @override
  String get onboarding_cta_no_server =>
      'Vous préférez ne pas envoyer de données ?';

  @override
  String get onboarding_cta_title =>
      'Où vos données doivent-elles être envoyées ?';

  @override
  String get onboarding_intro_text1 =>
      'Piyuo Counter utilise la caméra de votre appareil et une IA embarquée pour repérer les personnes et véhicules en temps réel.\\nGrâce à une technologie de détection et de suivi, elle compte automatiquement le flux de piétons et de véhicules — tout se passe directement sur votre appareil.';

  @override
  String get onboarding_intro_text2 =>
      'Tout le traitement par IA se fait localement sur votre appareil. Aucune vidéo, image, visage ou identité n\'est envoyé.\\nSeuls des résumés anonymes toutes les 5 minutes sont partagés, incluant les statistiques de comptage, occupation, entrées, sorties et durée de présence.';

  @override
  String get onboarding_intro_text3 =>
      'Il vous suffit de lancer l\'application et de la laisser tourner. Piyuo Counter collecte et enregistre automatiquement les données de trafic en continu.\\nLes résumés de données sont enregistrés toutes les 5 minutes et envoyés chaque heure vers Piyuo Cloud ou votre propre serveur.';

  @override
  String get onboarding_intro_title1 => 'Comptage du trafic par IA';

  @override
  String get onboarding_intro_title2 => 'Confidentialité dès la conception';

  @override
  String get onboarding_intro_title3 =>
      'Fonctionne automatiquement 24h/24 et 7j/7';

  @override
  String get onboarding_next_action => 'Suivant';

  @override
  String get onboarding_skip_action => 'Passer l\'introduction';

  @override
  String get onboarding_start_action => 'Démarrer';

  @override
  String get passed_by => 'Passés';

  @override
  String get passed_by_help =>
      'Compte les personnes ou les véhicules qui ont traversé cette zone pendant la fenêtre de comptage en cours.\\n\\nChaque personne ou véhicule n\'est compté qu\'une seule fois par passage dans la zone.';

  @override
  String get payloads_screen_area => 'Zone';

  @override
  String get payloads_screen_confidence => 'Confiance';

  @override
  String get payloads_screen_coverage => 'Couverture';

  @override
  String get payloads_screen_delivered => 'Livré';

  @override
  String get payloads_screen_failed_load =>
      'Échec du chargement des charges récentes';

  @override
  String get payloads_screen_frame_processed => 'Images traitées';

  @override
  String get payloads_screen_hour_not_exists => 'Cette heure n\'existe plus.';

  @override
  String get payloads_screen_missing_time => 'Temps manquant';

  @override
  String get payloads_screen_no_payloads => 'Aucune charge pour le moment.';

  @override
  String get payloads_screen_partial => 'Fenêtre terminée plus tôt (partielle)';

  @override
  String get payloads_screen_partially => 'Livré partiellement';

  @override
  String get payloads_screen_payload_not_exists =>
      'Cette charge n\'existe plus.';

  @override
  String get payloads_screen_pending => 'En attente de livraison';

  @override
  String get payloads_screen_process_fps => 'FPS de traitement';

  @override
  String get payloads_screen_resend => 'Renvoyer';

  @override
  String get payloads_screen_select_first =>
      'Sélectionnez d\'abord au moins une date ou une heure.';

  @override
  String get payloads_screen_subtitle =>
      'Sélectionnez une date ou une heure pour renvoyer';

  @override
  String get payloads_screen_title => 'Charges récentes';

  @override
  String get personal_custom_screen_build_server =>
      'Besoin d\'aide pour configurer votre propre serveur ?\\nConsultez notre documentation API et nos exemples de serveur.';

  @override
  String get personal_custom_screen_help_action =>
      'Ouvrir la documentation API';

  @override
  String get personal_custom_screen_reset_action => 'Recommencer';

  @override
  String get personal_custom_success_screen_help =>
      'Appuyez sur Start ci-dessous pour commencer le comptage.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Les statistiques de trafic sont envoyées automatiquement toutes les heures.\\nVous pouvez aussi les envoyer manuellement depuis l\'écran des journaux d\'envoi.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Votre serveur n\'a pas encore besoin d\'être en ligne.\\nCommencez le comptage dès maintenant. Vous pourrez terminer la configuration et les tests de votre serveur plus tard. Les statistiques de trafic resteront sur cet appareil jusqu\'à leur envoi réussi.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Les statistiques de trafic seront envoyées à';

  @override
  String get personal_custom_success_screen_title => 'Votre serveur est prêt';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Votre URL Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Copier l\'URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copiée';

  @override
  String get piyuo_server_screen_saving_action => 'Enregistrement...';

  @override
  String get piyuo_server_screen_start =>
      'Appuyez sur « Start » ci-dessous pour commencer le comptage.';

  @override
  String get piyuo_server_screen_url_help =>
      'Votre tableau de bord personnel Piyuo Cloud est disponible à cette URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Enregistrez cette URL pour accéder à votre tableau de bord de fréquentation depuis un autre appareil.';

  @override
  String get piyuo_server_screen_use_action => 'Utiliser Piyuo Cloud';

  @override
  String get privacy => 'Politique de confidentialité';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'Comptage de personnes et de véhicules par IA.';

  @override
  String get settings_screen_custom_subtitle =>
      'Envoyez les données de fréquentation directement vers votre serveur ou base de données.';

  @override
  String get settings_screen_custom_title => 'Utiliser un serveur personnalisé';

  @override
  String get settings_screen_data_server_label => 'Serveur de données';

  @override
  String get settings_screen_detection_target => 'Cible de détection';

  @override
  String get settings_screen_language_title => 'Langue';

  @override
  String get settings_screen_local_subtitle =>
      'Stockez les données de fréquentation uniquement sur cet appareil. Rien n\'est téléversé.';

  @override
  String get settings_screen_local_title => 'Appareil local uniquement';

  @override
  String get settings_screen_misc_label => 'Divers';

  @override
  String get settings_screen_object_detection => 'Détection d\'objets';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Stockez vos données de fréquentation dans Piyuo Cloud avec des tableaux de bord et des analyses métier.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Cela supprimera toutes les données et repartira de zéro. Cette action est irréversible.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Réinitialiser toutes les données ?';

  @override
  String get settings_screen_subscription_body =>
      'Gérez votre abonnement et vos informations de facturation';

  @override
  String get settings_screen_subscription_title => 'Abonnement';

  @override
  String get start_screen_about => 'À propos';

  @override
  String get start_screen_server_none =>
      'Les données sont conservées uniquement sur cet appareil';

  @override
  String get start_screen_server_personal =>
      'Les données sont téléversées toutes les heures vers';

  @override
  String get start_screen_settings => 'Paramètres';

  @override
  String get start_screen_upload_logs => 'Téléverser les journaux';

  @override
  String get start_screen_video_sources => 'Sources vidéo';

  @override
  String get stayed => 'Restés';

  @override
  String get stayed_help =>
      'Compte les personnes ou les véhicules restés dans cette zone pendant au moins la durée de présence configurée.\\n\\nLa durée de présence par défaut est de 15 secondes et peut être modifiée dans les paramètres.';

  @override
  String get target_pedestrian => 'Piéton';

  @override
  String get target_pedestrian_help =>
      'Comptez les personnes avec le modèle de détection des piétons';

  @override
  String get target_screen_subtitle =>
      'Choisissez le modèle de détection à utiliser';

  @override
  String get target_vehicle => 'Véhicule';

  @override
  String get target_vehicle_help =>
      'Comptez les voitures et autres véhicules avec le modèle de détection des véhicules';

  @override
  String get telemetry_error_connection_refused =>
      'Impossible de contacter le serveur. Il est peut-être hors ligne en ce moment.';

  @override
  String get telemetry_error_connection_reset =>
      'La connexion a été réinitialisée. Vérifiez votre connexion internet et réessayez.';

  @override
  String get telemetry_error_connection_timeout =>
      'La connexion a mis trop de temps à répondre. Vérifiez votre connexion internet et réessayez.';

  @override
  String get telemetry_error_database_error =>
      'Échec de l\'écriture dans la base de données.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Impossible de trouver l\'adresse du serveur. Vérifiez votre connexion internet ou l\'URL du serveur.';

  @override
  String get telemetry_error_http_error_status =>
      'Le serveur a rejeté la demande. Réessayez plus tard.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Une erreur inattendue est survenue lors de la communication avec le serveur.';

  @override
  String get telemetry_error_invalid_url =>
      'L\'adresse du serveur n\'est pas valide. Vérifiez vos paramètres.';

  @override
  String get telemetry_error_network_error =>
      'Une erreur réseau est survenue. Vérifiez votre connexion internet et réessayez.';

  @override
  String get telemetry_error_socket_error =>
      'Un problème de connexion réseau est survenu. Vérifiez votre connexion internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Un problème est survenu lors de l\'envoi des données. Réessayez.';

  @override
  String get telemetry_error_unknown_error =>
      'Une erreur inattendue est survenue.';

  @override
  String get terms => 'Conditions d\'utilisation';

  @override
  String get upload_screen_attempt_time => 'Heure de la tentative :';

  @override
  String get upload_screen_error => 'Erreur :';

  @override
  String get upload_screen_failed => 'Échec';

  @override
  String get upload_screen_load_error =>
      'Impossible de charger les journaux de téléversement.';

  @override
  String get upload_screen_log_not_exists =>
      'Le journal de téléversement n\'est plus disponible.';

  @override
  String get upload_screen_next => 'Prochain téléversement à ...';

  @override
  String get upload_screen_next_upload_prefix => 'Prochain téléversement à ';

  @override
  String get upload_screen_no_data_server =>
      'Veuillez d\'abord configurer le serveur de données.';

  @override
  String get upload_screen_no_logs =>
      'Aucun journal de téléversement pour le moment.';

  @override
  String get upload_screen_payload_count => 'Nombre de charges';

  @override
  String get upload_screen_payload_count_label => 'Nombre de charges :';

  @override
  String get upload_screen_payload_size => 'Taille de la charge :';

  @override
  String get upload_screen_result => 'Résultat :';

  @override
  String get upload_screen_retry => 'Nombre de tentatives :';

  @override
  String get upload_screen_size_kb => 'Ko';

  @override
  String get upload_screen_success => 'Réussi';

  @override
  String get upload_screen_today => 'Aujourd\'hui';

  @override
  String get upload_screen_upload_now => 'Téléverser maintenant';

  @override
  String get upload_screen_upload_success => 'Téléversement réussi.';

  @override
  String get upload_screen_uploading => 'Téléversement...';

  @override
  String get upload_screen_yesterday => 'Hier';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Les URL RTSP doivent inclure un nom d\'hôte.';

  @override
  String get url_screen_invalid_url_error =>
      'Saisissez une URL valide avec un protocole pris en charge.';

  @override
  String get url_screen_subtitle => 'Veuillez saisir l\'URL du flux en direct';

  @override
  String get url_screen_title => 'URL du flux en direct';

  @override
  String get url_screen_unsupported_scheme_error =>
      'Υποστηρίζονται μόνο URL HTTP';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Veuillez saisir une URL de diffusion en direct.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://exemple.com/flux ou rtsp://exemple.com/flux';

  @override
  String get video_sources_back_camera => 'Caméra arrière';

  @override
  String get video_sources_camera => 'Caméra';

  @override
  String get video_sources_file => 'Fichier';

  @override
  String get video_sources_front_camera => 'Caméra avant';

  @override
  String get video_sources_live_stream => 'URL de flux en direct';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Vous devez autoriser l\'accès à la caméra pour l\'utiliser';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Caméra introuvable';

  @override
  String get video_sources_screen_import_error =>
      'Impossible d\'importer le fichier vidéo.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Allez dans les paramètres et autorisez l\'accès aux photos pour cette application.';

  @override
  String get video_sources_screen_select_camera =>
      'Appuyez pour sélectionner cette caméra';

  @override
  String get video_sources_screen_select_file =>
      'Appuyez pour choisir un fichier';

  @override
  String get video_sources_screen_select_live =>
      'Appuyez pour définir l’URL du flux en direct';

  @override
  String get video_sources_webcam => 'Webcam';
}
