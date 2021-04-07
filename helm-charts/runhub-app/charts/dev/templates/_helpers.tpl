{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.22.0@sha256:49d88fab4deb755fa6fa8269746a81f0b2efc2dc7b65712d7e38e035dc675afb
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.18.17-debian-10-r0@sha256:5f192c565a319e5f143e03831bad9e3a0f876459572b2786eb94ad7fde847713
{{- end }}
