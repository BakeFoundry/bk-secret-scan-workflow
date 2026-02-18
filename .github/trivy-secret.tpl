{{- /* Initialize a flag to check if any secrets are found */ -}}
{{- $found := false -}}
{{- range . -}}
  {{- if .Secrets -}}
    {{- $found = true -}}
  {{- end -}}
{{- end -}}

{{- if not $found -}}
### ✅ No Secrets Found
Good job! Your code is clean.
{{- else -}}
### ⚠️ Secrets Detected
The following secrets were found in your code. Please revoke them immediately!

| Severity | Category | Secret | Location |
|:---:|:---|:---|:---|
{{- range . -}}
  {{- if .Secrets -}}
    {{- range .Secrets -}}
      {{- $sevEmoji := "⚪" -}}
      {{- if eq .Severity "CRITICAL" -}}
        {{- $sevEmoji = "🔴" -}}
      {{- else if eq .Severity "HIGH" -}}
        {{- $sevEmoji = "🟠" -}}
      {{- else if eq .Severity "MEDIUM" -}}
        {{- $sevEmoji = "🟡" -}}
      {{- else if eq .Severity "LOW" -}}
        {{- $sevEmoji = "🔵" -}}
      {{- end -}}
| {{ $sevEmoji }} {{ .Severity }} | {{ .Category }} | `{{ .Title }}` | `{{ .Target }}:{{ .StartLine }}` |
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}
