{{ define "runhub.appImagePrefixWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.app.imagePrefix }}
{{- end }}
