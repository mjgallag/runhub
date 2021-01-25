{{ define "runhub.chart" -}}
  runhub
{{- end }}

{{ define "runhub.environment" -}}
{{ range $environmentName, $val := .Values.global.environment -}}
  {{ $environmentName }}
{{- end }}
{{- end }}

{{ define "runhub.namespaceEnvReleaseChart" -}}
  {{ template "runhub.environment" . }}-{{ .Release.Name }}-{{ template "runhub.chart" . }}
{{- end }}
