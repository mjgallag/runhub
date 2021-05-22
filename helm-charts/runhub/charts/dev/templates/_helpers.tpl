{{ define "runhub.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub.dev.alpineImageTag" -}}
  3.13.5@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
{{- end }}

{{ define "runhub.dev.knImageTag" -}}
  v0.23.0@sha256:1828037a709e77659fa774197056f7acbde85b348282b6cdb1e622e050bcc4e5
{{- end }}

{{ define "runhub.dev.kubectlImageTag" -}}
  1.19.11-debian-10-r0@sha256:a58c5bc8981f97f0a2dc235d31d04978d196aa9e6115df1fd06fefba078b0c7c
{{- end }}
