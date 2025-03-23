// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LocalizationFr extends Localization {
  LocalizationFr([String locale = 'fr']) : super(locale);

  @override
  String get product_name => 'Compteur';

  @override
  String get product_desc => 'Utilisation de la vision par ordinateur et de l\'IA pour compter les personnes, véhicules, animaux et plus encore.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de flux en direct';

  @override
  String get video_sources_file => 'Fichier';

  @override
  String get video_sources_camera => 'Caméra';

  @override
  String get video_sources_camera_not_found_title => 'Caméra introuvable';

  @override
  String get video_sources_camera_not_found_message => 'Vous devez autoriser l\'accès à la caméra pour l\'utiliser';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam introuvable';

  @override
  String get video_sources_webcam_not_found_message => 'Veuillez vérifier qu\'une webcam est bien connectée';

  @override
  String get wizard_screen_desc => 'Créez un nouveau projet ci-dessous pour commencer à compter.';

  @override
  String get wizard_screen_new_project_from => 'Nouveau projet à partir de';

  @override
  String get wizard_screen_language => 'Langue';

  @override
  String get wizard_screen_about => 'À propos';

  @override
  String get wizard_screen_open_projects_tip => 'Tous les projets seront automatiquement sauvegardés localement';

  @override
  String get wizard_screen_open_projects => 'Ouvrir un projet existant';

  @override
  String get wizard_screen_email_us => 'Nous contacter';

  @override
  String get language_screen_language => 'Langue';

  @override
  String get project_view_no_videos => 'Aucune source vidéo disponible.';

  @override
  String get about_screen_title => 'À propos';

  @override
  String get about_screen_platform => 'Plateforme';

  @override
  String get about_screen_app_version => 'Version de l\'application';

  @override
  String get about_screen_models => 'Modèles de détection d\'objets';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informations de compilation OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarks des modèles';

  @override
  String get benchmark_screen_recommended => 'Modèle recommandé';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Démarrer le benchmark';

  @override
  String get benchmark_screen_start_failed => 'Échec du démarrage du benchmark, le code d\'erreur est';

  @override
  String get benchmark_screen_models => 'Modèles de détection d\'objets';

  @override
  String get project_screen_title => 'Projet';

  @override
  String get project_screen_exit_confirm_title => 'Confirmer la sortie du projet';

  @override
  String get project_screen_exit_confirm_content => 'Quitter le projet arrêtera le comptage. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get project_screen_exit_button => 'Quitter';

  @override
  String get project_screen_add_video_button => 'Ajouter une source vidéo';

  @override
  String get project_screen_from_desc => 'Nous conservons un enregistrement sur 24 heures, vous pouvez donc consulter n\'importe quelle période nécessaire.';

  @override
  String get project_screen_report_settings => 'Paramètres';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Sélectionnez une plage de filtrage dans la liste ci-dessous';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'L\'heure de fin doit être supérieure à l\'heure de début';

  @override
  String get filter_screen_error_custom => 'Personnalisé';

  @override
  String get filter_screen_error_start => 'Début';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get settings_screen_title => 'Paramètres';

  @override
  String get settings_screen_desc => 'Définissez le nom du projet, les paramètres de détection et la réinitialisation des compteurs.';

  @override
  String get settings_screen_project_id => 'ID du projet';

  @override
  String get settings_screen_project_name => 'Nom du projet';

  @override
  String get settings_screen_project_name_place_holder => '123 Rue Principale ou Avenue du Parc';

  @override
  String get settings_screen_project_error => 'Le nom du projet ne peut pas être vide';

  @override
  String get settings_screen_random_count_button => 'Ajouter des comptages aléatoires';

  @override
  String get settings_screen_reset_count_header => 'Réinitialiser tous les compteurs de ce projet';

  @override
  String get settings_screen_reset_count_button => 'Réinitialiser les compteurs';

  @override
  String get settings_screen_reset_count_content => 'Êtes-vous sûr de vouloir réinitialiser tous les compteurs ?';

  @override
  String get settings_screen_delete_header => 'Supprimer ce projet';

  @override
  String get settings_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer ce projet ?';

  @override
  String get settings_screen_delete_button => 'Supprimer';

  @override
  String get settings_screen_center_point_title => 'Point central sur la cible';

  @override
  String get settings_screen_center_point_desc => 'Le point central aide à déterminer si la cible se trouve dans la zone d\'impact.';

  @override
  String get settings_screen_center_point_button => 'Afficher le point central sur la cible';

  @override
  String get settings_screen_lost_target_title => 'Cible perdue';

  @override
  String get settings_screen_lost_target_desc => 'Lorsque le suivi d\'objet perd une cible, cette option la rend visible. Par défaut, les cibles perdues ne sont pas affichées.';

  @override
  String get settings_screen_lost_target_button => 'Afficher les cibles perdues';

  @override
  String get detection_screen_title => 'Paramètres de détection';

  @override
  String get detection_screen_models => 'Modèles';

  @override
  String get detection_screen_confidence => 'Confiance';

  @override
  String get detection_screen_confidence_desc => 'confiance supérieure à #0 considérée comme une détection valide';

  @override
  String get detection_screen_low => 'Basse';

  @override
  String get detection_screen_high => 'Haute';

  @override
  String get detection_screen_nms => 'Suppression non-maximum';

  @override
  String get detection_screen_nms_desc => '#0 Un seuil NMS plus bas (ex. 30%) supprimera plus agressivement les boîtes qui se chevauchent, tandis qu\'un seuil NMS plus élevé (ex. 0,6) permettra plus de chevauchement';

  @override
  String get detection_screen_match => 'Correspondance';

  @override
  String get detection_screen_match_desc => 'Correspondance supérieure à #0 est considérée comme le même objet.';

  @override
  String get detection_screen_lost => 'Perdu';

  @override
  String get detection_screen_lost_desc => 'L\'objet suivi sera supprimé s\'il est perdu pendant #0';

  @override
  String get detection_screen_consider_valid => 'Considérer valide après';

  @override
  String get detection_screen_consider_valid_desc => 'L\'objet suivi sera considéré valide après #0';

  @override
  String get detection_screen_reset => 'Réinitialiser';

  @override
  String get detection_screen_reset_content => 'Êtes-vous sûr de vouloir réinitialiser les paramètres de détection ?';

  @override
  String get url_screen_title => 'URL du flux en direct';

  @override
  String get url_screen_desc => 'Veuillez saisir l\'URL du flux en direct';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemple.com/flux ou rtsp://exemple.com/flux';

  @override
  String get add_video_screen_title => 'Ajouter une source vidéo';

  @override
  String get add_video_screen_from => 'Ajouter une source vidéo depuis';

  @override
  String get webcam_screen_add_title => 'Ajouter une webcam';

  @override
  String get webcam_screen_edit_title => 'Choisir une webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Caméra frontale';

  @override
  String get camera_screen_back_camera => 'Caméra arrière';

  @override
  String get camera_screen_add_title => 'Ajouter une caméra';

  @override
  String get camera_screen_edit_title => 'Choisir une caméra';

  @override
  String get camera_screen_zoom_level => 'Niveau de zoom';

  @override
  String get video_screen_name_empty => 'Le nom de la vidéo ne peut pas être vide.';

  @override
  String get video_screen_desc => 'Gérer les sources vidéo, ajouter ou modifier les zones de détection.';

  @override
  String get video_screen_video_name => 'Nom de la source vidéo';

  @override
  String get video_screen_edit_placeholder => 'Caméra d\'entrée ou Caméra de parking';

  @override
  String get video_screen_change_file => 'Changer de fichier';

  @override
  String get video_screen_add_zone => 'Ajouter une zone de détection';

  @override
  String get video_screen_zones => 'Zones de détection';

  @override
  String get video_screen_zones_desc => 'Utilisez le glisser-déposer pour ajuster les zones';

  @override
  String get video_screen_tools => 'Outils';

  @override
  String get video_screen_move_bottom => 'Déplacer la zone actuelle vers le bas';

  @override
  String get video_screen_add_point => 'Ajouter un point à la zone actuelle';

  @override
  String get video_screen_remove_point => 'Supprimer un point de la zone actuelle';

  @override
  String get video_screen_playback_speed => 'Vitesse de lecture';

  @override
  String get video_screen_playback_current => 'actuelle : ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Supprimer cette source vidéo';

  @override
  String get video_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette source vidéo ?';

  @override
  String get video_screen_delete_button => 'Supprimer';

  @override
  String get video_screen_sources => 'Configurer la source d\'image, les cibles de détection et les paramètres du modèle.';

  @override
  String get video_screen_targets => 'Cibles de détection';

  @override
  String get video_screen_detection => 'Paramètres du modèle';

  @override
  String get color_screen_title => 'Choisir une couleur';

  @override
  String get zone_screen_desc => 'La zone de détection permet de définir les types d\'objets à détecter et de choisir quels compteurs afficher, comme Détectés, Apparus et Entrés.';

  @override
  String get zone_screen_name_placeholder => 'Nom de la zone, comme Trottoir ou Parking';

  @override
  String get zone_screen_zone_color => 'Couleur de la zone';

  @override
  String get zone_screen_color => 'Couleur';

  @override
  String get zone_screen_delete_header => 'Supprimer cette zone';

  @override
  String get zone_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette zone ?';

  @override
  String get zone_screen_delete_button => 'Supprimer';

  @override
  String get zone_screen_can_not_delete => 'Impossible de supprimer la zone';

  @override
  String get zone_screen_one_zone_required => 'Au moins une zone est requise.';

  @override
  String get zone_screen_zone_name_required => 'Le nom de la zone ne peut pas être vide';

  @override
  String get counter_screen_show_on => 'Afficher à l\'écran';

  @override
  String get counter_screen_enabled => 'Activé';

  @override
  String get counter_screen_reentry_threshold => 'Seuil de réentrée';

  @override
  String get counter_screen_reentry_desc => 'Les objets doivent entrer #0 fois, avec un temps de récupération de #1 secondes entre chaque sortie et réentrée, pour déclencher une réentrée';

  @override
  String get counter_screen_reentry_title => 'Comptage de réentrée';

  @override
  String get counter_screen_cooldown_threshold => 'Seuil de récupération';

  @override
  String get counter_screen_cooldown_desc => 'La réentrée nécessite un temps de récupération de #0 secondes après avoir quitté la zone de détection';

  @override
  String get counter_screen_cooldown_time => 'Temps de récupération';

  @override
  String get counter_screen_cooldown_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_threshold => 'Seuil de stagnation';

  @override
  String get counter_screen_stagnant_desc => 'Les objets immobiles pendant plus de #0 secondes seront considérés comme stagnants';

  @override
  String get counter_screen_stagnant_consider => 'Considérer comme stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Préfixe de description';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffixe de description';

  @override
  String get counter_screen_name_error => 'Le nom du compteur ne peut pas être vide';

  @override
  String get counter_screen_enabled_error => 'Erreur';

  @override
  String get counter_screen_enabled_error_content => 'Vous devez d\'abord activer un autre compteur, puis vous pourrez désactiver celui-ci';

  @override
  String get objects_screen_title => 'Objets';

  @override
  String get objects_screen_desc => 'Choisissez des cibles de détection comme personne, voiture, bus, etc.';

  @override
  String get open_project_screen_title => 'Ouvrir un projet';

  @override
  String get open_project_screen_desc => 'Ouvrez des projets créés précédemment, en ne conservant que les 20 plus récents.';

  @override
  String get open_project_screen_no_project => 'Aucun projet trouvé.';

  @override
  String get default_project_name => 'Projet';

  @override
  String get default_video_name => 'Source vidéo';

  @override
  String get default_zone_name => 'Zone de détection';

  @override
  String get error_oops => 'Oups, quelque chose s\'est mal passé';

  @override
  String get error_content => 'Une erreur inattendue s\'est produite. Souhaitez-vous envoyer un rapport par e-mail ?';

  @override
  String get error_report => 'Nous contacter';

  @override
  String get submit => 'Soumettre';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Afficher résumé à l\'écran';
}

