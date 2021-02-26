{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ .Values.global.containerRegistryCredentials.server }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.21.0@sha256:e5522ffc195f14b0618696f51ea30c26873de21f97e75da0a588dc8c093e1f67
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.17.17-debian-10-r31@sha256:f9f62968fdebada37240489bc595c59604892ea43384f69e4f2cc6ee6a9e1775
{{- end }}
