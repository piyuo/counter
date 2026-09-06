// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class LocalizationEl extends Localization {
  LocalizationEl([String locale = 'el']) : super(locale);

  @override
  String get about_screen_app_version => 'Έκδοση Εφαρμογής';

  @override
  String get about_screen_email_us => 'Στείλτε μας email';

  @override
  String get about_screen_platform => 'Πλατφόρμα';

  @override
  String get appeared => 'Εμφανίστηκαν';

  @override
  String get appeared_help =>
      'Μετρά άτομα ή οχήματα των οποίων η πρώτη ανιχνευμένη θέση ήταν μέσα σε αυτή την περιοχή.\\n\\nΧρήσιμο για την κατανόηση του σημείου όπου ξεκινά η παρακολούθηση.\\n\\n(Κυρίως για προχωρημένους χρήστες)';

  @override
  String get average_occupancy => 'Μέση πληρότητα';

  @override
  String get average_occupancy_help =>
      'Εμφανίζει τον μέσο αριθμό ατόμων ή οχημάτων σε αυτή την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΒοηθά να εκτιμήσετε πόσο πολυσύχναστη ήταν η περιοχή σε όλη τη διάρκεια του παραθύρου καταμέτρησης.';

  @override
  String get average_stay => 'Μέση διάρκεια παραμονής';

  @override
  String get average_stay_help =>
      'Εμφανίζει τον μέσο χρόνο παραμονής ατόμων ή οχημάτων σε αυτή την περιοχή.\\n\\nΜεγαλύτερη μέση διάρκεια παραμονής μπορεί να σημαίνει ότι οι πελάτες περνούν περισσότερο χρόνο σε αυτή την περιοχή.';

  @override
  String get camera_test_screen_help =>
      'Το Piyuo Counter χρησιμοποιεί την κάμερα και AI στη συσκευή για να μετρά ανθρώπους. Αρχικά, ας βεβαιωθούμε ότι η συσκευή σας είναι συμβατή.';

  @override
  String get camera_test_screen_instruction =>
      'Στρέψτε την κάμερα προς ανθρώπους. Η εφαρμογή θα σχεδιάσει πλαίσια γύρω από όσους εντοπίσει.';

  @override
  String get camera_test_screen_next => 'Πατήστε Επόμενο για συνέχεια.';

  @override
  String get camera_test_screen_start =>
      'Πατήστε Έναρξη. Αν σας ζητηθεί, επιτρέψτε την πρόσβαση στην κάμερα.';

  @override
  String get camera_test_screen_test_failed => 'Η δοκιμή απέτυχε!';

  @override
  String get camera_test_screen_test_passed =>
      'Η δοκιμή ολοκληρώθηκε με επιτυχία!';

  @override
  String get camera_test_screen_title => 'Δοκιμή κάμερας AI';

  @override
  String get camera_test_screen_wait =>
      'Αναμονή για ανίχνευση ατόμων από το AI…';

  @override
  String get cta_screen_custom => 'Χρήση του δικού σας διακομιστή';

  @override
  String get cta_screen_custom_help =>
      'Στείλτε δεδομένα κίνησης απευθείας στο δικό σας backend ή βάση δεδομένων.';

  @override
  String get cta_screen_footer =>
      'Συνεχίζοντας, συμφωνείτε με τους Όρους Χρήσης, την Πολιτική Απορρήτου και τη Συμφωνία Επεξεργασίας Δεδομένων.';

  @override
  String get cta_screen_invitation => 'Χρήση κωδικού πρόσκλησης';

  @override
  String get cta_screen_invitation_help =>
      'Συμμετάσχετε σε έναν υπάρχοντα οργανισμό χρησιμοποιώντας πρόσκληση από τον διαχειριστή σας.';

  @override
  String get cta_screen_local => 'Μόνο σε αυτή τη συσκευή';

  @override
  String get cta_screen_local_help =>
      'Αποθηκεύστε τα δεδομένα κίνησης μόνο σε αυτή τη συσκευή. Δεν μεταφορτώνεται τίποτα.';

  @override
  String get cta_screen_piyuo => 'Χρήση του Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Αποθηκεύστε δεδομένα κίνησης στο Piyuo Cloud με πίνακες ελέγχου και επιχειρηματικές αναλύσεις.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'Το Piyuo Counter δημιουργεί ανώνυμα στατιστικά κίνησης κάθε 5 λεπτά.\\nΕπιλέξτε πώς θέλετε να αποθηκεύετε και να έχετε πρόσβαση στα δεδομένα σας.';

  @override
  String get current_occupancy => 'Τρέχων αριθμός';

  @override
  String get current_occupancy_help =>
      'Εμφανίζει τον τρέχοντα αριθμό ατόμων ή οχημάτων σε αυτή την περιοχή.\\n\\nΟ αριθμός ενημερώνεται σε πραγματικό χρόνο και βοηθά να επιβεβαιώσετε ότι η ανίχνευση AI ταιριάζει με αυτό που βλέπετε στην οθόνη. Δεν περιλαμβάνεται στα δεδομένα τηλεμετρίας που αποστέλλονται.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Αποθήκευση...';

  @override
  String get custom_server_screen_server_url_label => 'Διεύθυνση διακομιστή';

  @override
  String get detection_screen_confidence => 'Όριο εμπιστοσύνης';

  @override
  String get detection_screen_confidence_dialog =>
      'Καθορίζει πόσο σίγουρη πρέπει να είναι η AI πριν μετρήσει ένα άτομο ή όχημα.\\nΧαμηλότερες τιμές\\n• Εντοπίζουν περισσότερα αντικείμενα\\n• Καλύτερες για μακρινά ή μερικώς κρυμμένα αντικείμενα\\n• Μπορεί να αυξήσουν τις λανθασμένες ανιχνεύσεις\\nΥψηλότερες τιμές\\n• Μετρούν μόνο ανιχνεύσεις υψηλής βεβαιότητας\\n• Μειώνουν τις λανθασμένες ανιχνεύσεις\\n• Μπορεί να χάσουν μικρά ή δύσκολα αντικείμενα\\nΧρησιμοποιήστε χαμηλότερη τιμή αν η εφαρμογή χάνει άτομα ή οχήματα.\\nΧρησιμοποιήστε υψηλότερη τιμή αν η εφαρμογή μετρά σκιές, αντανακλάσεις ή άλλα ψευδή αντικείμενα.';

  @override
  String get detection_screen_confidence_help =>
      'Ελάχιστη βεβαιότητα που απαιτείται για την ανίχνευση ενός αντικειμένου.';

  @override
  String get detection_screen_confidence_max_label => 'Αυστηρό';

  @override
  String get detection_screen_confidence_min_label => 'Χαλαρό';

  @override
  String get detection_screen_disappear => 'Χρονικό όριο εξαφάνισης';

  @override
  String get detection_screen_disappear_dialog =>
      'Καθορίζει πόσο περιμένει η AI πριν σημειώσει ένα αντικείμενο ως εξαφανισμένο αφού δεν εντοπίζεται πλέον.\\nΣυντομότερες τιμές\\n• Σημειώνουν αντικείμενα ως εξαφανισμένα γρηγορότερα\\n• Καλύτερες για γρήγορη κίνηση\\n• Μπορεί να σημειώσουν προσωρινά κρυμμένα αντικείμενα ως εξαφανισμένα\\nΜεγαλύτερες τιμές\\n• Περιμένουν περισσότερο πριν σημειώσουν αντικείμενα ως εξαφανισμένα\\n• Καλύτερες όταν αντικείμενα μπλοκάρονται ή χάνονται σύντομα\\n• Καθυστερούν τα συμβάντα εξαφάνισης';

  @override
  String get detection_screen_disappear_help =>
      'Πόσο περιμένει η AI πριν θεωρήσει ότι ένα αντικείμενο έχει εξαφανιστεί αφού δεν μπορεί πλέον να το ανιχνεύσει.';

  @override
  String get detection_screen_disappear_max_label => 'Αργά';

  @override
  String get detection_screen_disappear_min_label => 'Γρήγορα';

  @override
  String get detection_screen_memory_dialog =>
      'Καθορίζει πόσο καιρό η AI θυμάται ένα αντικείμενο αφού εξαφανιστεί.\\nΑυξήστε αυτή την τιμή αν άτομα ή οχήματα κρύβονται συχνά πίσω από άλλα αντικείμενα.\\nΜειώστε αυτή την τιμή αν τα αντικείμενα συνδέονται λανθασμένα αφού φύγουν από τη σκηνή.';

  @override
  String get detection_screen_min_presence => 'Ελάχιστος χρόνος παρουσίας';

  @override
  String get detection_screen_min_presence_help =>
      'Ένα αντικείμενο πρέπει να παραμένει ορατό πριν καταμετρηθεί. Οι μεγαλύτερες τιμές βοηθούν στη μείωση σύντομων λανθασμένων ανιχνεύσεων.';

  @override
  String get detection_screen_min_presence_max_label => 'Πιο ασφαλές';

  @override
  String get detection_screen_min_presence_min_label => 'Ταχύτερα';

  @override
  String get detection_screen_minimum_visible =>
      'Τα αντικείμενα πρέπει να παραμείνουν ορατά για αυτό το χρονικό διάστημα πριν μετρηθούν.\\nΑυξήστε αυτή την τιμή για να αγνοήσετε σύντομες λανθασμένες ανιχνεύσεις.\\nΜειώστε αυτή την τιμή αν γρήγορα κινούμενα άτομα ή οχήματα δεν εντοπίζονται.';

  @override
  String get detection_screen_new_track => 'Όριο νέας παρακολούθησης';

  @override
  String get detection_screen_new_track_help =>
      'Ελάχιστη βεβαιότητα για την έναρξη παρακολούθησης νέου αντικειμένου. Οι χαμηλές τιμές μπορεί να δημιουργήσουν διπλές παρακολουθήσεις.';

  @override
  String get detection_screen_new_track_max_label => 'Συντηρητικό';

  @override
  String get detection_screen_new_track_min_label => 'Επιθετικό';

  @override
  String get detection_screen_reset => 'Επαναφορά';

  @override
  String get detection_screen_reset_content =>
      'Είστε βέβαιοι ότι θέλετε να επαναφέρετε τις ρυθμίσεις ανίχνευσης;';

  @override
  String get detection_screen_show_track_id => 'Εμφάνιση ID παρακολούθησης';

  @override
  String get detection_screen_show_track_id_help =>
      'Ενεργοποιήστε αυτήν την επιλογή για να εμfανίσετε μοναδικά ID παρακολούθησης για κάθε παρακολουθούμενο αντικείμενο.';

  @override
  String get detection_screen_stay => 'Χρόνος παραμονής';

  @override
  String get detection_screen_stay_help =>
      'Πόσο πρέπει να παραμείνει ένα αντικείμενο στην περιοχή πριν υπολογιστεί ως παραμονή.';

  @override
  String get detection_screen_stay_max_label => 'Καθυστερημένο';

  @override
  String get detection_screen_stay_min_label => 'Άμεσο';

  @override
  String get detection_screen_stay_threshold =>
      'Καθορίζει πότε ένα αντικείμενο συμβάλλει στην καταμέτρηση παραμονής.\\nΣυντομότερες τιμές\\n• Μετρούν την παραμονή αμέσως\\n• Καλύτερες για γρήγορη ανάλυση\\nΜεγαλύτερες τιμές\\n• Αγνοούν τη σύντομη διερχόμενη κίνηση\\n• Καλύτερες για μέτρηση πληρότητας';

  @override
  String get detection_screen_subtitle =>
      'Ρυθμίστε τον τρόπο με τον οποίο η AI εντοπίζει και παρακολουθεί αντικείμενα';

  @override
  String get detection_screen_title => 'Παρακολούθηση & Καταμέτρηση';

  @override
  String get detection_screen_track_dialog =>
      'Καθορίζει πότε ένα νέο εντοπισμένο αντικείμενο γίνεται νέα διαδρομή παρακολούθησης.\\nΧαμηλότερες τιμές\\n• Η παρακολούθηση ξεκινά νωρίτερα\\n• Καλύτερες για γρήγορα κινούμενα αντικείμενα\\n• Μπορεί να δημιουργήσουν διπλές διαδρομές\\nΥψηλότερες τιμές\\n• Απαιτούν ισχυρότερα στοιχεία πριν τη δημιουργία νέας διαδρομής\\n• Μειώνουν τις διπλές διαδρομές\\n• Μπορεί να καθυστερήσουν την παρακολούθηση νέων αντικειμένων';

  @override
  String get detection_screen_track_memory => 'Μνήμη παρακολούθησης';

  @override
  String get detection_screen_track_memory_help =>
      'Πόσο καιρό συνεχίζεται η παρακολούθηση ενός αντικειμένου αφού χαθεί προσωρινά. Οι μεγαλύτερες τιμές βοηθούν στην ανάκτηση μετά από σύντομες αποκρύψεις.';

  @override
  String get detection_screen_track_memory_max_label => 'Μεγάλο';

  @override
  String get detection_screen_track_memory_min_label => 'Σύντομο';

  @override
  String get device_not_supported_screen_body =>
      'Το Piyuo Counter χρησιμοποιεί την κάμερά σας για να εντοπίζει πεζούς και οχήματα σε πραγματικό χρόνο. Δεν υπάρχει διαθέσιμη κάμερα σε αυτήν τη συσκευή.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Δοκιμάστε να ανοίξετε αυτήν την εφαρμογή στο τηλέφωνό σας';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Ένα smartphone ή tablet με κάμερα';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Συνιστάται συσκευή iOS ή Android';

  @override
  String get device_not_supported_screen_requirements_title => 'Τι χρειάζεστε';

  @override
  String get device_not_supported_screen_title => 'Δεν βρέθηκε κάμερα';

  @override
  String get disappeared => 'Εξαφανίστηκαν';

  @override
  String get disappeared_help =>
      'Μετρά άτομα ή οχήματα των οποίων η τελευταία ανιχνευμένη θέση ήταν μέσα σε αυτή την περιοχή.\\n\\nΗ παρακολούθηση τερματίζεται μετά τον καθορισμένο χρόνο εξαφάνισης, εάν το άτομο ή το όχημα δεν ανιχνεύεται πλέον.\\n\\n(Κυρίως για προχωρημένους χρήστες)';

  @override
  String get dpa => 'Συμφωνία Επεξεργασίας Δεδομένων';

  @override
  String get durationDaysShort => '%sημ';

  @override
  String get durationHoursShort => '%sώ';

  @override
  String get durationMinutesShort => '%sλ';

  @override
  String get durationSecondsShort => '%sδ';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Εισήλθαν';

  @override
  String get entered_help =>
      'Μετρά τα άτομα ή τα οχήματα που εισήλθαν σε αυτή την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΜια είσοδος καταγράφεται όταν ένα άτομο ή όχημα μετακινείται από έξω προς το εσωτερικό της περιοχής.';

  @override
  String get exited => 'Εξήλθαν';

  @override
  String get exited_help =>
      'Μετρά τα άτομα ή τα οχήματα που εξήλθαν από αυτή την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΜια έξοδος καταγράφεται όταν ένα άτομο ή όχημα μετακινείται από το εσωτερικό προς το εξωτερικό της περιοχής.';

  @override
  String get language_screen_language => 'Γλώσσα';

  @override
  String get language_screen_subtitle =>
      'Επιλέξτε τη γλώσσα που χρησιμοποιείται στην εφαρμογή.';

  @override
  String get local_only_screen_body =>
      'Η λειτουργία \'Μόνο τοπική συσκευή\' σάς επιτρέπει να δοκιμάσετε την ανίχνευση και παρακολούθηση κάμερας με τεχνητή νοημοσύνη χωρίς να μεταφορτώνετε δεδομένα. Όλα τα στατιστικά κίνησης πεζών επεξεργάζονται μόνο σε αυτή τη συσκευή, ιδανικό για δοκιμή πριν συνδεθείτε σε διακομιστή.';

  @override
  String get local_only_screen_use_action => 'Χρήση μόνο τοπικής συσκευής';

  @override
  String get local_screen_text =>
      'Το Piyuo Counter θα εκτελείται εξ ολοκλήρου σε αυτή τη συσκευή.\\nΤα στατιστικά κίνησης θα αποθηκεύονται μόνο σε αυτή τη συσκευή και δεν θα μεταφορτώνονται.\\nΜπορείτε αργότερα να συνδεθείτε στο Piyuo Cloud ή στον δικό σας διακομιστή από τις Ρυθμίσεις.';

  @override
  String get maximum_occupancy => 'Μέγιστη πληρότητα';

  @override
  String get maximum_occupancy_help =>
      'Εμφανίζει τον μεγαλύτερο αριθμό ατόμων ή οχημάτων που βρέθηκαν ταυτόχρονα σε αυτή την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΧρήσιμο για τον εντοπισμό των περιόδων με τη μεγαλύτερη κίνηση ή συμφόρηση.';

  @override
  String get maximum_stay => 'Μέγιστη διάρκεια παραμονής';

  @override
  String get maximum_stay_help =>
      'Εμφανίζει τη μεγαλύτερη διάρκεια παραμονής ατόμου ή οχήματος σε αυτή την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΧρήσιμο για τον εντοπισμό ασυνήθιστα μεγάλων επισκέψεων ή στάσεων.';

  @override
  String get metric_events => 'Συμβάντα';

  @override
  String get metric_live => 'Ζωντανά';

  @override
  String get metric_show_less => 'Εμφάνιση λιγότερων';

  @override
  String get metric_show_more => 'Εμφάνιση περισσότερων';

  @override
  String get metric_statistics => 'Στατιστικά';

  @override
  String get metrics_counting_all => 'Όλα';

  @override
  String get metrics_counting_done => 'Ολοκληρώθηκε';

  @override
  String get metrics_counting_in_progress => 'Σε εξέλιξη';

  @override
  String get metrics_counting_missing => 'Λείπει';

  @override
  String get metrics_counting_window => 'Στατιστικά για κάθε περίοδο 5 λεπτών';

  @override
  String get onboarding_back_action => 'Πίσω';

  @override
  String get onboarding_cta_no_server => 'Δεν θέλετε να ανεβάζετε δεδομένα;';

  @override
  String get onboarding_cta_title => 'Πού θα αποστέλλονται τα δεδομένα σας;';

  @override
  String get onboarding_intro_text1 =>
      'Το Piyuo Counter χρησιμοποιεί την κάμερα και την AI της συσκευής σου για να εντοπίζει ανθρώπους και οχήματα σε πραγματικό χρόνο.\\nΜε τεχνολογία αναγνώρισης και παρακολούθησης, μετράει αυτόματα την κίνηση πεζών και οχημάτων — όλα γίνονται απευθείας στη συσκευή σου.';

  @override
  String get onboarding_intro_text2 =>
      'Όλη η επεξεργασία AI γίνεται τοπικά στη συσκευή σου. Δεν ανεβαίνει κανένα βίντεο, εικόνα, πρόσωπο ή ταυτότητα.\\nΜοιράζονται μόνο ανώνυμες συνόψεις κάθε 5 λεπτά, με στατιστικά καταμέτρησης, πληρότητας, εισόδων, εξόδων και χρόνου παραμονής.';

  @override
  String get onboarding_intro_text3 =>
      'Απλώς ξεκίνησε την εφαρμογή και άφησέ την να τρέχει. Το Piyuo Counter συλλέγει και αποθηκεύει συνεχώς δεδομένα κίνησης αυτόματα.\\nΟι συνόψεις δεδομένων αποθηκεύονται κάθε 5 λεπτά και ανεβαίνουν κάθε ώρα στο Piyuo Cloud ή στον δικό σου διακομιστή.';

  @override
  String get onboarding_intro_title1 => 'Καταμέτρηση κίνησης με AI';

  @override
  String get onboarding_intro_title2 => 'Πρώτα η ιδιωτικότητα';

  @override
  String get onboarding_intro_title3 => 'Λειτουργεί αυτόματα 24/7';

  @override
  String get onboarding_next_action => 'Επόμενο';

  @override
  String get onboarding_skip_action => 'Παράλειψη εισαγωγής';

  @override
  String get onboarding_start_action => 'Έναρξη';

  @override
  String get passed_by => 'Πέρασαν';

  @override
  String get passed_by_help =>
      'Μετρά τα άτομα ή τα οχήματα που πέρασαν από αυτήν την περιοχή κατά τη διάρκεια του τρέχοντος παραθύρου καταμέτρησης.\\n\\nΚάθε άτομο ή όχημα μετριέται μόνο μία φορά για κάθε διέλευση από την περιοχή.';

  @override
  String get payloads_screen_area => 'Περιοχή';

  @override
  String get payloads_screen_confidence => 'Εμπιστοσύνη';

  @override
  String get payloads_screen_coverage => 'Κάλυψη';

  @override
  String get payloads_screen_delivered => 'Παραδόθηκε';

  @override
  String get payloads_screen_failed_load =>
      'Αποτυχία φόρτωσης πρόσφατων φορτίων';

  @override
  String get payloads_screen_frame_processed => 'Επεξεργασμένα καρέ';

  @override
  String get payloads_screen_hour_not_exists => 'Αυτή η ώρα δεν υπάρχει πλέον.';

  @override
  String get payloads_screen_missing_time => 'Χαμένος χρόνος';

  @override
  String get payloads_screen_no_payloads => 'Δεν υπάρχουν ακόμη φορτία.';

  @override
  String get payloads_screen_partial => 'Το παράθυρο έληξε νωρίς (μερικό)';

  @override
  String get payloads_screen_partially => 'Μερική παράδοση';

  @override
  String get payloads_screen_payload_not_exists =>
      'Αυτό το φορτίο δεν υπάρχει πλέον.';

  @override
  String get payloads_screen_pending => 'Σε αναμονή παράδοσης';

  @override
  String get payloads_screen_process_fps => 'FPS επεξεργασίας';

  @override
  String get payloads_screen_resend => 'Επανάληψη αποστολής';

  @override
  String get payloads_screen_select_first =>
      'Επιλέξτε πρώτα τουλάχιστον μία ημερομηνία ή ώρα.';

  @override
  String get payloads_screen_subtitle =>
      'Επιλέξτε ημερομηνία ή ώρα για επανάληψη αποστολής';

  @override
  String get payloads_screen_title => 'Πρόσφατα φορτία';

  @override
  String get personal_custom_screen_build_server =>
      'Χρειάζεστε βοήθεια για να ρυθμίσετε τον δικό σας διακομιστή;\\nΔείτε την τεκμηρίωση API και παραδείγματα διακομιστών.';

  @override
  String get personal_custom_screen_help_action => 'Άνοιγμα τεκμηρίωσης API';

  @override
  String get personal_custom_screen_reset_action => 'Ξεκινήστε από την αρχή';

  @override
  String get personal_custom_success_screen_help =>
      'Πατήστε το Start παρακάτω για να ξεκινήσει η καταμέτρηση.';

  @override
  String get personal_custom_success_screen_help1 =>
      'Τα στατιστικά κίνησης μεταφορτώνονται αυτόματα κάθε ώρα.\\nΜπορείτε επίσης να τα μεταφορτώσετε χειροκίνητα από την οθόνη Αρχείου Μεταφορτώσεων.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Ο διακομιστής σας δεν χρειάζεται να είναι ακόμη συνδεδεμένος.\\nΞεκινήστε την καταμέτρηση τώρα. Μπορείτε να ολοκληρώσετε την ανάπτυξη και τις δοκιμές του διακομιστή σας αργότερα. Τα στατιστικά κίνησης θα παραμείνουν σε αυτήν τη συσκευή μέχρι να μεταφορτωθούν με επιτυχία.';

  @override
  String get personal_custom_success_screen_send_to =>
      'Τα στατιστικά κίνησης θα σταλούν στο';

  @override
  String get personal_custom_success_screen_title =>
      'Ο διακομιστής είναι έτοιμος';

  @override
  String get piyuo_server_screen_cloud_url_label =>
      'Το URL του Piyuo Cloud σας';

  @override
  String get piyuo_server_screen_copy_action => 'Αντιγραφή URL';

  @override
  String get piyuo_server_screen_copy_success => 'Το URL αντιγράφηκε';

  @override
  String get piyuo_server_screen_saving_action => 'Αποθήκευση...';

  @override
  String get piyuo_server_screen_start =>
      'Πατήστε «Start» παρακάτω για να ξεκινήσει η καταμέτρηση.';

  @override
  String get piyuo_server_screen_url_help =>
      'Ο προσωπικός σας πίνακας ελέγχου Piyuo Cloud είναι έτοιμος σε αυτό το URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Αποθηκεύστε αυτό το URL για να αποκτήσετε πρόσβαση στον πίνακα ελέγχου επισκεψιμότητας από άλλη συσκευή.';

  @override
  String get piyuo_server_screen_use_action => 'Χρήση του Piyuo Cloud';

  @override
  String get privacy => 'Πολιτική Απορρήτου';

  @override
  String get product_copyright => 'Πνευματικά δικαιώματα © 2026';

  @override
  String get product_desc =>
      'Καταμέτρηση ανθρώπων και οχημάτων με τεχνητή νοημοσύνη.';

  @override
  String get settings_screen_custom_subtitle =>
      'Στείλτε τα δεδομένα κίνησης απευθείας στο backend ή στη βάση δεδομένων σας.';

  @override
  String get settings_screen_custom_title => 'Χρήση προσαρμοσμένου διακομιστή';

  @override
  String get settings_screen_data_server_label => 'Διακομιστής δεδομένων';

  @override
  String get settings_screen_detection_target => 'Στόχος ανίχνευσης';

  @override
  String get settings_screen_language_title => 'Γλώσσα';

  @override
  String get settings_screen_local_subtitle =>
      'Αποθηκεύστε τα δεδομένα κίνησης μόνο σε αυτή τη συσκευή. Δεν μεταφορτώνεται τίποτα.';

  @override
  String get settings_screen_local_title => 'Μόνο τοπική συσκευή';

  @override
  String get settings_screen_misc_label => 'Διάφορα';

  @override
  String get settings_screen_object_detection => 'Ανίχνευση αντικειμένων';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Αποθηκεύστε τα δεδομένα επισκεψιμότητας στο Piyuo Cloud με πίνακες ελέγχου και επιχειρηματικές πληροφορίες.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Αυτό θα διαγράψει όλα τα δεδομένα και θα ξεκινήσει από την αρχή. Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Επαναφορά όλων των δεδομένων;';

  @override
  String get settings_screen_subscription_body =>
      'Διαχειριστείτε τη συνδρομή και τα στοιχεία χρέωσής σας';

  @override
  String get settings_screen_subscription_title => 'Συνδρομή';

  @override
  String get start_screen_about => 'Σχετικά';

  @override
  String get start_screen_server_none =>
      'Τα δεδομένα αποθηκεύονται μόνο σε αυτήν τη συσκευή';

  @override
  String get start_screen_server_personal =>
      'Τα δεδομένα μεταφορτώνονται κάθε ώρα στο';

  @override
  String get start_screen_settings => 'Ρυθμίσεις';

  @override
  String get start_screen_upload_logs => 'Μεταφόρτωση αρχείων καταγραφής';

  @override
  String get start_screen_video_sources => 'Πηγές βίντεο';

  @override
  String get stayed => 'Παρέμειναν';

  @override
  String get stayed_help =>
      'Μετρά άτομα ή οχήματα που παρέμειναν σε αυτή την περιοχή για τουλάχιστον τον καθορισμένο χρόνο παραμονής.\\n\\nΟ προεπιλεγμένος χρόνος παραμονής είναι 15 δευτερόλεπτα και μπορεί να αλλάξει από τις Ρυθμίσεις.';

  @override
  String get target_pedestrian => 'Πεζοί';

  @override
  String get target_pedestrian_help =>
      'Μετρήστε άτομα με το μοντέλο ανίχνευσης πεζών';

  @override
  String get target_screen_subtitle =>
      'Επιλέξτε ποιο μοντέλο ανίχνευσης θα χρησιμοποιηθεί';

  @override
  String get target_vehicle => 'Οχήματα';

  @override
  String get target_vehicle_help =>
      'Μετρήστε αυτοκίνητα και άλλα οχήματα με το μοντέλο ανίχνευσης οχημάτων';

  @override
  String get telemetry_error_connection_refused =>
      'Δεν ήταν δυνατή η σύνδεση με τον διακομιστή. Ίσως είναι εκτός λειτουργίας.';

  @override
  String get telemetry_error_connection_reset =>
      'Η σύνδεση επαναφέρθηκε. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο και δοκιμάστε ξανά.';

  @override
  String get telemetry_error_connection_timeout =>
      'Η σύνδεση καθυστέρησε πολύ να ανταποκριθεί. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο και δοκιμάστε ξανά.';

  @override
  String get telemetry_error_database_error =>
      'Η εγγραφή στη βάση δεδομένων απέτυχε.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Δεν βρέθηκε η διεύθυνση του διακομιστή. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο ή τη διεύθυνση URL.';

  @override
  String get telemetry_error_http_error_status =>
      'Ο διακομιστής απέρριψε το αίτημα. Δοκιμάστε ξανά αργότερα.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Παρουσιάστηκε ένα απρόσμενο σφάλμα κατά την επικοινωνία με τον διακομιστή.';

  @override
  String get telemetry_error_invalid_url =>
      'Η διεύθυνση του διακομιστή δεν είναι έγκυρη. Ελέγξτε τις ρυθμίσεις σας.';

  @override
  String get telemetry_error_network_error =>
      'Παρουσιάστηκε σφάλμα δικτύου. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο και δοκιμάστε ξανά.';

  @override
  String get telemetry_error_socket_error =>
      'Παρουσιάστηκε πρόβλημα σύνδεσης δικτύου. Ελέγξτε τη σύνδεσή σας στο διαδίκτυο.';

  @override
  String get telemetry_error_transport_exception =>
      'Κάτι πήγε στραβά κατά την αποστολή δεδομένων. Δοκιμάστε ξανά.';

  @override
  String get telemetry_error_unknown_error =>
      'Παρουσιάστηκε ένα απρόσμενο σφάλμα.';

  @override
  String get terms => 'Όροι Παροχής Υπηρεσιών';

  @override
  String get upload_screen_attempt_time => 'Ώρα προσπάθειας:';

  @override
  String get upload_screen_error => 'Σφάλμα:';

  @override
  String get upload_screen_failed => 'Απέτυχε';

  @override
  String get upload_screen_load_error =>
      'Αδυναμία φόρτωσης των αρχείων μεταφόρτωσης.';

  @override
  String get upload_screen_log_not_exists =>
      'Το αρχείο μεταφόρτωσης δεν είναι πλέον διαθέσιμο.';

  @override
  String get upload_screen_next => 'Επόμενη μεταφόρτωση στις ...';

  @override
  String get upload_screen_next_upload_prefix => 'Επόμενη μεταφόρτωση στις ';

  @override
  String get upload_screen_no_data_server =>
      'Ορίστε πρώτα τον διακομιστή δεδομένων.';

  @override
  String get upload_screen_no_logs => 'Δεν υπάρχουν ακόμη αρχεία μεταφόρτωσης.';

  @override
  String get upload_screen_payload_count => 'Αριθμός φορτίων';

  @override
  String get upload_screen_payload_count_label => 'Αριθμός φορτίων:';

  @override
  String get upload_screen_payload_size => 'Μέγεθος φορτίου:';

  @override
  String get upload_screen_result => 'Αποτέλεσμα:';

  @override
  String get upload_screen_retry => 'Αριθμός επαναλήψεων:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Επιτυχία';

  @override
  String get upload_screen_today => 'Σήμερα';

  @override
  String get upload_screen_upload_now => 'Μεταφόρτωση τώρα';

  @override
  String get upload_screen_upload_success => 'Η μεταφόρτωση ολοκληρώθηκε.';

  @override
  String get upload_screen_uploading => 'Μεταφόρτωση...';

  @override
  String get upload_screen_yesterday => 'Χθες';

  @override
  String get url_screen_invalid_rtsp_error =>
      'Τα URL RTSP πρέπει να περιλαμβάνουν όνομα κεντρικού υπολογιστή.';

  @override
  String get url_screen_invalid_url_error =>
      'Εισαγάγετε ένα έγκυρο URL με υποστηριζόμενο σχήμα.';

  @override
  String get url_screen_subtitle => 'Παρακαλώ εισάγετε το URL ζωντανής ροής';

  @override
  String get url_screen_title => 'URL ζωντανής ροής';

  @override
  String get url_screen_unsupported_scheme_error =>
      ' RTSP এবং RTSPS URL সমর্থিত।';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Εισαγάγετε μια διεύθυνση URL ζωντανής μετάδοσης.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://example.com/stream ή rtsp://example.com/stream';

  @override
  String get video_sources_back_camera => 'Πίσω κάμερα';

  @override
  String get video_sources_camera => 'Κάμερα';

  @override
  String get video_sources_file => 'Αρχείο';

  @override
  String get video_sources_front_camera => 'Μπροστινή κάμερα';

  @override
  String get video_sources_live_stream => 'URL ζωντανής ροής';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'Χρειάζεται να παραχωρήσετε άδεια κάμερας για τη χρήση της';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Η κάμερα δεν βρέθηκε';

  @override
  String get video_sources_screen_import_error =>
      'Δεν ήταν δυνατή η εισαγωγή του αρχείου βίντεο.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Μεταβείτε στις ρυθμίσεις και επιτρέψτε την πρόσβαση σε φωτογραφίες για αυτήν την εφαρμογή.';

  @override
  String get video_sources_screen_select_camera =>
      'Πατήστε για να επιλέξετε αυτήν την κάμερα';

  @override
  String get video_sources_screen_select_file =>
      'Πατήστε για να επιλέξετε ένα αρχείο';

  @override
  String get video_sources_screen_select_live =>
      'Πατήστε για να ορίσετε τη διεύθυνση URL ζωντανής μετάδοσης';

  @override
  String get video_sources_webcam => 'Κάμερα web';
}
