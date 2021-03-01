{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ .Values.global.containerRegistryCredentials.server }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.21.0@sha256:e5522ffc195f14b0618696f51ea30c26873de21f97e75da0a588dc8c093e1f67
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.17.17-debian-10-r43@sha256:ae8fff3a1a9ca30dfcefdc2c31b8b8d73b19e067b4f46305bff6dd7d01d3204f
{{- end }}
