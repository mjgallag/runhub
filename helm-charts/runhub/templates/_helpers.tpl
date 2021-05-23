{{- define "runhub.containerRegistryDockerconfigjson" }}
apiVersion: v1
kind: Secret
metadata:
  name: container-registry-dockerconfigjson
  namespace: {{ .namespace }}
type: kubernetes.io/dockerconfigjson
stringData:
  .dockerconfigjson: |
    {{- with .top.Values.global.containerRegistryCredentials }}
    {
      "auths": {
        "{{ .server }}": {
          "username": "{{ .username }}",
          "password": "{{ js .password }}",
          "auth": "{{ print .username ":" .password | b64enc }}"
        }
      }
    }
    {{- end }}
{{- end }}

{{ define "runhub.env" -}}
  {{ range $envName, $val := .Values.global.env -}}
    {{ $envName }}
  {{- end }}
{{- end }}

{{ define "runhub.envDomain" -}}
  {{ with .Values.global -}}
    {{ if .env.dev -}}
      {{ $.Values.dev.domain }}
    {{- else if .env.prod -}}
      {{ .prodDomain }}
    {{- end }}
  {{- end }}
{{- end }}

{{- define "runhub.hosts" }}
- '*.{{ template "runhub.envDomain" $ }}'
  {{- if $.Values.global.env.dev }}
- git-webhook.runhub.{{ template "runhub.envDomain" $ }}
  {{- end }}
{{- end }}

{{ define "runhub.service-requests-cpu" -}}
  .5
{{- end }}

{{ define "runhub.service-requests-memory" -}}
  2Gi
{{- end }}