/// The translations for French, as used in Belgium (`fr_BE`).
class LocalizationFrBe extends LocalizationFr {
  LocalizationFrBe(): super('fr_BE');

  @override
  String get product_name => 'Compteur';

  @override
  String get product_desc => 'Utilisez la vision par ordinateur et l\'IA pour compter les personnes, les véhicules, les animaux et plus encore.';

  @override
  String get product_copyright => 'Droits d\'auteur © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de diffusion en direct';

  @override
  String get video_sources_file => 'Fichier';

  @override
  String get video_sources_camera => 'Caméra';

  @override
  String get video_sources_camera_not_found_title => 'Caméra introuvable';

  @override
  String get video_sources_camera_not_found_message => 'Vous devez accorder l\'autorisation d\'accès à la caméra pour l\'utiliser';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam introuvable';

  @override
  String get video_sources_webcam_not_found_message => 'Veuillez vérifier si une webcam est connectée';

  @override
  String get wizard_screen_desc => 'Créez un nouveau projet ci-dessous pour commencer à compter.';

  @override
  String get wizard_screen_new_project_from => 'Nouveau projet à partir de';

  @override
  String get wizard_screen_language => 'Langue';

  @override
  String get wizard_screen_about => 'À propos';

  @override
  String get wizard_screen_open_projects_tip => 'Tous les projets seront automatiquement sauvegardés localement';

