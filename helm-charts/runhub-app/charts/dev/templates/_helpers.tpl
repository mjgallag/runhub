{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.21.0@sha256:e5522ffc195f14b0618696f51ea30c26873de21f97e75da0a588dc8c093e1f67
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.18.17-debian-10-r0@sha256:5f192c565a319e5f143e03831bad9e3a0f876459572b2786eb94ad7fde847713
{{- end }}
