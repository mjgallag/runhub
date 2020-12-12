{{ define "runhub.imagePrefixWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePrefix }}
{{- end }}

{{ define "runhub.urlSuffix" -}}
  {{ .Release.Namespace }}.{{ .Values.domain }}
{{- end }}
