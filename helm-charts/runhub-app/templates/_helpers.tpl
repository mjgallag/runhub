{{- define "runhub-app.containerRegistryDockerconfigjson" }}
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

{{ define "runhub-app.env" -}}
  {{ range $envName, $val := .Values.global.env -}}
    {{ $envName }}
  {{- end }}
{{- end }}

{{ define "runhub-app.envDomain" -}}
  {{ with .Values.global -}}
    {{ if .env.dev -}}
      {{ $.Values.dev.domain }}
    {{- else if .env.prod -}}
      {{ .prodDomain }}
    {{- end }}
  {{- end }}
{{- end }}

{{- define "runhub-app.hosts" }}
  {{- range $serviceName, $service := .Values.global.services }}
    {{- if $.Values.global.env.dev }}
- '*.{{ $service.subdomain }}.{{ template "runhub-app.envDomain" $ }}'
    {{- else if $.Values.global.env.prod }}
- {{ $service.subdomain }}.{{ template "runhub-app.envDomain" $ }}
    {{- end }}
  {{- end }}
  {{- if $.Values.global.env.dev }}
- git-webhook.runhub.{{ template "runhub-app.envDomain" $ }}
  {{- end }}
{{- end }}
