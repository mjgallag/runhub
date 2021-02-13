{{ define "runhub-app.chart.name" -}}
  runhub-app
{{- end }}

{{ define "runhub-app.environment" -}}
{{ range $environmentName, $val := .Values.global.environment -}}
  {{ $environmentName }}
{{- end }}
{{- end }}

{{ define "runhub-app.environmentDomain" -}}
{{ with .Values.global -}}
{{ if .environment.dev -}}
  {{ $.Values.dev.domain }}
{{- else if .environment.prod -}}
  {{ .prodDomain }}
{{- end }}
{{- end }}
{{- end }}