  @override
  String get wizard_screen_open_projects => 'Ouvrir un projet existant';

  @override
  String get wizard_screen_email_us => 'Nous envoyer un courriel';

  @override
  String get language_screen_language => 'Langue';

  @override
  String get project_view_no_videos => 'Aucune source vidéo disponible.';

  @override
  String get about_screen_title => 'À propos';

  @override
  String get about_screen_platform => 'Plateforme';

  @override
  String get about_screen_app_version => 'Version de l\'application';

  @override
  String get about_screen_models => 'Modèles de détection d\'objets';

  @override
  String get about_screen_benchmark => 'Test de performance';

  @override
  String get about_screen_opencv_build_info => 'Informations de compilation OpenCV';

  @override
  String get benchmark_screen_title => 'Tests de performance des modèles';

  @override
  String get benchmark_screen_recommended => 'Modèle recommandé';

  @override
  String get benchmark_screen_fps => 'Images par seconde';

  @override
  String get benchmark_screen_start_button => 'Démarrer le test';

  @override
  String get benchmark_screen_start_failed => 'Échec du démarrage du test, le code d\'erreur est';

  @override
  String get benchmark_screen_models => 'Modèles de détection d\'objets';

  @override
  String get project_screen_title => 'Projet';

  @override
  String get project_screen_exit_confirm_title => 'Confirmer la sortie du projet';

  @override
  String get project_screen_exit_confirm_content => 'Quitter le projet arrêtera le comptage. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get project_screen_exit_button => 'Quitter';

  @override
  String get project_screen_add_video_button => 'Ajouter une source vidéo';

  @override
  String get project_screen_from_desc => 'Nous conservons un enregistrement continu de 24 heures, vous permettant de consulter n\'importe quelle tranche horaire.';

  @override
  String get project_screen_report_settings => 'Paramètres';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Sélectionnez une plage de filtrage dans la liste ci-dessous';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'L\'heure de fin doit être postérieure à l\'heure de début';

  @override
  String get filter_screen_error_custom => 'Personnalisé';

  @override
  String get filter_screen_error_start => 'Début';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get settings_screen_title => 'Paramètres';

  @override
  String get settings_screen_desc => 'Définir le nom du projet, les paramètres de détection, et la remise à zéro des compteurs.';

  @override
  String get settings_screen_project_id => 'ID du projet';

  @override
  String get settings_screen_project_name => 'Nom du projet';

  @override
  String get settings_screen_project_name_place_holder => '123 Rue de la Loi ou Place du Grand Sablon';

  @override
  String get settings_screen_project_error => 'Le nom du projet ne peut pas être vide';

  @override
  String get settings_screen_random_count_button => 'Ajouter des comptages aléatoires';

  @override
  String get settings_screen_reset_count_header => 'Réinitialiser tous les comptages de ce projet';

  @override
  String get settings_screen_reset_count_button => 'Réinitialiser les comptages';

  @override
  String get settings_screen_reset_count_content => 'Êtes-vous sûr de vouloir réinitialiser tous les comptages ?';

  @override
  String get settings_screen_delete_header => 'Supprimer ce projet';

  @override
  String get settings_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer ce projet ?';

  @override
  String get settings_screen_delete_button => 'Supprimer';

  @override
  String get settings_screen_center_point_title => 'Point central sur la cible';

  @override
  String get settings_screen_center_point_desc => 'Le point central aide à déterminer si la cible se trouve dans la zone de détection.';

  @override
  String get settings_screen_center_point_button => 'Afficher le point central sur la cible';

  @override
  String get settings_screen_lost_target_title => 'Cible perdue';

  @override
  String get settings_screen_lost_target_desc => 'Lorsque le suivi d\'objet perd une cible, cette option la rend visible. Par défaut, les cibles perdues ne sont pas affichées.';

  @override
  String get settings_screen_lost_target_button => 'Afficher les cibles perdues';

  @override
  String get detection_screen_title => 'Paramètres de détection';

  @override
  String get detection_screen_models => 'Modèles';

  @override
  String get detection_screen_confidence => 'Confiance';

  @override
  String get detection_screen_confidence_desc => 'une confiance supérieure à #0 est considérée comme une détection valide';

  @override
  String get detection_screen_low => 'Faible';

  @override
  String get detection_screen_high => 'Élevé';

  @override
  String get detection_screen_nms => 'Suppression des non-maximums';

  @override
  String get detection_screen_nms_desc => '#0 Un seuil NMS plus bas (par ex. 30%) supprimera plus agressivement les boîtes englobantes qui se chevauchent, tandis qu\'un seuil NMS plus élevé (par ex. 0,6) permettra plus de chevauchement';

  @override
  String get detection_screen_match => 'Correspondance';

  @override
  String get detection_screen_match_desc => 'Une correspondance supérieure à #0 est considérée comme le même objet.';

  @override
  String get detection_screen_lost => 'Perdu';

  @override
  String get detection_screen_lost_desc => 'L\'objet suivi sera supprimé s\'il est perdu pendant #0';

  @override
  String get detection_screen_consider_valid => 'Considérer comme valide après';

  @override
  String get detection_screen_consider_valid_desc => 'L\'objet suivi sera considéré comme valide après #0';

  @override
  String get detection_screen_reset => 'Réinitialiser';

