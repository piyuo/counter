import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

/// Maps [TelemetryErrorCode] to its localized, user-facing message.
extension TelemetryErrorCodeL10n on core_domain.TelemetryErrorCode {
  String localizedMessage(BuildContext context) {
    switch (this) {
      case core_domain.TelemetryErrorCode.connectionRefused:
        return context.l.telemetry_error_connection_refused;
      case core_domain.TelemetryErrorCode.dnsLookupFailed:
        return context.l.telemetry_error_dns_lookup_failed;
      case core_domain.TelemetryErrorCode.socketError:
        return context.l.telemetry_error_socket_error;
      case core_domain.TelemetryErrorCode.networkError:
        return context.l.telemetry_error_network_error;
      case core_domain.TelemetryErrorCode.invalidUrl:
        return context.l.telemetry_error_invalid_url;
      case core_domain.TelemetryErrorCode.connectionTimeout:
        return context.l.telemetry_error_connection_timeout;
      case core_domain.TelemetryErrorCode.connectionReset:
        return context.l.telemetry_error_connection_reset;
      case core_domain.TelemetryErrorCode.httpErrorStatus:
        return context.l.telemetry_error_http_error_status;
      case core_domain.TelemetryErrorCode.transportException:
        return context.l.telemetry_error_transport_exception;
      case core_domain.TelemetryErrorCode.httpUnknownError:
        return context.l.telemetry_error_http_unknown_error;
      case core_domain.TelemetryErrorCode.databaseError:
        return context.l.telemetry_error_database_error;
      case core_domain.TelemetryErrorCode.unknownError:
        return context.l.telemetry_error_unknown_error;
    }
  }
}
