// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class LocalizationEl extends Localization {
  LocalizationEl([String locale = 'el']) : super(locale);

  @override
  String get product_name => 'Μετρητής';

  @override
  String get product_desc => 'Χρησιμοποιεί υπολογιστική όραση και τεχνητή νοημοσύνη για να μετρά ανθρώπους, οχήματα, κατοικίδια και άλλα.';

  @override
  String get product_copyright => 'Πνευματικά δικαιώματα © 2025';

  @override
  String get video_sources_webcam => 'Κάμερα web';

  @override
  String get video_sources_live_stream => 'URL ζωντανής ροής';

  @override
  String get video_sources_file => 'Αρχείο';

  @override
  String get video_sources_camera => 'Κάμερα';

  @override
  String get video_sources_camera_not_found_title => 'Η κάμερα δεν βρέθηκε';

  @override
  String get video_sources_camera_not_found_message => 'Χρειάζεται να παραχωρήσετε άδεια κάμερας για τη χρήση της';

  @override
  String get video_sources_webcam_not_found_title => 'Η κάμερα web δεν βρέθηκε';

  @override
  String get video_sources_webcam_not_found_message => 'Παρακαλώ ελέγξτε αν είναι συνδεδεμένη κάποια κάμερα web';

  @override
  String get wizard_screen_desc => 'Δημιουργήστε ένα νέο έργο παρακάτω για να ξεκινήσετε τη μέτρηση.';

  @override
  String get wizard_screen_new_project_from => 'Νέο Έργο από';

  @override
  String get wizard_screen_language => 'Γλώσσα';

  @override
  String get wizard_screen_about => 'Σχετικά';

  @override
  String get wizard_screen_open_projects_tip => 'Όλα τα έργα θα αποθηκευτούν αυτόματα τοπικά';

  @override
  String get wizard_screen_open_projects => 'Άνοιγμα υπάρχοντος έργου';

  @override
  String get wizard_screen_email_us => 'Στείλτε μας email';

  @override
  String get language_screen_language => 'Γλώσσα';

  @override
  String get project_view_no_videos => 'Δεν υπάρχει διαθέσιμη πηγή βίντεο.';

  @override
  String get about_screen_title => 'Σχετικά';

  @override
  String get about_screen_platform => 'Πλατφόρμα';

  @override
  String get about_screen_app_version => 'Έκδοση Εφαρμογής';

  @override
  String get about_screen_models => 'Μοντέλα ανίχνευσης αντικειμένων';

  @override
  String get about_screen_benchmark => 'Αξιολόγηση επιδόσεων';

  @override
  String get about_screen_opencv_build_info => 'Πληροφορίες δόμησης OpenCV';

  @override
  String get benchmark_screen_title => 'Αξιολόγηση Μοντέλων';

  @override
  String get benchmark_screen_recommended => 'Προτεινόμενο Μοντέλο';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Έναρξη Αξιολόγησης';

  @override
  String get benchmark_screen_start_failed => 'Αποτυχία έναρξης αξιολόγησης, ο κωδικός σφάλματος είναι';

  @override
  String get benchmark_screen_models => 'Μοντέλα ανίχνευσης αντικειμένων';

  @override
  String get project_screen_title => 'Έργο';

  @override
  String get project_screen_exit_confirm_title => 'Επιβεβαίωση εξόδου από το έργο';

  @override
  String get project_screen_exit_confirm_content => 'Η έξοδος από το έργο θα σταματήσει τη Μέτρηση. Είστε βέβαιοι ότι θέλετε να συνεχίσετε;';

  @override
  String get project_screen_exit_button => 'Έξοδος';

  @override
  String get project_screen_add_video_button => 'Προσθήκη πηγής βίντεο';

  @override
  String get project_screen_from_desc => 'Διατηρούμε ένα κυλιόμενο αρχείο 24 ωρών, ώστε να μπορείτε να δείτε οποιοδήποτε χρονικό διάστημα χρειάζεστε.';

  @override
  String get project_screen_report_settings => 'Ρυθμίσεις';

  @override
  String get filter_screen_title => 'Φίλτρο';

  @override
  String get filter_screen_desc => 'Επιλέξτε ένα εύρος φίλτρου από την παρακάτω λίστα';

  @override
  String get filter_screen_error_title => 'Φίλτρο';

  @override
  String get filter_screen_error_content => 'Η ώρα λήξης πρέπει να είναι μεγαλύτερη από την ώρα έναρξης';

  @override
  String get filter_screen_error_custom => 'Προσαρμοσμένο';

  @override
  String get filter_screen_error_start => 'Έναρξη';

  @override
  String get filter_screen_error_end => 'Λήξη';

  @override
  String get settings_screen_title => 'Ρυθμίσεις';

  @override
  String get settings_screen_desc => 'Ορίστε όνομα Έργου, παραμέτρους ανίχνευσης, εκκαθάριση μετρήσεων.';

  @override
  String get settings_screen_project_id => 'ID Έργου';

  @override
  String get settings_screen_project_name => 'Όνομα Έργου';

  @override
  String get settings_screen_project_name_place_holder => 'Λεωφόρος Αλεξάνδρας 123 ή Πάρκο Συντάγματος';

  @override
  String get settings_screen_project_error => 'Το όνομα του έργου δεν μπορεί να είναι κενό';

  @override
  String get settings_screen_random_count_button => 'Προσθήκη τυχαίων μετρήσεων';

  @override
  String get settings_screen_reset_count_header => 'Επαναφορά όλων των μετρήσεων σε αυτό το έργο';

  @override
  String get settings_screen_reset_count_button => 'Επαναφορά μετρήσεων';

  @override
  String get settings_screen_reset_count_content => 'Είστε βέβαιοι ότι θέλετε να επαναφέρετε όλες τις μετρήσεις;';

  @override
  String get settings_screen_delete_header => 'Διαγραφή αυτού του έργου';

  @override
  String get settings_screen_delete_content => 'Είστε βέβαιοι ότι θέλετε να διαγράψετε αυτό το έργο;';

  @override
  String get settings_screen_delete_button => 'Διαγραφή';

  @override
  String get settings_screen_center_point_title => 'Κεντρικό Σημείο στον Στόχο';

  @override
  String get settings_screen_center_point_desc => 'Το κεντρικό σημείο βοηθά στον προσδιορισμό εάν ο στόχος βρίσκεται εντός της ζώνης επιτυχίας.';

  @override
  String get settings_screen_center_point_button => 'Εμφάνιση Κεντρικού Σημείου στον Στόχο';

  @override
  String get settings_screen_lost_target_title => 'Χαμένος Στόχος';

  @override
  String get settings_screen_lost_target_desc => 'Όταν η παρακολούθηση αντικειμένων χάνει έναν στόχο, αυτή η επιλογή τον κάνει ορατό. Από προεπιλογή, οι χαμένοι στόχοι δεν εμφανίζονται.';

  @override
  String get settings_screen_lost_target_button => 'Εμφάνιση Χαμένου Στόχου';

  @override
  String get detection_screen_title => 'Ρυθμίσεις Ανίχνευσης';

  @override
  String get detection_screen_models => 'Μοντέλα';

  @override
  String get detection_screen_confidence => 'Αξιοπιστία';

  @override
  String get detection_screen_confidence_desc => 'αξιοπιστία πάνω από #0 θεωρείται έγκυρη ανίχνευση';

  @override
  String get detection_screen_low => 'Χαμηλή';

  @override
  String get detection_screen_high => 'Υψηλή';

  @override
  String get detection_screen_nms => 'Καταστολή Μη-Μέγιστων';

  @override
  String get detection_screen_nms_desc => '#0 Ένα χαμηλότερο όριο NMS (π.χ. 30%) θα αφαιρέσει πιο επιθετικά τα επικαλυπτόμενα πλαίσια οριοθέτησης, ενώ ένα υψηλότερο όριο NMS (π.χ. 0.6) θα επιτρέψει περισσότερη επικάλυψη';

  @override
  String get detection_screen_match => 'Αντιστοίχιση';

  @override
  String get detection_screen_match_desc => 'Αντιστοίχιση πάνω από #0 θεωρείται ότι είναι το ίδιο αντικείμενο.';

  @override
  String get detection_screen_lost => 'Χαμένο';

  @override
  String get detection_screen_lost_desc => 'Το αντικείμενο παρακολούθησης θα αφαιρεθεί εάν χαθεί για #0';

  @override
  String get detection_screen_consider_valid => 'Θεωρείται έγκυρο μετά από';

  @override
  String get detection_screen_consider_valid_desc => 'Το αντικείμενο παρακολούθησης θα θεωρηθεί έγκυρο μετά από #0';

  @override
  String get detection_screen_reset => 'Επαναφορά';

  @override
  String get detection_screen_reset_content => 'Είστε βέβαιοι ότι θέλετε να επαναφέρετε τις ρυθμίσεις ανίχνευσης;';

  @override
  String get url_screen_title => 'URL ζωντανής ροής';

  @override
  String get url_screen_desc => 'Παρακαλώ εισάγετε το URL ζωντανής ροής';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://example.com/stream ή rtsp://example.com/stream';

  @override
  String get add_video_screen_title => 'Προσθήκη πηγής βίντεο';

  @override
  String get add_video_screen_from => 'Προσθήκη πηγής βίντεο από';

  @override
  String get webcam_screen_add_title => 'Προσθήκη Κάμερας Web';

  @override
  String get webcam_screen_edit_title => 'Επιλογή Κάμερας Web';

  @override
  String get webcam_manager_webcam => 'Κάμερα Web';

  @override
  String get camera_screen_front_camera => 'Μπροστινή Κάμερα';

  @override
  String get camera_screen_back_camera => 'Πίσω Κάμερα';

  @override
  String get camera_screen_add_title => 'Προσθήκη Κάμερας';

  @override
  String get camera_screen_edit_title => 'Επιλογή Κάμερας';

  @override
  String get camera_screen_zoom_level => 'Επίπεδο Μεγέθυνσης';

  @override
  String get video_screen_name_empty => 'Το όνομα του βίντεο δεν μπορεί να είναι κενό.';

  @override
  String get video_screen_desc => 'Διαχείριση πηγών βίντεο, προσθήκη ή τροποποίηση ζωνών ανίχνευσης.';

  @override
  String get video_screen_video_name => 'Όνομα πηγής βίντεο';

  @override
  String get video_screen_edit_placeholder => 'Κάμερα Εισόδου ή Κάμερα Χώρου Στάθμευσης';

  @override
  String get video_screen_change_file => 'Αλλαγή Αρχείου';

  @override
  String get video_screen_add_zone => 'Προσθήκη ζώνης ανίχνευσης';

  @override
  String get video_screen_zones => 'Ζώνες ανίχνευσης';

  @override
  String get video_screen_zones_desc => 'Χρησιμοποιήστε μεταφορά και απόθεση για να προσαρμόσετε τις ζώνες';

  @override
  String get video_screen_tools => 'Εργαλεία';

  @override
  String get video_screen_move_bottom => 'Μετακίνηση τρέχουσας ζώνης στο κάτω μέρος';

  @override
  String get video_screen_add_point => 'Προσθήκη σημείου στην τρέχουσα ζώνη';

  @override
  String get video_screen_remove_point => 'Αφαίρεση σημείου από την τρέχουσα ζώνη';

  @override
  String get video_screen_playback_speed => 'Ταχύτητα Αναπαραγωγής';

  @override
  String get video_screen_playback_current => 'τρέχουσα: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Διαγραφή αυτής της πηγής βίντεο';

  @override
  String get video_screen_delete_content => 'Είστε βέβαιοι ότι θέλετε να διαγράψετε αυτήν την πηγή βίντεο;';

  @override
  String get video_screen_delete_button => 'Διαγραφή';

  @override
  String get video_screen_sources => 'Διαμόρφωση πηγής εικόνας, στόχων ανίχνευσης και παραμέτρων μοντέλου.';

  @override
  String get video_screen_targets => 'Στόχοι ανίχνευσης';

  @override
  String get video_screen_detection => 'Παράμετροι μοντέλου';

  @override
  String get color_screen_title => 'Επιλογή χρώματος';

  @override
  String get zone_screen_desc => 'Η ζώνη ανίχνευσης μπορεί να ορίσει τους τύπους αντικειμένων προς ανίχνευση και να επιλέξει ποιους μετρητές θα εμφανίζει, όπως Ανιχνευμένα, Εμφανισμένα και Εισερχόμενα.';

  @override
  String get zone_screen_name_placeholder => 'Το όνομα της ζώνης, όπως Πεζοδρόμιο ή Χώρος Στάθμευσης';

  @override
  String get zone_screen_zone_color => 'Χρώμα ζώνης';

  @override
  String get zone_screen_color => 'Χρώμα';

  @override
  String get zone_screen_delete_header => 'Διαγραφή αυτής της ζώνης';

  @override
  String get zone_screen_delete_content => 'Είστε βέβαιοι ότι θέλετε να διαγράψετε αυτή τη ζώνη;';

  @override
  String get zone_screen_delete_button => 'Διαγραφή';

  @override
  String get zone_screen_can_not_delete => 'Δεν είναι δυνατή η διαγραφή της ζώνης';

  @override
  String get zone_screen_one_zone_required => 'Απαιτείται τουλάχιστον μία ζώνη.';

  @override
  String get zone_screen_zone_name_required => 'Το όνομα της ζώνης δεν μπορεί να είναι κενό';

  @override
  String get counter_screen_show_on => 'Εμφάνιση στην οθόνη';

  @override
  String get counter_screen_enabled => 'Ενεργοποιημένο';

  @override
  String get counter_screen_reentry_threshold => 'Όριο Επανεισόδου';

  @override
  String get counter_screen_reentry_desc => 'Τα αντικείμενα πρέπει να εισέλθουν #0 φορές, με χρόνο αναμονής #1 δευτερολέπτων μεταξύ κάθε εξόδου και επανεισόδου, για να ενεργοποιηθεί η επανείσοδος';

  @override
  String get counter_screen_reentry_title => 'Μέτρηση επανεισόδου';

  @override
  String get counter_screen_cooldown_threshold => 'Όριο Χρόνου Αναμονής';

  @override
  String get counter_screen_cooldown_desc => 'Η επανείσοδος απαιτεί χρόνο αναμονής #0 δευτερολέπτων μετά την έξοδο από τη ζώνη ανίχνευσης';

  @override
  String get counter_screen_cooldown_time => 'Χρόνος Αναμονής';

  @override
  String get counter_screen_cooldown_in_seconds => 'σε δευτερόλεπτα';

  @override
  String get counter_screen_stagnant_threshold => 'Όριο Στασιμότητας';

  @override
  String get counter_screen_stagnant_desc => 'Τα αντικείμενα που παραμένουν ακίνητα για περισσότερο από #0 δευτερόλεπτα θα θεωρούνται στάσιμα';

  @override
  String get counter_screen_stagnant_consider => 'Θεώρηση ως στάσιμο';

  @override
  String get counter_screen_stagnant_in_seconds => 'σε δευτερόλεπτα';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Πρόθεμα Περιγραφής';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Επίθεμα Περιγραφής';

  @override
  String get counter_screen_name_error => 'Το όνομα του μετρητή δεν μπορεί να είναι κενό';

  @override
  String get counter_screen_enabled_error => 'Σφάλμα';

  @override
  String get counter_screen_enabled_error_content => 'Πρέπει πρώτα να ενεργοποιήσετε άλλο μετρητή και μετά να απενεργοποιήσετε αυτόν τον μετρητή';

  @override
  String get objects_screen_title => 'Αντικείμενα';

  @override
  String get objects_screen_desc => 'Επιλέξτε στόχους ανίχνευσης όπως άτομο, αυτοκίνητο, λεωφορείο, κλπ.';

  @override
  String get open_project_screen_title => 'Άνοιγμα Έργου';

  @override
  String get open_project_screen_desc => 'Άνοιγμα προηγουμένως δημιουργημένων έργων, διατηρώντας μόνο τα 20 πιο πρόσφατα.';

  @override
  String get open_project_screen_no_project => 'Δεν βρέθηκε έργο.';

  @override
  String get default_project_name => 'Έργο';

  @override
  String get default_video_name => 'Πηγή βίντεο';

  @override
  String get default_zone_name => 'Ζώνη ανίχνευσης';

  @override
  String get error_oops => 'Ωχ, κάτι πήγε στραβά';

  @override
  String get error_content => 'Προέκυψε ένα απροσδόκητο σφάλμα. Θέλετε να υποβάλετε μια αναφορά μέσω email;';

  @override
  String get error_report => 'Στείλτε μας email';

  @override
  String get submit => 'Υποβολή';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get yes => 'Ναι';

  @override
  String get no => 'Όχι';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get back => 'Πίσω';

  @override
  String get settings_screen_detection_button => 'MISSING';

  @override
  String get zone_screen_zone => 'Ζώνη';

  @override
  String get zone_screen_zone_show_summary => 'Εμφάνιση σύνοψης στην οθόνη';
}
