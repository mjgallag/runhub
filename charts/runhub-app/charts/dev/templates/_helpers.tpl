{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ .Values.global.containerRegistryCredentials.server }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.21.0@sha256:e5522ffc195f14b0618696f51ea30c26873de21f97e75da0a588dc8c093e1f67
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.18.16-debian-10-r16@sha256:bfbbe31b7ffce4c4e7efadd88f38a816f23e5aa84f946f1d4eab26eba1713759
{{- end }}
