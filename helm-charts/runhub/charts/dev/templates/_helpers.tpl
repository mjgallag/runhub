{{ define "runhub.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub.dev.knImageTag" -}}
  v0.22.0@sha256:49d88fab4deb755fa6fa8269746a81f0b2efc2dc7b65712d7e38e035dc675afb
{{- end }}

{{ define "runhub.dev.kubectlImageTag" -}}
  1.18.18-debian-10-r0@sha256:5c706851c97c092bfba87d4bcbd7267212a471e0deab16481ebd5abef52fa583
{{- end }}
