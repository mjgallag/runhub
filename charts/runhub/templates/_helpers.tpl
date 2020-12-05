{{ define "runhub.imagePrefixWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePrefix }}
{{- end }}
