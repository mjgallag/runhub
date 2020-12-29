{{ define "runhub.development.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.development.namespaceReleaseChart" -}}
  dev-{{ .Release.Name }}-runhub
{{- end }}