  @override
  String get detection_screen_reset_content => 'Êtes-vous sûr de vouloir réinitialiser les paramètres de détection ?';

  @override
  String get url_screen_title => 'URL de diffusion en direct';

  @override
  String get url_screen_desc => 'Veuillez entrer l\'URL de diffusion en direct';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemple.com/stream ou rtsp://exemple.com/stream';

  @override
  String get add_video_screen_title => 'Ajouter une source vidéo';

  @override
  String get add_video_screen_from => 'Ajouter une source vidéo à partir de';

  @override
  String get webcam_screen_add_title => 'Ajouter une webcam';

  @override
  String get webcam_screen_edit_title => 'Choisir une webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Caméra frontale';

  @override
  String get camera_screen_back_camera => 'Caméra arrière';

  @override
  String get camera_screen_add_title => 'Ajouter une caméra';

  @override
  String get camera_screen_edit_title => 'Choisir une caméra';

  @override
  String get camera_screen_zoom_level => 'Niveau de zoom';

  @override
  String get video_screen_name_empty => 'Le nom de la vidéo ne peut pas être vide.';

  @override
  String get video_screen_desc => 'Gérer les sources vidéo, ajouter ou modifier les zones de détection.';

  @override
  String get video_screen_video_name => 'Nom de la source vidéo';

  @override
  String get video_screen_edit_placeholder => 'Caméra de l\'entrée ou Caméra du parking';

  @override
  String get video_screen_change_file => 'Changer de fichier';

  @override
  String get video_screen_add_zone => 'Ajouter une zone de détection';

  @override
  String get video_screen_zones => 'Zones de détection';

  @override
  String get video_screen_zones_desc => 'Utilisez le glisser-déposer pour ajuster les zones';

  @override
  String get video_screen_tools => 'Outils';

  @override
  String get video_screen_move_bottom => 'Déplacer la zone actuelle vers le bas';

  @override
  String get video_screen_add_point => 'Ajouter un point à la zone actuelle';

  @override
  String get video_screen_remove_point => 'Supprimer un point de la zone actuelle';

  @override
  String get video_screen_playback_speed => 'Vitesse de lecture';

  @override
  String get video_screen_playback_current => 'actuelle : ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Supprimer cette source vidéo';

  @override
  String get video_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette source vidéo ?';

  @override
  String get video_screen_delete_button => 'Supprimer';

  @override
  String get video_screen_sources => 'Configurer la source d\'image, les cibles de détection et les paramètres du modèle.';

  @override
  String get video_screen_targets => 'Cibles de détection';

  @override
  String get video_screen_detection => 'Paramètres du modèle';

  @override
  String get color_screen_title => 'Choisir une couleur';

  @override
  String get zone_screen_desc => 'La zone de détection peut définir les types d\'objets à détecter et choisir quels compteurs afficher, comme Détectés, Apparus et Entrés.';

  @override
  String get zone_screen_name_placeholder => 'Nom de la zone, comme Trottoir ou Parking';

  @override
  String get zone_screen_zone_color => 'Couleur de la zone';

  @override
  String get zone_screen_color => 'Couleur';

  @override
  String get zone_screen_delete_header => 'Supprimer cette zone';

  @override
  String get zone_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette zone ?';

  @override
  String get zone_screen_delete_button => 'Supprimer';

  @override
  String get zone_screen_can_not_delete => 'Impossible de supprimer la zone';

  @override
  String get zone_screen_one_zone_required => 'Au moins une zone est requise.';

  @override
  String get zone_screen_zone_name_required => 'Le nom de la zone ne peut pas être vide';

  @override
  String get counter_screen_show_on => 'Afficher à l\'écran';

  @override
  String get counter_screen_enabled => 'Activé';

  @override
  String get counter_screen_reentry_threshold => 'Seuil de réentrée';

  @override
  String get counter_screen_reentry_desc => 'Les objets doivent entrer #0 fois, avec un temps de récupération de #1 secondes entre chaque sortie et réentrée, pour déclencher une réentrée';

  @override
  String get counter_screen_reentry_title => 'Comptage de réentrée';

  @override
  String get counter_screen_cooldown_threshold => 'Seuil de récupération';

  @override
  String get counter_screen_cooldown_desc => 'La réentrée nécessite un temps de récupération de #0 secondes après avoir quitté la zone de détection';

  @override
  String get counter_screen_cooldown_time => 'Temps de récupération';

  @override
  String get counter_screen_cooldown_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_threshold => 'Seuil de stagnation';

  @override
  String get counter_screen_stagnant_desc => 'Les objets immobiles pendant plus de #0 secondes seront considérés comme stagnants';

  @override
  String get counter_screen_stagnant_consider => 'Considérer comme stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Préfixe de description';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffixe de description';

  @override
  String get counter_screen_name_error => 'Le nom du compteur ne peut pas être vide';

  @override
  String get counter_screen_enabled_error => 'Erreur';

  @override
  String get counter_screen_enabled_error_content => 'Vous devez d\'abord activer un autre compteur, puis vous pourrez désactiver celui-ci';

  @override
  String get objects_screen_title => 'Objets';

  @override
  String get objects_screen_desc => 'Choisissez des cibles de détection comme personne, voiture, bus, etc.';

  @override
  String get open_project_screen_title => 'Ouvrir un projet';

  @override
  String get open_project_screen_desc => 'Ouvrez des projets créés précédemment, en ne conservant que les 20 plus récents.';

  @override
  String get open_project_screen_no_project => 'Aucun projet trouvé.';

  @override
  String get default_project_name => 'Projet';

  @override
  String get default_video_name => 'Source vidéo';

  @override
  String get default_zone_name => 'Zone de détection';

  @override
  String get error_oops => 'Oups, quelque chose s\'est mal passé';

  @override
  String get error_content => 'Une erreur inattendue s\'est produite. Voulez-vous envoyer un rapport par courriel ?';

  @override
  String get error_report => 'Nous envoyer un courriel';

  @override
  String get submit => 'Soumettre';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Afficher résumé à l\'écran';
}

/// The translations for French, as used in Canada (`fr_CA`).
class LocalizationFrCa extends LocalizationFr {
  LocalizationFrCa(): super('fr_CA');

  @override
  String get product_name => 'Compteur';

  @override
  String get product_desc => 'Utilisez la vision par ordinateur et l\'IA pour compter les personnes, véhicules, animaux et plus encore.';

