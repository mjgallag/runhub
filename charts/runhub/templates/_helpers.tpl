{{ define "runhub.environment" -}}
{{ range $environmentName, $val := .Values.global.environment -}}
  {{ $environmentName }}
{{- end }}
{{- end }}

{{ define "runhub.imagePathWithHostname" -}}
  {{ .Values.global.containerRegistryCredentials.server }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.namespaceReleaseChart" -}}
  {{ template "runhub.environment" . }}-{{ .Release.Name }}-runhub
{{- end }}
