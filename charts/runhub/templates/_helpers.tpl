{{ define "runhub.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.urlSuffix" -}}
  {{ .Release.Namespace }}.{{ .Values.domain }}
{{- end }}