  @override
  String get product_copyright => 'Tous droits réservés © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de diffusion en direct';

  @override
  String get video_sources_file => 'Fichier';

  @override
  String get video_sources_camera => 'Caméra';

  @override
  String get video_sources_camera_not_found_title => 'Caméra introuvable';

  @override
  String get video_sources_camera_not_found_message => 'Vous devez accorder la permission d\'accéder à la caméra';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam introuvable';

  @override
  String get video_sources_webcam_not_found_message => 'Veuillez vérifier si une webcam est connectée';

  @override
  String get wizard_screen_desc => 'Créez un nouveau projet ci-dessous pour commencer à compter.';

  @override
  String get wizard_screen_new_project_from => 'Nouveau projet à partir de';

  @override
  String get wizard_screen_language => 'Langue';

  @override
  String get wizard_screen_about => 'À propos';

  @override
  String get wizard_screen_open_projects_tip => 'Tous les projets seront enregistrés automatiquement en local';

  @override
  String get wizard_screen_open_projects => 'Ouvrir un projet existant';

  @override
  String get wizard_screen_email_us => 'Nous contacter';

  @override
  String get language_screen_language => 'Langue';

  @override
  String get project_view_no_videos => 'Aucune source vidéo disponible.';

  @override
  String get about_screen_title => 'À propos';

  @override
  String get about_screen_platform => 'Plateforme';

  @override
  String get about_screen_app_version => 'Version de l\'application';

  @override
  String get about_screen_models => 'Modèles de détection d\'objets';

  @override
  String get about_screen_benchmark => 'Test de performance';

  @override
  String get about_screen_opencv_build_info => 'Informations de compilation OpenCV';

  @override
  String get benchmark_screen_title => 'Tests de performance des modèles';

  @override
  String get benchmark_screen_recommended => 'Modèle recommandé';

  @override
  String get benchmark_screen_fps => 'IPS';

  @override
  String get benchmark_screen_start_button => 'Démarrer le test';

  @override
  String get benchmark_screen_start_failed => 'Échec du démarrage du test, le code d\'erreur est';

  @override
  String get benchmark_screen_models => 'Modèles de détection d\'objets';

  @override
  String get project_screen_title => 'Projet';

  @override
  String get project_screen_exit_confirm_title => 'Confirmer la sortie du projet';

  @override
  String get project_screen_exit_confirm_content => 'Quitter le projet arrêtera le comptage. Êtes-vous sûr de vouloir continuer?';

  @override
  String get project_screen_exit_button => 'Quitter';

  @override
  String get project_screen_add_video_button => 'Ajouter une source vidéo';

  @override
  String get project_screen_from_desc => 'Nous conservons un enregistrement sur 24 heures, vous pouvez donc consulter n\'importe quelle période dont vous avez besoin.';

  @override
  String get project_screen_report_settings => 'Paramètres';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Sélectionnez une plage de filtrage dans la liste ci-dessous';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'L\'heure de fin doit être supérieure à l\'heure de début';

  @override
  String get filter_screen_error_custom => 'Personnalisé';

  @override
  String get filter_screen_error_start => 'Début';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get settings_screen_title => 'Paramètres';

  @override
  String get settings_screen_desc => 'Définissez le nom du projet, les paramètres de détection et la réinitialisation des compteurs.';

  @override
  String get settings_screen_project_id => 'ID du projet';

  @override
  String get settings_screen_project_name => 'Nom du projet';

  @override
  String get settings_screen_project_name_place_holder => '123 rue Principale ou Parc du Vieux-Port';

  @override
  String get settings_screen_project_error => 'Le nom du projet ne peut pas être vide';

  @override
  String get settings_screen_random_count_button => 'Ajouter des comptages aléatoires';

  @override
  String get settings_screen_reset_count_header => 'Réinitialiser tous les comptages de ce projet';

  @override
  String get settings_screen_reset_count_button => 'Réinitialiser les comptages';

  @override
  String get settings_screen_reset_count_content => 'Êtes-vous sûr de vouloir réinitialiser tous les comptages?';

  @override
  String get settings_screen_delete_header => 'Supprimer ce projet';

  @override
  String get settings_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer ce projet?';

  @override
  String get settings_screen_delete_button => 'Supprimer';

  @override
  String get settings_screen_center_point_title => 'Point central sur la cible';

  @override
  String get settings_screen_center_point_desc => 'Le point central aide à déterminer si la cible est dans la zone de détection.';

  @override
  String get settings_screen_center_point_button => 'Afficher le point central sur la cible';

  @override
  String get settings_screen_lost_target_title => 'Cible perdue';

  @override
  String get settings_screen_lost_target_desc => 'Quand le suivi d\'objets perd une cible, cette option la rend visible. Par défaut, les cibles perdues ne sont pas affichées.';

  @override
  String get settings_screen_lost_target_button => 'Afficher les cibles perdues';

  @override
  String get detection_screen_title => 'Paramètres de détection';

  @override
  String get detection_screen_models => 'Modèles';

  @override
  String get detection_screen_confidence => 'Confiance';

  @override
  String get detection_screen_confidence_desc => 'confiance supérieure à #0 considérée comme une détection valide';

  @override
  String get detection_screen_low => 'Faible';

  @override
  String get detection_screen_high => 'Élevé';

  @override
  String get detection_screen_nms => 'Suppression non-maximale';

  @override
  String get detection_screen_nms_desc => '#0 Un seuil NMS plus bas (ex: 30%) supprimera plus agressivement les boîtes qui se chevauchent, tandis qu\'un seuil NMS plus élevé (ex: 0,6) permettra plus de chevauchement';

  @override
  String get detection_screen_match => 'Correspondance';

  @override
  String get detection_screen_match_desc => 'Correspondance supérieure à #0 est considérée comme le même objet.';

  @override
  String get detection_screen_lost => 'Perdu';

  @override
  String get detection_screen_lost_desc => 'L\'objet suivi sera supprimé s\'il est perdu pendant #0';

  @override
  String get detection_screen_consider_valid => 'Considérer valide après';

  @override
  String get detection_screen_consider_valid_desc => 'L\'objet suivi sera considéré valide après #0';

  @override
  String get detection_screen_reset => 'Réinitialiser';

