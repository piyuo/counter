// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class LocalizationPt extends Localization {
  LocalizationPt([String locale = 'pt']) : super(locale);

  @override
  String get about_screen_app_version => 'Versão do Aplicativo';

  @override
  String get about_screen_email_us => 'Envie-nos um e-mail';

  @override
  String get about_screen_platform => 'Plataforma';

  @override
  String get appeared => 'Apareceram';

  @override
  String get appeared_help =>
      'Conta pessoas ou veículos cuja primeira posição detectada estava dentro desta área.\\n\\nÚtil para entender onde o rastreamento começa.\\n\\n(Principalmente para usuários avançados)';

  @override
  String get average_occupancy => 'Ocupação média';

  @override
  String get average_occupancy_help =>
      'Mostra o número médio de pessoas ou veículos nesta área durante a janela de contagem atual.\\n\\nAjuda a medir o movimento na área durante todo o período de contagem.';

  @override
  String get average_stay => 'Tempo médio de permanência';

  @override
  String get average_stay_help =>
      'Mostra o tempo médio que pessoas ou veículos permaneceram nesta área.\\n\\nUm tempo médio maior pode indicar que os clientes passam mais tempo nesta área.';

  @override
  String get camera_test_screen_help =>
      'O Piyuo Counter usa a câmera e a IA no dispositivo para contar pessoas. Primeiro, vamos verificar se o seu dispositivo é compatível.';

  @override
  String get camera_test_screen_instruction =>
      'Aponte a câmera para pessoas. O aplicativo desenhará caixas ao redor de quem detectar.';

  @override
  String get camera_test_screen_next => 'Toque em Seguinte para continuar.';

  @override
  String get camera_test_screen_start =>
      'Toque em Iniciar. Se solicitado, permita o acesso à câmera.';

  @override
  String get camera_test_screen_test_failed => 'Teste falhou!';

  @override
  String get camera_test_screen_test_passed => 'Teste concluído!';

  @override
  String get camera_test_screen_title => 'Teste da câmera com IA';

  @override
  String get camera_test_screen_wait => 'Aguardando a IA detectar pessoas…';

  @override
  String get cta_screen_custom => 'Usar seu próprio servidor';

  @override
  String get cta_screen_custom_help =>
      'Envie os dados de tráfego diretamente para seu backend ou banco de dados.';

  @override
  String get cta_screen_footer =>
      'Ao continuar, você concorda com os Termos de Serviço, a Política de Privacidade e o Acordo de Processamento de Dados.';

  @override
  String get cta_screen_invitation => 'Usar um código de convite';

  @override
  String get cta_screen_invitation_help =>
      'Entre em uma organização existente usando um convite do administrador.';

  @override
  String get cta_screen_local => 'Apenas neste dispositivo';

  @override
  String get cta_screen_local_help =>
      'Armazene os dados de tráfego apenas neste dispositivo. Nada é enviado.';

  @override
  String get cta_screen_piyuo => 'Usar Piyuo Cloud';

  @override
  String get cta_screen_piyuo_help =>
      'Armazene dados de tráfego no Piyuo Cloud com painéis e insights de negócios.';

  @override
  String get cta_screen_premium => 'Premium';

  @override
  String get cta_screen_title =>
      'O Piyuo Counter cria estatísticas anônimas de tráfego a cada 5 minutos.\\nEscolha como deseja armazenar e acessar seus dados.';

  @override
  String get current_occupancy => 'Contagem atual';

  @override
  String get current_occupancy_help =>
      'Mostra a contagem atual de pessoas ou veículos nesta área.\\n\\nEsse número é atualizado em tempo real e ajuda a verificar se a detecção por IA corresponde ao que você vê na tela. Ele não é incluído nos dados de telemetria enviados.';

  @override
  String get custom_server_screen_bearer_saving_action => 'Salvando...';

  @override
  String get custom_server_screen_server_url_label => 'URL do servidor';

  @override
  String get detection_screen_confidence => 'Limite de confiança';

  @override
  String get detection_screen_confidence_dialog =>
      'Controla o quão certa a IA precisa estar antes de contar uma pessoa ou veículo.\\nValores mais baixos\\n• Detectam mais objetos\\n• Melhores para objetos distantes ou parcialmente escondidos\\n• Podem aumentar detecções falsas\\nValores mais altos\\n• Contam apenas detecções de alta confiança\\n• Reduzem detecções falsas\\n• Podem perder objetos pequenos ou difíceis\\nUse um valor mais baixo se o app estiver perdendo pessoas ou veículos.\\nUse um valor mais alto se o app estiver contando sombras, reflexos ou outros objetos falsos.';

  @override
  String get detection_screen_confidence_help =>
      'Confiança mínima necessária para detectar um objeto.';

  @override
  String get detection_screen_confidence_max_label => 'Rigoroso';

  @override
  String get detection_screen_confidence_min_label => 'Flexível';

  @override
  String get detection_screen_disappear => 'Tempo limite para desaparecimento';

  @override
  String get detection_screen_disappear_dialog =>
      'Determina quanto tempo a IA espera antes de marcar um objeto como desaparecido depois que ele deixa de ser detectado.\\nValores mais curtos\\n• Marcam objetos como desaparecidos mais rápido\\n• Melhor para tráfego rápido\\n• Podem marcar objetos temporariamente escondidos como desaparecidos\\nValores mais longos\\n• Esperam mais antes de marcar objetos como desaparecidos\\n• Melhor quando objetos são brevemente bloqueados ou perdidos\\n• Atrasam eventos de desaparecimento';

  @override
  String get detection_screen_disappear_help =>
      'Quanto tempo a IA espera antes de marcar um objeto como desaparecido depois que deixa de detectá-lo.';

  @override
  String get detection_screen_disappear_max_label => 'Lento';

  @override
  String get detection_screen_disappear_min_label => 'Rápido';

  @override
  String get detection_screen_memory_dialog =>
      'Controla por quanto tempo a IA lembra um objeto depois que ele desaparece.\\nAumente este valor se pessoas ou veículos ficarem frequentemente escondidos atrás de outros objetos.\\nDiminua este valor se os objetos forem vinculados incorretamente após deixarem a cena.';

  @override
  String get detection_screen_min_presence => 'Tempo mínimo de presença';

  @override
  String get detection_screen_min_presence_help =>
      'Um objeto deve permanecer visível antes de ser contado. Valores maiores ajudam a reduzir falsas detecções de curta duração.';

  @override
  String get detection_screen_min_presence_max_label => 'Mais seguro';

  @override
  String get detection_screen_min_presence_min_label => 'Mais rápido';

  @override
  String get detection_screen_minimum_visible =>
      'Os objetos devem permanecer visíveis por esse tempo antes de serem contados.\\nAumente este valor para ignorar detecções falsas breves.\\nDiminua este valor se pessoas ou veículos em movimento rápido estiverem sendo perdidos.';

  @override
  String get detection_screen_new_track => 'Limite para novo rastreamento';

  @override
  String get detection_screen_new_track_help =>
      'Confiança mínima necessária para começar a rastrear um novo objeto. Valores baixos podem criar rastreamentos duplicados.';

  @override
  String get detection_screen_new_track_max_label => 'Conservador';

  @override
  String get detection_screen_new_track_min_label => 'Agressivo';

  @override
  String get detection_screen_reset => 'Redefinir';

  @override
  String get detection_screen_reset_content =>
      'Tem certeza de que deseja redefinir as configurações de detecção?';

  @override
  String get detection_screen_show_track_id => 'Mostrar ID de rastreamento';

  @override
  String get detection_screen_show_track_id_help =>
      'Ative essa opção para mostrar IDs de rastreamento exclusivos para cada objeto rastreado.';

  @override
  String get detection_screen_stay => 'Tempo de permanência';

  @override
  String get detection_screen_stay_help =>
      'Por quanto tempo um objeto deve permanecer na área antes de ser contado como permanência.';

  @override
  String get detection_screen_stay_max_label => 'Atrasado';

  @override
  String get detection_screen_stay_min_label => 'Imediato';

  @override
  String get detection_screen_stay_threshold =>
      'Determina quando um objeto contribui para a contagem de Permanência.\\nValores mais curtos\\n• Contam a permanência imediatamente\\n• Melhor para análise rápida\\nValores mais longos\\n• Ignoram tráfego breve de passagem\\n• Melhor para medir ocupação';

  @override
  String get detection_screen_subtitle =>
      'Ajuste como a IA detecta e acompanha objetos.';

  @override
  String get detection_screen_title => 'Rastreamento e contagem';

  @override
  String get detection_screen_track_dialog =>
      'Controla quando um objeto recém-detectado se torna uma nova trilha.\\nValores mais baixos\\n• O rastreamento começa mais cedo\\n• Melhor para objetos que se movem rápido\\n• Podem criar trilhas duplicadas\\nValores mais altos\\n• Exigem evidências mais fortes antes de criar uma nova trilha\\n• Reduzem trilhas duplicadas\\n• Podem atrasar o rastreamento de novos objetos';

  @override
  String get detection_screen_track_memory => 'Memória de rastreamento';

  @override
  String get detection_screen_track_memory_help =>
      'Por quanto tempo continuar rastreando um objeto após perdê-lo temporariamente. Valores maiores ajudam a recuperar o rastreamento após breves obstruções.';

  @override
  String get detection_screen_track_memory_max_label => 'Longo';

  @override
  String get detection_screen_track_memory_min_label => 'Curto';

  @override
  String get device_not_supported_screen_body =>
      'O Piyuo Counter usa a câmera para detectar pedestres e veículos em tempo real. Este dispositivo não possui uma câmera disponível.';

  @override
  String get device_not_supported_screen_footer_hint =>
      'Tente abrir este aplicativo no seu telefone';

  @override
  String get device_not_supported_screen_requirement_camera =>
      'Um smartphone ou tablet com câmera';

  @override
  String get device_not_supported_screen_requirement_platform =>
      'Recomenda-se um dispositivo iOS ou Android';

  @override
  String get device_not_supported_screen_requirements_title =>
      'O que você precisa';

  @override
  String get device_not_supported_screen_title => 'Câmera não encontrada';

  @override
  String get disappeared => 'Desapareceram';

  @override
  String get disappeared_help =>
      'Conta pessoas ou veículos cuja última posição detectada estava dentro desta área.\\n\\nO rastreamento termina após o Tempo de Desaparecimento configurado caso a pessoa ou o veículo deixe de ser detectado.\\n\\n(Principalmente para usuários avançados)';

  @override
  String get dpa => 'Acordo de Processamento de Dados';

  @override
  String get durationDaysShort => '%sd';

  @override
  String get durationHoursShort => '%sh';

  @override
  String get durationMinutesShort => '%smin';

  @override
  String get durationSecondsShort => '%ss';

  @override
  String get durationTwoUnit => '%first %second';

  @override
  String get entered => 'Entraram';

  @override
  String get entered_help =>
      'Conta pessoas ou veículos que entraram nesta área durante a janela de contagem atual.\\n\\nUma entrada é registrada quando uma pessoa ou veículo passa de fora para dentro da área.';

  @override
  String get exited => 'Saíram';

  @override
  String get exited_help =>
      'Conta pessoas ou veículos que saíram desta área durante a janela de contagem atual.\\n\\nUma saída é registrada quando uma pessoa ou veículo passa de dentro para fora da área.';

  @override
  String get language_screen_language => 'Idioma';

  @override
  String get language_screen_subtitle =>
      'Escolha o idioma usado no aplicativo.';

  @override
  String get local_only_screen_body =>
      'O modo Somente dispositivo local permite testar a detecção e o rastreamento por câmera com IA sem enviar nenhum dado. Todas as estatísticas de fluxo de pessoas são processadas apenas neste dispositivo, ideal para testar antes de conectar a um servidor.';

  @override
  String get local_only_screen_use_action => 'Usar apenas o dispositivo local';

  @override
  String get local_screen_text =>
      'O Piyuo Counter funcionará totalmente neste dispositivo.\\nAs estatísticas de tráfego serão armazenadas apenas neste dispositivo e não serão enviadas.\\nMais tarde você poderá conectar-se ao Piyuo Cloud ou ao seu próprio servidor em Configurações.';

  @override
  String get maximum_occupancy => 'Ocupação máxima';

  @override
  String get maximum_occupancy_help =>
      'Mostra o maior número de pessoas ou veículos presentes ao mesmo tempo nesta área durante a janela de contagem atual.\\n\\nÚtil para identificar horários de maior movimento.';

  @override
  String get maximum_stay => 'Tempo máximo de permanência';

  @override
  String get maximum_stay_help =>
      'Mostra o maior tempo que uma pessoa ou veículo permaneceu nesta área durante a janela de contagem atual.\\n\\nÚtil para identificar visitas ou paradas incomumente longas.';

  @override
  String get metric_events => 'Eventos';

  @override
  String get metric_live => 'Ao vivo';

  @override
  String get metric_show_less => 'Mostrar menos';

  @override
  String get metric_show_more => 'Mostrar mais';

  @override
  String get metric_statistics => 'Estatísticas';

  @override
  String get metrics_counting_all => 'Todos';

  @override
  String get metrics_counting_done => 'Concluído';

  @override
  String get metrics_counting_in_progress => 'Em andamento';

  @override
  String get metrics_counting_missing => 'Ausente';

  @override
  String get metrics_counting_window =>
      'Estatísticas de cada período de 5 minutos';

  @override
  String get onboarding_back_action => 'Voltar';

  @override
  String get onboarding_cta_no_server => 'Prefere não enviar dados?';

  @override
  String get onboarding_cta_title => 'Para onde seus dados devem ir?';

  @override
  String get onboarding_intro_text1 =>
      'O Piyuo Counter usa a câmera do seu aparelho e uma IA integrada para identificar pessoas e veículos em tempo real.\\nCom tecnologia de detecção e rastreamento, ele conta automaticamente o fluxo de pedestres e veículos — tudo processado direto no seu aparelho.';

  @override
  String get onboarding_intro_text2 =>
      'Todo o processamento de IA acontece localmente no seu aparelho. Nenhum vídeo, imagem, rosto ou identidade é enviado.\\nApenas resumos anônimos a cada 5 minutos são compartilhados, incluindo estatísticas de contagem, ocupação, entradas, saídas e tempo de permanência.';

  @override
  String get onboarding_intro_text3 =>
      'Basta iniciar o app e deixá-lo funcionando. O Piyuo Counter coleta e armazena os dados de tráfego automaticamente e sem parar.\\nOs resumos de dados são salvos a cada 5 minutos e enviados a cada hora para o Piyuo Cloud ou para o seu próprio servidor.';

  @override
  String get onboarding_intro_title1 => 'Contagem de tráfego com IA';

  @override
  String get onboarding_intro_title2 => 'Privacidade desde o início';

  @override
  String get onboarding_intro_title3 => 'Funciona automaticamente 24/7';

  @override
  String get onboarding_next_action => 'Seguinte';

  @override
  String get onboarding_skip_action => 'Pular introdução';

  @override
  String get onboarding_start_action => 'Começar';

  @override
  String get passed_by => 'Passaram';

  @override
  String get passed_by_help =>
      'Conta as pessoas ou veículos que passaram por esta área durante a janela de contagem atual.\\n\\nCada pessoa ou veículo é contado apenas uma vez por passagem pela área.';

  @override
  String get payloads_screen_area => 'Área';

  @override
  String get payloads_screen_confidence => 'Confiança';

  @override
  String get payloads_screen_coverage => 'Cobertura';

  @override
  String get payloads_screen_delivered => 'Entregue';

  @override
  String get payloads_screen_failed_load =>
      'Falha ao carregar payloads recentes';

  @override
  String get payloads_screen_frame_processed => 'Quadros processados';

  @override
  String get payloads_screen_hour_not_exists => 'Esta hora não existe mais.';

  @override
  String get payloads_screen_missing_time => 'Tempo ausente';

  @override
  String get payloads_screen_no_payloads => 'Ainda não há payloads.';

  @override
  String get payloads_screen_partial => 'Janela terminou mais cedo (parcial)';

  @override
  String get payloads_screen_partially => 'Entregue parcialmente';

  @override
  String get payloads_screen_payload_not_exists =>
      'Este payload não existe mais.';

  @override
  String get payloads_screen_pending => 'Pendente de entrega';

  @override
  String get payloads_screen_process_fps => 'FPS de processamento';

  @override
  String get payloads_screen_resend => 'Reenviar';

  @override
  String get payloads_screen_select_first =>
      'Selecione primeiro pelo menos uma data ou hora.';

  @override
  String get payloads_screen_subtitle =>
      'Selecione por data ou hora para reenviar';

  @override
  String get payloads_screen_title => 'Payloads recentes';

  @override
  String get personal_custom_screen_build_server =>
      'Precisa de ajuda para configurar seu próprio servidor?\\nVeja nossa documentação da API e exemplos de servidor.';

  @override
  String get personal_custom_screen_help_action => 'Abrir documentação da API';

  @override
  String get personal_custom_screen_reset_action => 'Começar novamente';

  @override
  String get personal_custom_success_screen_help =>
      'Toque em Start abaixo para começar a contagem.';

  @override
  String get personal_custom_success_screen_help1 =>
      'As estatísticas de tráfego são enviadas automaticamente a cada hora.\\nVocê também pode enviá-las manualmente na tela de Logs de Upload.';

  @override
  String get personal_custom_success_screen_help2 =>
      'Seu servidor ainda não precisa estar online.\\nComece a contar agora. Você pode terminar de configurar e testar seu servidor depois. As estatísticas de tráfego permanecerão neste dispositivo até serem enviadas com sucesso.';

  @override
  String get personal_custom_success_screen_send_to =>
      'As estatísticas de tráfego serão enviadas para';

  @override
  String get personal_custom_success_screen_title => 'Seu servidor está pronto';

  @override
  String get piyuo_server_screen_cloud_url_label => 'Seu URL do Piyuo Cloud';

  @override
  String get piyuo_server_screen_copy_action => 'Copiar URL';

  @override
  String get piyuo_server_screen_copy_success => 'URL copiada';

  @override
  String get piyuo_server_screen_saving_action => 'Salvando...';

  @override
  String get piyuo_server_screen_start =>
      'Pressione \"Start\" abaixo para começar a contagem.';

  @override
  String get piyuo_server_screen_url_help =>
      'Seu painel pessoal do Piyuo Cloud está disponível neste URL.';

  @override
  String get piyuo_server_screen_url_remember =>
      'Salve este URL para acessar seu painel de tráfego em outro dispositivo.';

  @override
  String get piyuo_server_screen_use_action => 'Usar Piyuo Cloud';

  @override
  String get privacy => 'Política de Privacidade';

  @override
  String get product_copyright => 'Copyright © 2026';

  @override
  String get product_desc => 'Contagem de pessoas e veículos com IA.';

  @override
  String get settings_screen_custom_subtitle =>
      'Envie dados de tráfego diretamente para seu backend ou banco de dados.';

  @override
  String get settings_screen_custom_title => 'Usar servidor personalizado';

  @override
  String get settings_screen_data_server_label => 'Servidor de dados';

  @override
  String get settings_screen_detection_target => 'Alvo da detecção';

  @override
  String get settings_screen_language_title => 'Idioma';

  @override
  String get settings_screen_local_subtitle =>
      'Armazene os dados de tráfego apenas neste dispositivo. Nada será enviado.';

  @override
  String get settings_screen_local_title => 'Apenas dispositivo local';

  @override
  String get settings_screen_misc_label => 'Diversos';

  @override
  String get settings_screen_object_detection => 'Detecção de objetos';

  @override
  String get settings_screen_piyuo_subtitle =>
      'Armazene seus dados de tráfego no Piyuo Cloud com painéis e insights de negócios.';

  @override
  String get settings_screen_piyuo_title => 'Piyuo Cloud';

  @override
  String get settings_screen_reset_all_data_body =>
      'Isto apagará todos os dados e recomeçará do zero. Esta ação não pode ser desfeita.';

  @override
  String get settings_screen_reset_all_data_title =>
      'Redefinir todos os dados?';

  @override
  String get settings_screen_subscription_body =>
      'Gerencie sua assinatura e os dados de cobrança';

  @override
  String get settings_screen_subscription_title => 'Assinatura';

  @override
  String get start_screen_about => 'Sobre';

  @override
  String get start_screen_server_none =>
      'Os dados ficam apenas neste dispositivo';

  @override
  String get start_screen_server_personal =>
      'Os dados são enviados a cada hora para';

  @override
  String get start_screen_settings => 'Configurações';

  @override
  String get start_screen_upload_logs => 'Enviar registros';

  @override
  String get start_screen_video_sources => 'Fontes de vídeo';

  @override
  String get stayed => 'Permaneceram';

  @override
  String get stayed_help =>
      'Conta pessoas ou veículos que permaneceram nesta área por pelo menos o Tempo de Permanência configurado.\\n\\nO Tempo de Permanência padrão é de 15 segundos e pode ser alterado nas Configurações.';

  @override
  String get target_pedestrian => 'Pedestre';

  @override
  String get target_pedestrian_help =>
      'Conte pessoas usando o modelo de detecção de pedestres';

  @override
  String get target_screen_subtitle =>
      'Escolha o modelo de detecção que deseja usar';

  @override
  String get target_vehicle => 'Veículo';

  @override
  String get target_vehicle_help =>
      'Conte carros e outros veículos usando o modelo de veículos';

  @override
  String get telemetry_error_connection_refused =>
      'Não foi possível conectar ao servidor. Ele pode estar offline no momento.';

  @override
  String get telemetry_error_connection_reset =>
      'A conexão foi reiniciada. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get telemetry_error_connection_timeout =>
      'A conexão demorou muito para responder. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get telemetry_error_database_error =>
      'Falha ao gravar no banco de dados.';

  @override
  String get telemetry_error_dns_lookup_failed =>
      'Não foi possível encontrar o endereço do servidor. Verifique sua conexão com a internet ou a URL do servidor.';

  @override
  String get telemetry_error_http_error_status =>
      'O servidor rejeitou a solicitação. Tente novamente mais tarde.';

  @override
  String get telemetry_error_http_unknown_error =>
      'Ocorreu um erro inesperado ao se comunicar com o servidor.';

  @override
  String get telemetry_error_invalid_url =>
      'O endereço do servidor é inválido. Verifique suas configurações.';

  @override
  String get telemetry_error_network_error =>
      'Ocorreu um erro de rede. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get telemetry_error_socket_error =>
      'Ocorreu um problema de conexão de rede. Verifique sua conexão com a internet.';

  @override
  String get telemetry_error_transport_exception =>
      'Algo deu errado ao enviar os dados. Tente novamente.';

  @override
  String get telemetry_error_unknown_error => 'Ocorreu um erro inesperado.';

  @override
  String get terms => 'Termos de Serviço';

  @override
  String get upload_screen_attempt_time => 'Hora da tentativa:';

  @override
  String get upload_screen_error => 'Erro:';

  @override
  String get upload_screen_failed => 'Falhou';

  @override
  String get upload_screen_load_error =>
      'Falha ao carregar os registros de envio.';

  @override
  String get upload_screen_log_not_exists =>
      'O registro de envio não está mais disponível.';

  @override
  String get upload_screen_next => 'Próximo envio às ...';

  @override
  String get upload_screen_next_upload_prefix => 'Próximo envio às ';

  @override
  String get upload_screen_no_data_server =>
      'Configure primeiro o servidor de dados.';

  @override
  String get upload_screen_no_logs => 'Ainda não há registros de envio.';

  @override
  String get upload_screen_payload_count => 'Quantidade de payloads';

  @override
  String get upload_screen_payload_count_label => 'Quantidade de payloads:';

  @override
  String get upload_screen_payload_size => 'Tamanho do payload:';

  @override
  String get upload_screen_result => 'Resultado:';

  @override
  String get upload_screen_retry => 'Número de tentativas:';

  @override
  String get upload_screen_size_kb => 'KB';

  @override
  String get upload_screen_success => 'Sucesso';

  @override
  String get upload_screen_today => 'Hoje';

  @override
  String get upload_screen_upload_now => 'Enviar agora';

  @override
  String get upload_screen_upload_success => 'Envio concluído.';

  @override
  String get upload_screen_uploading => 'Enviando...';

  @override
  String get upload_screen_yesterday => 'Ontem';

  @override
  String get url_screen_invalid_rtsp_error =>
      'URLs RTSP devem incluir um nome de host.';

  @override
  String get url_screen_invalid_url_error =>
      'Insira uma URL válida com um esquema suportado.';

  @override
  String get url_screen_subtitle =>
      'Por favor, insira a URL da transmissão ao vivo';

  @override
  String get url_screen_title => 'URL de transmissão ao vivo';

  @override
  String get url_screen_unsupported_scheme_error => ' HTTPS';

  @override
  String get url_screen_url => 'URL';

  @override
  String get url_screen_url_empty_error =>
      'Insira uma URL de transmissão ao vivo.';

  @override
  String get url_screen_url_hint =>
      'http://example.com/stream or rtsp://example.com/stream';

  @override
  String get url_screen_url_placeholder =>
      'http://exemplo.com/transmissao ou rtsp://exemplo.com/transmissao';

  @override
  String get video_sources_back_camera => 'Câmera traseira';

  @override
  String get video_sources_camera => 'Câmera';

  @override
  String get video_sources_file => 'Arquivo';

  @override
  String get video_sources_front_camera => 'Câmera frontal';

  @override
  String get video_sources_live_stream => 'URL de transmissão ao vivo';

  @override
  String get video_sources_screen_camera_not_found_message =>
      'É necessário conceder permissão para usar a câmera';

  @override
  String get video_sources_screen_camera_not_found_title =>
      'Câmera não encontrada';

  @override
  String get video_sources_screen_import_error =>
      'Não foi possível importar o arquivo de vídeo.';

  @override
  String get video_sources_screen_photos_denied_msg =>
      'Vá para configurações e permita o acesso a fotos para este aplicativo.';

  @override
  String get video_sources_screen_select_camera =>
      'Toque para selecionar esta câmera';

  @override
  String get video_sources_screen_select_file =>
      'Toque para escolher um arquivo';

  @override
  String get video_sources_screen_select_live =>
      'Toque para definir a URL da transmissão ao vivo';

  @override
  String get video_sources_webcam => 'Webcam';
}
