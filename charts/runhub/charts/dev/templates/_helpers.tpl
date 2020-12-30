{{ define "runhub.dev.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.dev.namespaceReleaseChart" -}}
  dev-{{ .Release.Name }}-runhub
{{- end }}
