{{ define "runhub-app.dev.imagePathWithRegistry" -}}
  {{ .Values.global.containerRegistryCredentials.server }}/{{ .Values.imagePath }}
{{- end }}

{{ define "runhub-app.dev.knImageTag" -}}
  v0.20.0@sha256:688c8d46c77ca515fdc9f0fdf6abc28178929bd07ca98df9fea2f3f2d15150fc
{{- end }}

{{ define "runhub-app.dev.kubectlImageTag" -}}
  1.17.17-debian-10-r31@sha256:f9f62968fdebada37240489bc595c59604892ea43384f69e4f2cc6ee6a9e1775
{{- end }}
