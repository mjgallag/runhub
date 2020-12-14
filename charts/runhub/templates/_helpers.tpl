{{ define "runhub.domainWithNamespace" -}}
  {{ .Release.Namespace }}.{{ .Values.domain }}
{{- end }}

{{ define "runhub.imagePathWithHostname" -}}
  {{ .Values.credentials.containerRegistry.hostname }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub.labelBranch" -}}
  branch
{{- end }}
