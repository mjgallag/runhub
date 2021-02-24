{{- define "runhub-app.container-registry-dockerconfigjson" }}
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

{{ define "runhub-app.environment" -}}
{{ range $environmentName, $val := .Values.global.environment -}}
  {{ $environmentName }}
{{- end }}
{{- end }}

{{ define "runhub-app.environmentDomain" -}}
{{ with .Values.global -}}
{{ if .environment.dev -}}
  {{ $.Values.dev.domain }}
{{- else if .environment.prod -}}
  {{ .prodDomain }}
{{- end }}
{{- end }}
{{- end }}