  @override
  String get detection_screen_reset_content => 'Êtes-vous sûr de vouloir réinitialiser les paramètres de détection?';

  @override
  String get url_screen_title => 'URL de diffusion en direct';

  @override
  String get url_screen_desc => 'Veuillez entrer l\'URL de diffusion en direct';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemple.com/flux ou rtsp://exemple.com/flux';

  @override
  String get add_video_screen_title => 'Ajouter une source vidéo';

  @override
  String get add_video_screen_from => 'Ajouter une source vidéo à partir de';

  @override
  String get webcam_screen_add_title => 'Ajouter une webcam';

  @override
  String get webcam_screen_edit_title => 'Choisir une webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Caméra avant';

  @override
  String get camera_screen_back_camera => 'Caméra arrière';

  @override
  String get camera_screen_add_title => 'Ajouter une caméra';

  @override
  String get camera_screen_edit_title => 'Choisir une caméra';

  @override
  String get camera_screen_zoom_level => 'Niveau de zoom';

  @override
  String get video_screen_name_empty => 'Le nom de la vidéo ne peut pas être vide.';

  @override
  String get video_screen_desc => 'Gérez les sources vidéo, ajoutez ou modifiez les zones de détection.';

  @override
  String get video_screen_video_name => 'Nom de la source vidéo';

  @override
  String get video_screen_edit_placeholder => 'Caméra de l\'entrée ou Caméra du stationnement';

  @override
  String get video_screen_change_file => 'Changer de fichier';

  @override
  String get video_screen_add_zone => 'Ajouter une zone de détection';

  @override
  String get video_screen_zones => 'Zones de détection';

  @override
  String get video_screen_zones_desc => 'Utilisez le glisser-déposer pour ajuster les zones';

  @override
  String get video_screen_tools => 'Outils';

  @override
  String get video_screen_move_bottom => 'Déplacer la zone actuelle vers le bas';

  @override
  String get video_screen_add_point => 'Ajouter un point à la zone actuelle';

  @override
  String get video_screen_remove_point => 'Supprimer un point de la zone actuelle';

  @override
  String get video_screen_playback_speed => 'Vitesse de lecture';

  @override
  String get video_screen_playback_current => 'actuel: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Supprimer cette source vidéo';

  @override
  String get video_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette source vidéo?';

  @override
  String get video_screen_delete_button => 'Supprimer';

  @override
  String get video_screen_sources => 'Configurer la source d\'image, les cibles de détection et les paramètres du modèle.';

  @override
  String get video_screen_targets => 'Cibles de détection';

  @override
  String get video_screen_detection => 'Paramètres du modèle';

  @override
  String get color_screen_title => 'Choisir une couleur';

  @override
  String get zone_screen_desc => 'La zone de détection peut définir les types d\'objets à détecter et choisir quels compteurs afficher, comme Détectés, Apparus et Entrés.';

  @override
  String get zone_screen_name_placeholder => 'Nom de la zone, comme Trottoir ou Stationnement';

  @override
  String get zone_screen_zone_color => 'Couleur de la zone';

  @override
  String get zone_screen_color => 'Couleur';

  @override
  String get zone_screen_delete_header => 'Supprimer cette zone';

  @override
  String get zone_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette zone?';

  @override
  String get zone_screen_delete_button => 'Supprimer';

  @override
  String get zone_screen_can_not_delete => 'Impossible de supprimer la zone';

  @override
  String get zone_screen_one_zone_required => 'Au moins une zone est requise.';

  @override
  String get zone_screen_zone_name_required => 'Le nom de la zone ne peut pas être vide';

  @override
  String get counter_screen_show_on => 'Afficher à l\'écran';

  @override
  String get counter_screen_enabled => 'Activé';

  @override
  String get counter_screen_reentry_threshold => 'Seuil de ré-entrée';

  @override
  String get counter_screen_reentry_desc => 'Les objets doivent entrer #0 fois, avec un temps de refroidissement de #1 secondes entre chaque sortie et ré-entrée, pour déclencher une ré-entrée';

  @override
  String get counter_screen_reentry_title => 'Comptage de ré-entrée';

  @override
  String get counter_screen_cooldown_threshold => 'Seuil de refroidissement';

  @override
  String get counter_screen_cooldown_desc => 'La ré-entrée nécessite un refroidissement de #0 secondes après avoir quitté la zone de détection';

  @override
  String get counter_screen_cooldown_time => 'Temps de refroidissement';

  @override
  String get counter_screen_cooldown_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_threshold => 'Seuil de stagnation';

  @override
  String get counter_screen_stagnant_desc => 'Les objets restant immobiles pendant plus de #0 secondes seront considérés comme stagnants';

  @override
  String get counter_screen_stagnant_consider => 'Considérer comme stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Préfixe de description';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffixe de description';

  @override
  String get counter_screen_name_error => 'Le nom du compteur ne peut pas être vide';

  @override
  String get counter_screen_enabled_error => 'Erreur';

  @override
  String get counter_screen_enabled_error_content => 'Vous devez d\'abord activer un autre compteur, puis vous pourrez désactiver celui-ci';

  @override
  String get objects_screen_title => 'Objets';

  @override
  String get objects_screen_desc => 'Choisissez des cibles de détection comme personne, voiture, autobus, etc.';

  @override
  String get open_project_screen_title => 'Ouvrir un projet';

  @override
  String get open_project_screen_desc => 'Ouvrez des projets créés précédemment, en conservant uniquement les 20 plus récents.';

  @override
  String get open_project_screen_no_project => 'Aucun projet trouvé.';

  @override
  String get default_project_name => 'Projet';

  @override
  String get default_video_name => 'Source vidéo';

  @override
  String get default_zone_name => 'Zone de détection';

  @override
  String get error_oops => 'Oups, quelque chose s\'est mal passé';

  @override
  String get error_content => 'Une erreur inattendue s\'est produite. Souhaitez-vous envoyer un rapport par courriel?';

  @override
  String get error_report => 'Nous contacter';

  @override
  String get submit => 'Soumettre';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Afficher résumé à l\'écran';
}

/// The translations for French, as used in Switzerland (`fr_CH`).
class LocalizationFrCh extends LocalizationFr {
  LocalizationFrCh(): super('fr_CH');

  @override
  String get product_name => 'Compteur';

