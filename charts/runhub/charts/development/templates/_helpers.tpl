{{ define "runhub.development.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}
