{{ define "runhub-app.chart" -}}
  runhub
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

{{ define "runhub-app.namespaceEnvironmentReleaseChart" -}}
  {{ template "runhub-app.environment" . }}-{{ .Release.Name }}-{{ template "runhub-app.chart" . }}
{{- end }}
