{{ define "runhub.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.labelBranch" -}}
  branch
{{- end }}

{{ define "runhub.namespaceReleaseChart" -}}
  {{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
