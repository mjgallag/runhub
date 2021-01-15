{{ define "runhub.dev.namespaceProdReleaseChart" -}}
  prod-{{ .Release.Name }}-runhub
{{- end }}

{{ define "runhub.dev.knImageTag" -}}
  v0.20.0@sha256:688c8d46c77ca515fdc9f0fdf6abc28178929bd07ca98df9fea2f3f2d15150fc
{{- end }}