  @override
  String get product_desc => 'Utilise la vision par ordinateur et l\'IA pour compter les personnes, véhicules, animaux et plus encore.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de flux en direct';

  @override
  String get video_sources_file => 'Fichier';

  @override
  String get video_sources_camera => 'Caméra';

  @override
  String get video_sources_camera_not_found_title => 'Caméra introuvable';

  @override
  String get video_sources_camera_not_found_message => 'Veuillez accorder l\'autorisation d\'accès à la caméra pour l\'utiliser';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam introuvable';

  @override
  String get video_sources_webcam_not_found_message => 'Veuillez vérifier si une webcam est connectée';

  @override
  String get wizard_screen_desc => 'Créez un nouveau projet ci-dessous pour commencer le comptage.';

  @override
  String get wizard_screen_new_project_from => 'Nouveau projet depuis';

  @override
  String get wizard_screen_language => 'Langue';

  @override
  String get wizard_screen_about => 'À propos';

  @override
  String get wizard_screen_open_projects_tip => 'Tous les projets seront sauvegardés automatiquement en local';

  @override
  String get wizard_screen_open_projects => 'Ouvrir un projet existant';

  @override
  String get wizard_screen_email_us => 'Nous contacter';

  @override
  String get language_screen_language => 'Langue';

  @override
  String get project_view_no_videos => 'Aucune source vidéo disponible.';

  @override
  String get about_screen_title => 'À propos';

  @override
  String get about_screen_platform => 'Plateforme';

  @override
  String get about_screen_app_version => 'Version de l\'application';

  @override
  String get about_screen_models => 'Modèles de détection d\'objets';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informations de compilation OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarks des modèles';

  @override
  String get benchmark_screen_recommended => 'Modèle recommandé';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Démarrer le benchmark';

  @override
  String get benchmark_screen_start_failed => 'Échec du démarrage du benchmark, le code d\'erreur est';

  @override
  String get benchmark_screen_models => 'Modèles de détection d\'objets';

  @override
  String get project_screen_title => 'Projet';

  @override
  String get project_screen_exit_confirm_title => 'Confirmer la sortie du projet';

  @override
  String get project_screen_exit_confirm_content => 'Quitter le projet arrêtera le comptage. Êtes-vous sûr de vouloir continuer?';

  @override
  String get project_screen_exit_button => 'Quitter';

  @override
  String get project_screen_add_video_button => 'Ajouter une source vidéo';

  @override
  String get project_screen_from_desc => 'Nous conservons un enregistrement continu sur 24 heures, vous pouvez donc consulter n\'importe quelle période nécessaire.';

  @override
  String get project_screen_report_settings => 'Paramètres';

  @override
  String get filter_screen_title => 'Filtre';

  @override
  String get filter_screen_desc => 'Sélectionnez une plage de filtrage dans la liste ci-dessous';

  @override
  String get filter_screen_error_title => 'Filtre';

  @override
  String get filter_screen_error_content => 'L\'heure de fin doit être postérieure à l\'heure de début';

  @override
  String get filter_screen_error_custom => 'Personnalisé';

  @override
  String get filter_screen_error_start => 'Début';

  @override
  String get filter_screen_error_end => 'Fin';

  @override
  String get settings_screen_title => 'Paramètres';

  @override
  String get settings_screen_desc => 'Définir le nom du projet, les paramètres de détection, la remise à zéro des compteurs.';

  @override
  String get settings_screen_project_id => 'ID du projet';

  @override
  String get settings_screen_project_name => 'Nom du projet';

  @override
  String get settings_screen_project_name_place_holder => '123 Rue du Rhône ou Parc des Bastions';

  @override
  String get settings_screen_project_error => 'Le nom du projet ne peut pas être vide';

  @override
  String get settings_screen_random_count_button => 'Ajouter des comptages aléatoires';

  @override
  String get settings_screen_reset_count_header => 'Réinitialiser tous les comptages de ce projet';

  @override
  String get settings_screen_reset_count_button => 'Réinitialiser les comptages';

  @override
  String get settings_screen_reset_count_content => 'Êtes-vous sûr de vouloir réinitialiser tous les comptages?';

  @override
  String get settings_screen_delete_header => 'Supprimer ce projet';

  @override
  String get settings_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer ce projet?';

  @override
  String get settings_screen_delete_button => 'Supprimer';

  @override
  String get settings_screen_center_point_title => 'Point central sur la cible';

  @override
  String get settings_screen_center_point_desc => 'Le point central aide à déterminer si la cible se trouve dans la zone de détection.';

  @override
  String get settings_screen_center_point_button => 'Afficher le point central sur la cible';

  @override
  String get settings_screen_lost_target_title => 'Cible perdue';

  @override
  String get settings_screen_lost_target_desc => 'Lorsque le suivi d\'objet perd une cible, cette option la rend visible. Par défaut, les cibles perdues ne sont pas affichées.';

  @override
  String get settings_screen_lost_target_button => 'Afficher les cibles perdues';

  @override
  String get detection_screen_title => 'Paramètres de détection';

  @override
  String get detection_screen_models => 'Modèles';

  @override
  String get detection_screen_confidence => 'Confiance';

  @override
  String get detection_screen_confidence_desc => 'confiance supérieure à #0 considérée comme une détection valide';

  @override
  String get detection_screen_low => 'Basse';

  @override
  String get detection_screen_high => 'Haute';

  @override
  String get detection_screen_nms => 'Suppression non-maximale';

  @override
  String get detection_screen_nms_desc => '#0 Un seuil NMS plus bas (par ex. 30%) supprimera plus agressivement les boîtes englobantes qui se chevauchent, tandis qu\'un seuil NMS plus élevé (par ex. 0,6) permettra plus de chevauchement';

  @override
  String get detection_screen_match => 'Correspondance';

  @override
  String get detection_screen_match_desc => 'Correspondance supérieure à #0 est considérée comme le même objet.';

  @override
  String get detection_screen_lost => 'Perdu';

  @override
  String get detection_screen_lost_desc => 'L\'objet suivi sera supprimé s\'il est perdu pendant #0';

  @override
  String get detection_screen_consider_valid => 'Considérer comme valide après';

  @override
  String get detection_screen_consider_valid_desc => 'L\'objet suivi sera considéré comme valide après #0';

  @override
  String get detection_screen_reset => 'Réinitialiser';

