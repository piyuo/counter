// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationPt extends AppLocalization {
  AppLocalizationPt([String locale = 'pt']) : super(locale);

  @override
  String get product_name => 'Contador de Visão';

  @override
  String get product_desc => 'Use visão computacional e IA para contar pessoas, veículos, animais de estimação e muito mais.';

  @override
  String get product_copyright => 'Copyright © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de transmissão ao vivo';

  @override
  String get video_sources_file => 'Arquivo';

  @override
  String get video_sources_camera => 'Câmera';

  @override
  String get video_sources_camera_not_found_title => 'Câmera não encontrada';

  @override
  String get video_sources_camera_not_found_message => 'É necessário conceder permissão para usar a câmera';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam não encontrada';

  @override
  String get video_sources_webcam_not_found_message => 'Verifique se há alguma webcam conectada';

  @override
  String get wizard_screen_desc => 'Crie um novo projeto abaixo para começar a contar.';

  @override
  String get wizard_screen_new_project_from => 'Novo Projeto a partir de';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_about => 'Sobre';

  @override
  String get wizard_screen_open_projects_tip => 'Todos os projetos serão salvos localmente de forma automática';

  @override
  String get wizard_screen_open_projects => 'Abrir projeto existente';

  @override
  String get wizard_screen_email_us => 'Envie-nos um e-mail';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get project_view_no_videos => 'Nenhuma fonte de vídeo disponível.';

  @override
  String get about_screen_title => 'Sobre';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_app_version => 'Versão do Aplicativo';

  @override
  String get about_screen_models => 'Modelos de detecção de objetos';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informações de Compilação do OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmark dos Modelos';

  @override
  String get benchmark_screen_recommended => 'Modelo Recomendado';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Iniciar Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Falha ao iniciar o benchmark, o código de erro é';

  @override
  String get benchmark_screen_models => 'Modelos de detecção de objetos';

  @override
  String get project_screen_title => 'Projeto';

  @override
  String get project_screen_exit_confirm_title => 'Confirmar saída do projeto';

  @override
  String get project_screen_exit_confirm_content => 'Sair do projeto irá interromper a contagem. Tem certeza de que deseja continuar?';

  @override
  String get project_screen_exit_button => 'Sair';

  @override
  String get project_screen_add_video_button => 'Adicionar fonte de vídeo';

  @override
  String get project_screen_from_desc => 'Mantemos um registro contínuo de 24 horas, então você pode visualizar qualquer período que precisar.';

  @override
  String get project_screen_report_settings => 'Configurações';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get filter_screen_desc => 'Selecione um intervalo de filtro da lista abaixo';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_error_content => 'O horário final deve ser maior que o horário inicial';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_start => 'Início';

  @override
  String get filter_screen_error_end => 'Fim';

  @override
  String get settings_screen_title => 'Configurações';

  @override
  String get settings_screen_desc => 'Defina nome do projeto, parâmetros de detecção e limpeza de contagens.';

  @override
  String get settings_screen_project_id => 'ID do Projeto';

  @override
  String get settings_screen_project_name => 'Nome do Projeto';

  @override
  String get settings_screen_project_name_place_holder => 'Rua Principal, 123 ou Avenida Paulista';

  @override
  String get settings_screen_project_error => 'O nome do projeto não pode estar vazio';

  @override
  String get settings_screen_random_count_button => 'Adicionar contagens aleatórias';

  @override
  String get settings_screen_reset_count_header => 'Redefinir todas as contagens neste projeto';

  @override
  String get settings_screen_reset_count_button => 'Redefinir contagens';

  @override
  String get settings_screen_reset_count_content => 'Tem certeza de que deseja redefinir todas as contagens?';

  @override
  String get settings_screen_delete_header => 'Excluir este projeto';

  @override
  String get settings_screen_delete_content => 'Tem certeza de que deseja excluir este projeto?';

  @override
  String get settings_screen_delete_button => 'Excluir';

  @override
  String get settings_screen_center_point_title => 'Ponto Central no Alvo';

  @override
  String get settings_screen_center_point_desc => 'O ponto central ajuda a determinar se o alvo está dentro da zona de detecção.';

  @override
  String get settings_screen_center_point_button => 'Mostrar Ponto Central no Alvo';

  @override
  String get settings_screen_lost_target_title => 'Alvo Perdido';

  @override
  String get settings_screen_lost_target_desc => 'Quando o rastreamento de objetos perde um alvo, esta opção o torna visível. Por padrão, alvos perdidos não são mostrados.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar Alvo Perdido';

  @override
  String get detection_screen_title => 'Configurações de Detecção';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_confidence => 'Confiança';

  @override
  String get detection_screen_confidence_desc => 'confiança acima de #0 é considerada uma detecção válida';

  @override
  String get detection_screen_low => 'Baixo';

  @override
  String get detection_screen_high => 'Alto';

  @override
  String get detection_screen_nms => 'Supressão Não-Máxima';

  @override
  String get detection_screen_nms_desc => '#0 Um limiar NMS mais baixo (ex.: 30%) removerá mais agressivamente caixas delimitadoras sobrepostas, enquanto um limiar NMS mais alto (ex.: 0.6) permitirá mais sobreposição';

  @override
  String get detection_screen_match => 'Correspondência';

  @override
  String get detection_screen_match_desc => 'Correspondência acima de #0 é considerada o mesmo objeto.';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc => 'O objeto rastreado será removido se estiver perdido por #0';

  @override
  String get detection_screen_consider_valid => 'Considerar válido após';

  @override
  String get detection_screen_consider_valid_desc => 'O objeto rastreado será considerado válido após #0';

  @override
  String get detection_screen_reset => 'Redefinir';

  @override
  String get detection_screen_reset_content => 'Tem certeza de que deseja redefinir as configurações de detecção?';

  @override
  String get url_screen_title => 'URL de transmissão ao vivo';

  @override
  String get url_screen_desc => 'Por favor, insira a URL da transmissão ao vivo';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemplo.com/transmissao ou rtsp://exemplo.com/transmissao';

  @override
  String get add_video_screen_title => 'Adicionar fonte de vídeo';

  @override
  String get add_video_screen_from => 'Adicionar fonte de vídeo a partir de';

  @override
  String get webcam_screen_add_title => 'Adicionar Webcam';

  @override
  String get webcam_screen_edit_title => 'Escolher Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Câmera Frontal';

  @override
  String get camera_screen_back_camera => 'Câmera Traseira';

  @override
  String get camera_screen_add_title => 'Adicionar Câmera';

  @override
  String get camera_screen_edit_title => 'Escolher Câmera';

  @override
  String get camera_screen_zoom_level => 'Nível de Zoom';

  @override
  String get video_screen_name_empty => 'O nome do vídeo não pode estar vazio.';

  @override
  String get video_screen_desc => 'Gerencie fontes de vídeo, adicione ou modifique zonas de detecção.';

  @override
  String get video_screen_video_name => 'Nome da fonte de vídeo';

  @override
  String get video_screen_edit_placeholder => 'Câmera da Porta da Frente ou Câmera do Estacionamento';

  @override
  String get video_screen_change_file => 'Alterar Arquivo';

  @override
  String get video_screen_add_zone => 'Adicionar zona de detecção';

  @override
  String get video_screen_zones => 'Zonas de detecção';

  @override
  String get video_screen_zones_desc => 'Use arrastar e soltar para ajustar as zonas';

  @override
  String get video_screen_tools => 'Ferramentas';

  @override
  String get video_screen_move_bottom => 'Mover zona atual para o fundo';

  @override
  String get video_screen_add_point => 'Adicionar ponto à zona atual';

  @override
  String get video_screen_remove_point => 'Remover ponto da zona atual';

  @override
  String get video_screen_playback_speed => 'Velocidade de Reprodução';

  @override
  String get video_screen_playback_current => 'atual: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Excluir esta fonte de vídeo';

  @override
  String get video_screen_delete_content => 'Tem certeza de que deseja excluir esta fonte de vídeo?';

  @override
  String get video_screen_delete_button => 'Excluir';

  @override
  String get video_screen_sources => 'Configure fonte de imagem, alvos de detecção e parâmetros do modelo.';

  @override
  String get video_screen_targets => 'Alvos de detecção';

  @override
  String get video_screen_detection => 'Parâmetros do modelo';

  @override
  String get color_screen_title => 'Escolha uma cor';

  @override
  String get zone_screen_desc => 'A zona de detecção pode definir os tipos de objetos a serem detectados e escolher quais contadores exibir, como Detectados, Criados e Entrados.';

  @override
  String get zone_screen_name_placeholder => 'O nome da zona, como Calçada ou Estacionamento';

  @override
  String get zone_screen_zone_color => 'Cor da zona';

  @override
  String get zone_screen_color => 'Cor';

  @override
  String get zone_screen_delete_header => 'Excluir esta zona';

  @override
  String get zone_screen_delete_content => 'Tem certeza de que deseja excluir esta zona?';

  @override
  String get zone_screen_delete_button => 'Excluir';

  @override
  String get zone_screen_can_not_delete => 'Não é possível excluir a zona';

  @override
  String get zone_screen_one_zone_required => 'Pelo menos uma zona é necessária.';

  @override
  String get zone_screen_zone_name_required => 'O nome da zona não pode estar vazio';

  @override
  String get counter_screen_show_on => 'Mostrar na tela';

  @override
  String get counter_screen_enabled => 'Habilitado';

  @override
  String get counter_screen_reentry_threshold => 'Limite de Reentrada';

  @override
  String get counter_screen_reentry_desc => 'Os objetos devem entrar #0 vezes, com um tempo de espera de #1 segundos entre cada saída e reentrada, para acionar a reentrada';

  @override
  String get counter_screen_reentry_title => 'Contagem de reentrada';

  @override
  String get counter_screen_cooldown_threshold => 'Limite de Tempo de Espera';

  @override
  String get counter_screen_cooldown_desc => 'A reentrada requer um tempo de espera de #0 segundos após sair da zona de detecção';

  @override
  String get counter_screen_cooldown_time => 'Tempo de Espera';

  @override
  String get counter_screen_cooldown_in_seconds => 'em segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Limite de Estagnação';

  @override
  String get counter_screen_stagnant_desc => 'Objetos que permanecerem imóveis por mais de #0 segundos serão considerados estagnados';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estagnado';

  @override
  String get counter_screen_stagnant_in_seconds => 'em segundos';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefixo de Descrição';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufixo de Descrição';

  @override
  String get counter_screen_name_error => 'O nome do contador não pode estar vazio';

  @override
  String get counter_screen_enabled_error => 'Erro';

  @override
  String get counter_screen_enabled_error_content => 'Você precisa habilitar outro contador primeiro, então poderá desabilitar este contador';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get objects_screen_desc => 'Escolha alvos de detecção como pessoa, carro, ônibus, etc.';

  @override
  String get open_project_screen_title => 'Abrir Projeto';

  @override
  String get open_project_screen_desc => 'Abra projetos criados anteriormente, mantendo apenas os 20 mais recentes.';

  @override
  String get open_project_screen_no_project => 'Nenhum projeto encontrado.';

  @override
  String get default_project_name => 'Projeto';

  @override
  String get default_video_name => 'Fonte de vídeo';

  @override
  String get default_zone_name => 'Zona de detecção';

  @override
  String get error_oops => 'Ops, algo deu errado';

  @override
  String get error_content => 'Ocorreu um erro inesperado. Gostaria de enviar um relatório por e-mail?';

  @override
  String get error_report => 'Enviar e-mail';

  @override
  String get submit => 'Enviar';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get close => 'Fechar';

  @override
  String get back => 'Voltar';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationPtPt extends AppLocalizationPt {
  AppLocalizationPtPt(): super('pt_PT');

  @override
  String get product_name => 'Contador de Visão';

  @override
  String get product_desc => 'Utilização de visão computacional e IA para contar pessoas, veículos, animais de estimação e mais.';

  @override
  String get product_copyright => 'Direitos de Autor © 2025';

  @override
  String get video_sources_webcam => 'Webcam';

  @override
  String get video_sources_live_stream => 'URL de transmissão em direto';

  @override
  String get video_sources_file => 'Ficheiro';

  @override
  String get video_sources_camera => 'Câmara';

  @override
  String get video_sources_camera_not_found_title => 'Câmara não encontrada';

  @override
  String get video_sources_camera_not_found_message => 'É necessário conceder permissão para utilizar a câmara';

  @override
  String get video_sources_webcam_not_found_title => 'Webcam não encontrada';

  @override
  String get video_sources_webcam_not_found_message => 'Por favor verifique se existe alguma webcam ligada';

  @override
  String get wizard_screen_desc => 'Crie um novo projeto abaixo para começar a contar.';

  @override
  String get wizard_screen_new_project_from => 'Novo Projeto de';

  @override
  String get wizard_screen_language => 'Idioma';

  @override
  String get wizard_screen_about => 'Sobre';

  @override
  String get wizard_screen_open_projects_tip => 'Todos os projetos serão guardados localmente de forma automática';

  @override
  String get wizard_screen_open_projects => 'Abrir projeto existente';

  @override
  String get wizard_screen_email_us => 'Enviar-nos email';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get project_view_no_videos => 'Nenhuma fonte de vídeo disponível.';

  @override
  String get about_screen_title => 'Sobre';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get about_screen_app_version => 'Versão da Aplicação';

  @override
  String get about_screen_models => 'Modelos de deteção de objetos';

  @override
  String get about_screen_benchmark => 'Benchmark';

  @override
  String get about_screen_opencv_build_info => 'Informação de Compilação OpenCV';

  @override
  String get benchmark_screen_title => 'Benchmarks dos Modelos';

  @override
  String get benchmark_screen_recommended => 'Modelo Recomendado';

  @override
  String get benchmark_screen_fps => 'FPS';

  @override
  String get benchmark_screen_start_button => 'Iniciar Benchmark';

  @override
  String get benchmark_screen_start_failed => 'Falha ao iniciar o benchmark, o código de erro é';

  @override
  String get benchmark_screen_models => 'Modelos de deteção de objetos';

  @override
  String get project_screen_title => 'Projeto';

  @override
  String get project_screen_exit_confirm_title => 'Confirmar saída do projeto';

  @override
  String get project_screen_exit_confirm_content => 'Sair do projeto irá parar a contagem. Tem a certeza que deseja continuar?';

  @override
  String get project_screen_exit_button => 'Sair';

  @override
  String get project_screen_add_video_button => 'Adicionar fonte de vídeo';

  @override
  String get project_screen_from_desc => 'Mantemos um registo contínuo de 24 horas, para que possa visualizar qualquer período de tempo necessário.';

  @override
  String get project_screen_report_settings => 'Definições';

  @override
  String get filter_screen_title => 'Filtro';

  @override
  String get filter_screen_desc => 'Selecione um intervalo de filtro da lista abaixo';

  @override
  String get filter_screen_error_title => 'Filtro';

  @override
  String get filter_screen_error_content => 'A hora de fim deve ser superior à hora de início';

  @override
  String get filter_screen_error_custom => 'Personalizado';

  @override
  String get filter_screen_error_start => 'Início';

  @override
  String get filter_screen_error_end => 'Fim';

  @override
  String get settings_screen_title => 'Definições';

  @override
  String get settings_screen_desc => 'Defina o nome do projeto, parâmetros de deteção, limpeza de contagens.';

  @override
  String get settings_screen_project_id => 'ID do Projeto';

  @override
  String get settings_screen_project_name => 'Nome do Projeto';

  @override
  String get settings_screen_project_name_place_holder => 'Rua Augusta 123 ou Parque Eduardo VII';

  @override
  String get settings_screen_project_error => 'O nome do projeto não pode estar vazio';

  @override
  String get settings_screen_random_count_button => 'Adicionar contagens aleatórias';

  @override
  String get settings_screen_reset_count_header => 'Repor todas as contagens neste projeto';

  @override
  String get settings_screen_reset_count_button => 'Repor contagens';

  @override
  String get settings_screen_reset_count_content => 'Tem a certeza que deseja repor todas as contagens?';

  @override
  String get settings_screen_delete_header => 'Eliminar este projeto';

  @override
  String get settings_screen_delete_content => 'Tem a certeza que deseja eliminar este projeto?';

  @override
  String get settings_screen_delete_button => 'Eliminar';

  @override
  String get settings_screen_center_point_title => 'Ponto Central no Alvo';

  @override
  String get settings_screen_center_point_desc => 'O ponto central ajuda a determinar se o alvo está dentro da zona de deteção.';

  @override
  String get settings_screen_center_point_button => 'Mostrar Ponto Central no Alvo';

  @override
  String get settings_screen_lost_target_title => 'Alvo Perdido';

  @override
  String get settings_screen_lost_target_desc => 'Quando o rastreamento de objetos perde um alvo, esta opção torna-o visível. Por predefinição, os alvos perdidos não são mostrados.';

  @override
  String get settings_screen_lost_target_button => 'Mostrar Alvo Perdido';

  @override
  String get detection_screen_title => 'Definições de Deteção';

  @override
  String get detection_screen_models => 'Modelos';

  @override
  String get detection_screen_confidence => 'Confiança';

  @override
  String get detection_screen_confidence_desc => 'confiança acima de #0 é considerada uma deteção válida';

  @override
  String get detection_screen_low => 'Baixa';

  @override
  String get detection_screen_high => 'Alta';

  @override
  String get detection_screen_nms => 'Supressão Não-Máxima';

  @override
  String get detection_screen_nms_desc => '#0 Um limiar NMS mais baixo (ex. 30%) irá remover mais agressivamente caixas delimitadoras sobrepostas, enquanto um limiar NMS mais alto (ex. 0,6) permitirá mais sobreposição';

  @override
  String get detection_screen_match => 'Correspondência';

  @override
  String get detection_screen_match_desc => 'Correspondência acima de #0 é considerada o mesmo objeto.';

  @override
  String get detection_screen_lost => 'Perdido';

  @override
  String get detection_screen_lost_desc => 'O objeto rastreado será removido se estiver perdido durante #0';

  @override
  String get detection_screen_consider_valid => 'Considerar válido após';

  @override
  String get detection_screen_consider_valid_desc => 'O objeto rastreado será considerado válido após #0';

  @override
  String get detection_screen_reset => 'Repor';

  @override
  String get detection_screen_reset_content => 'Tem a certeza que deseja repor as definições de deteção?';

  @override
  String get url_screen_title => 'URL de transmissão em direto';

  @override
  String get url_screen_desc => 'Por favor, introduza o URL da transmissão em direto';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_placeholder => 'http://exemplo.com/stream ou rtsp://exemplo.com/stream';

  @override
  String get add_video_screen_title => 'Adicionar fonte de vídeo';

  @override
  String get add_video_screen_from => 'Adicionar fonte de vídeo a partir de';

  @override
  String get webcam_screen_add_title => 'Adicionar Webcam';

  @override
  String get webcam_screen_edit_title => 'Escolher Webcam';

  @override
  String get webcam_manager_webcam => 'Webcam';

  @override
  String get camera_screen_front_camera => 'Câmara Frontal';

  @override
  String get camera_screen_back_camera => 'Câmara Traseira';

  @override
  String get camera_screen_add_title => 'Adicionar Câmara';

  @override
  String get camera_screen_edit_title => 'Escolher Câmara';

  @override
  String get camera_screen_zoom_level => 'Nível de Zoom';

  @override
  String get video_screen_name_empty => 'O nome do vídeo não pode estar vazio.';

  @override
  String get video_screen_desc => 'Gerir fontes de vídeo, adicionar ou modificar zonas de deteção.';

  @override
  String get video_screen_video_name => 'Nome da fonte de vídeo';

  @override
  String get video_screen_edit_placeholder => 'Câmara da Porta da Frente ou Câmara do Parque de Estacionamento';

  @override
  String get video_screen_change_file => 'Alterar Ficheiro';

  @override
  String get video_screen_add_zone => 'Adicionar zona de deteção';

  @override
  String get video_screen_zones => 'Zonas de deteção';

  @override
  String get video_screen_zones_desc => 'Use arrastar e largar para ajustar zonas';

  @override
  String get video_screen_tools => 'Ferramentas';

  @override
  String get video_screen_move_bottom => 'Mover zona atual para o fundo';

  @override
  String get video_screen_add_point => 'Adicionar ponto à zona atual';

  @override
  String get video_screen_remove_point => 'Remover ponto da zona atual';

  @override
  String get video_screen_playback_speed => 'Velocidade de Reprodução';

  @override
  String get video_screen_playback_current => 'atual: ';

  @override
  String get video_screen_playback_14x => '1/4x';

  @override
  String get video_screen_playback_2x => '2x';

  @override
  String get video_screen_delete_header => 'Eliminar esta fonte de vídeo';

  @override
  String get video_screen_delete_content => 'Tem a certeza que deseja eliminar esta fonte de vídeo?';

  @override
  String get video_screen_delete_button => 'Eliminar';

  @override
  String get video_screen_sources => 'Configurar fonte de imagem, alvos de deteção e parâmetros do modelo.';

  @override
  String get video_screen_targets => 'Alvos de deteção';

  @override
  String get video_screen_detection => 'Parâmetros do modelo';

  @override
  String get color_screen_title => 'Escolher uma cor';

  @override
  String get zone_screen_desc => 'A zona de deteção pode definir os tipos de objetos a detetar e escolher quais contadores exibir, como Detetados, Gerados e Entrados.';

  @override
  String get zone_screen_name_placeholder => 'O nome da zona, como Passeio ou Parque de Estacionamento';

  @override
  String get zone_screen_zone_color => 'Cor da zona';

  @override
  String get zone_screen_color => 'Cor';

  @override
  String get zone_screen_delete_header => 'Eliminar esta zona';

  @override
  String get zone_screen_delete_content => 'Tem a certeza que deseja eliminar esta zona?';

  @override
  String get zone_screen_delete_button => 'Eliminar';

  @override
  String get zone_screen_can_not_delete => 'Não é possível eliminar a zona';

  @override
  String get zone_screen_one_zone_required => 'É necessário pelo menos uma zona.';

  @override
  String get zone_screen_zone_name_required => 'O nome da zona não pode estar vazio';

  @override
  String get counter_screen_show_on => 'Mostrar no ecrã';

  @override
  String get counter_screen_enabled => 'Ativado';

  @override
  String get counter_screen_reentry_threshold => 'Limiar de Reentrada';

  @override
  String get counter_screen_reentry_desc => 'Os objetos devem entrar #0 vezes, com um tempo de espera de #1 segundos entre cada saída e reentrada, para acionar a reentrada';

  @override
  String get counter_screen_reentry_title => 'Contagem de reentrada';

  @override
  String get counter_screen_cooldown_threshold => 'Limiar de Tempo de Espera';

  @override
  String get counter_screen_cooldown_desc => 'A reentrada requer um tempo de espera de #0 segundos após sair da zona de deteção';

  @override
  String get counter_screen_cooldown_time => 'Tempo de Espera';

  @override
  String get counter_screen_cooldown_in_seconds => 'em segundos';

  @override
  String get counter_screen_stagnant_threshold => 'Limiar de Estagnação';

  @override
  String get counter_screen_stagnant_desc => 'Objetos que permaneçam estacionários por mais de #0 segundos serão considerados estagnados';

  @override
  String get counter_screen_stagnant_consider => 'Considerar como estagnado';

  @override
  String get counter_screen_stagnant_in_seconds => 'em segundos';

  @override
  String get counter_screen_stagnant_desc_prefix => 'Prefixo da Descrição';

  @override
  String get counter_screen_stagnant_desc_suffix => 'Sufixo da Descrição';

  @override
  String get counter_screen_name_error => 'O nome do contador não pode estar vazio';

  @override
  String get counter_screen_enabled_error => 'Erro';

  @override
  String get counter_screen_enabled_error_content => 'Precisa de ativar outro contador primeiro, depois pode desativar este contador';

  @override
  String get objects_screen_title => 'Objetos';

  @override
  String get objects_screen_desc => 'Escolha alvos de deteção como pessoa, carro, autocarro, etc.';

  @override
  String get open_project_screen_title => 'Abrir Projeto';

  @override
  String get open_project_screen_desc => 'Abrir projetos criados anteriormente, mantendo apenas os 20 mais recentes.';

  @override
  String get open_project_screen_no_project => 'Nenhum projeto encontrado.';

  @override
  String get default_project_name => 'Projeto';

  @override
  String get default_video_name => 'Fonte de vídeo';

  @override
  String get default_zone_name => 'Zona de deteção';

  @override
  String get error_oops => 'Ups, algo correu mal';

  @override
  String get error_content => 'Ocorreu um erro inesperado. Gostaria de enviar um relatório por email?';

  @override
  String get error_report => 'Enviar-nos email';

  @override
  String get submit => 'Submeter';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get close => 'Fechar';

  @override
  String get back => 'Voltar';
}
