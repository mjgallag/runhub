{{ define "runhub.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.namespaceReleaseChart" -}}
  {{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
