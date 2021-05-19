{{ define "runhub.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub.dev.knImageTag" -}}
  v0.22.0@sha256:49d88fab4deb755fa6fa8269746a81f0b2efc2dc7b65712d7e38e035dc675afb
{{- end }}

{{ define "runhub.dev.kubectlImageTag" -}}
  1.19.11-debian-10-r0@sha256:a58c5bc8981f97f0a2dc235d31d04978d196aa9e6115df1fd06fefba078b0c7c
{{- end }}