  @override
  String get detection_screen_reset_content => 'Êtes-vous sûr de vouloir réinitialiser les paramètres de détection?';

  @override
  String get url_screen_title => 'URL de flux en direct';

  @override
  String get url_screen_desc => 'Veuillez saisir l\'URL du flux en direct';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemple.com/flux ou rtsp://exemple.com/flux';

  @override
  String get add_video_screen_title => 'Ajouter une source vidéo';

  @override
  String get add_video_screen_from => 'Ajouter une source vidéo depuis';

  @override
  String get webcam_screen_add_title => 'Ajouter une webcam';

  @override
  String get webcam_screen_edit_title => 'Choisir une webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Caméra frontale';

  @override
  String get camera_screen_back_camera => 'Caméra arrière';

  @override
  String get camera_screen_add_title => 'Ajouter une caméra';

  @override
  String get camera_screen_edit_title => 'Choisir une caméra';

  @override
  String get camera_screen_zoom_level => 'Niveau de zoom';

  @override
  String get video_screen_name_empty => 'Le nom de la vidéo ne peut pas être vide.';

  @override
  String get video_screen_desc => 'Gérer les sources vidéo, ajouter ou modifier les zones de détection.';

  @override
  String get video_screen_video_name => 'Nom de la source vidéo';

  @override
  String get video_screen_edit_placeholder => 'Caméra d\'entrée ou Caméra du parking';

  @override
  String get video_screen_change_file => 'Changer de fichier';

  @override
  String get video_screen_add_zone => 'Ajouter une zone de détection';

  @override
  String get video_screen_zones => 'Zones de détection';

  @override
  String get video_screen_zones_desc => 'Utilisez le glisser-déposer pour ajuster les zones';

  @override
  String get video_screen_tools => 'Outils';

  @override
  String get video_screen_move_bottom => 'Déplacer la zone actuelle vers le bas';

  @override
  String get video_screen_add_point => 'Ajouter un point à la zone actuelle';

  @override
  String get video_screen_remove_point => 'Supprimer un point de la zone actuelle';

  @override
  String get video_screen_playback_speed => 'Vitesse de lecture';

  @override
  String get video_screen_playback_current => 'actuel: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Supprimer cette source vidéo';

  @override
  String get video_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette source vidéo?';

  @override
  String get video_screen_delete_button => 'Supprimer';

  @override
  String get video_screen_sources => 'Configurer la source d\'image, les cibles de détection et les paramètres du modèle.';

  @override
  String get video_screen_targets => 'Cibles de détection';

  @override
  String get video_screen_detection => 'Paramètres du modèle';

  @override
  String get color_screen_title => 'Choisir une couleur';

  @override
  String get zone_screen_desc => 'La zone de détection peut définir les types d\'objets à détecter et choisir quels compteurs afficher, comme Détectés, Apparus et Entrés.';

  @override
  String get zone_screen_name_placeholder => 'Nom de la zone, comme Trottoir ou Parking';

  @override
  String get zone_screen_zone_color => 'Couleur de la zone';

  @override
  String get zone_screen_color => 'Couleur';

  @override
  String get zone_screen_delete_header => 'Supprimer cette zone';

  @override
  String get zone_screen_delete_content => 'Êtes-vous sûr de vouloir supprimer cette zone?';

  @override
  String get zone_screen_delete_button => 'Supprimer';

  @override
  String get zone_screen_can_not_delete => 'Impossible de supprimer la zone';

  @override
  String get zone_screen_one_zone_required => 'Au moins une zone est requise.';

  @override
  String get zone_screen_zone_name_required => 'Le nom de la zone ne peut pas être vide';

  @override
  String get counter_screen_show_on => 'Afficher à l\'écran';

  @override
  String get counter_screen_enabled => 'Activé';

  @override
  String get counter_screen_reentry_threshold => 'Seuil de ré-entrée';

  @override
  String get counter_screen_reentry_desc => 'Les objets doivent entrer #0 fois, avec un temps de récupération de #1 secondes entre chaque sortie et ré-entrée, pour déclencher une ré-entrée';

  @override
  String get counter_screen_reentry_title => 'Comptage des ré-entrées';

  @override
  String get counter_screen_cooldown_threshold => 'Seuil de récupération';

  @override
  String get counter_screen_cooldown_desc => 'La ré-entrée nécessite un temps de récupération de #0 secondes après avoir quitté la zone de détection';

  @override
  String get counter_screen_cooldown_time => 'Temps de récupération';

  @override
  String get counter_screen_cooldown_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_threshold => 'Seuil de stagnation';

  @override
  String get counter_screen_stagnant_desc => 'Les objets immobiles pendant plus de #0 secondes seront considérés comme stagnants';

  @override
  String get counter_screen_stagnant_consider => 'Considérer comme stagnant';

  @override
  String get counter_screen_stagnant_in_seconds => 'en secondes';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Préfixe de description';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Suffixe de description';

  @override
  String get counter_screen_name_error => 'Le nom du compteur ne peut pas être vide';

  @override
  String get counter_screen_enabled_error => 'Erreur';

  @override
  String get counter_screen_enabled_error_content => 'Vous devez d\'abord activer un autre compteur, puis vous pourrez désactiver celui-ci';

  @override
  String get objects_screen_title => 'Objets';

  @override
  String get objects_screen_desc => 'Choisissez des cibles de détection comme personne, voiture, bus, etc.';

  @override
  String get open_project_screen_title => 'Ouvrir un projet';

  @override
  String get open_project_screen_desc => 'Ouvrez des projets créés précédemment, en ne conservant que les 20 plus récents.';

  @override
  String get open_project_screen_no_project => 'Aucun projet trouvé.';

  @override
  String get default_project_name => 'Projet';

  @override
  String get default_video_name => 'Source vidéo';

  @override
  String get default_zone_name => 'Zone de détection';

  @override
  String get error_oops => 'Oups, quelque chose s\'est mal passé';

  @override
  String get error_content => 'Une erreur inattendue s\'est produite. Souhaitez-vous envoyer un rapport par e-mail?';

  @override
  String get error_report => 'Nous contacter';

  @override
  String get submit => 'Soumettre';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Zone';

  @override
  String get zone_screen_zone_show_summary => 'Afficher résumé à l\'écran';
}
