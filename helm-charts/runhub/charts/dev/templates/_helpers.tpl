{{- define "runhub.dev.getSrcTaskStep" }}
- name: get-src
  image: gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.24.1@sha256:52358dec303aa1349c2b4f23e6e483b479ba71214ef8e94c369cfe8e25af31fb
  script: |
    /ko-app/git-init -url '$(params.git-url)' -revision '$(params.git-revision)' -path '$(workspaces.temp.path)/src'
{{- end }}

{{ define "runhub.dev.imagePathWithRegistry" -}}
  {{ with .Values.global.containerRegistryCredentials -}}
    {{ .server }}/{{ .path }}
  {{- end }}
{{- end }}

{{ define "runhub.dev.alpineImageTag" -}}
  3.13.5@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
{{- end }}

{{ define "runhub.dev.helmImageTag" -}}
  3.5.4@sha256:8662abbf9d676f62d50d2d9c4fb2e0f26c34e3476a0d58df87423294beaaa189
{{- end }}

{{ define "runhub.dev.knImageTag" -}}
  v0.23.0@sha256:1828037a709e77659fa774197056f7acbde85b348282b6cdb1e622e050bcc4e5
{{- end }}

{{ define "runhub.dev.kubectlImageTag" -}}
  1.19.12-debian-10-r0@sha256:e132fce600e903e135136ed686a0cd8ae63350390c2ce926279ca54b61df9620
{{- end }}

{{ define "runhub.dev.tknImageTag" -}}
  sha256:f69a02ef099d8915e9e4ea1b74e43b7a9309fc97cf23cb457ebf191e73491677
{{- end }}
