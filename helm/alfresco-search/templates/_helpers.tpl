{{/*
THE TEMPLATES DEFINED BELOW WILL BE USED BY OTHER CHARTS.
"alfresco-search" IS THE CHART NAME. THE VALUE HAS TO BE HARD CODED.
".Chart.Name" CANNOT BE USED FOR THESE TEMPLATES AS THE TEMPLATE WILL BE REFERENCED FROM OTHER CHARTS.
*/}}

{{/*
Get Alfresco Search Full Name
*/}}
{{- define "alfresco-search.fullName" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get Alfresco Search Host
*/}}
{{- define "alfresco-search.host" -}}
{{- printf "%s-%s-%s" .Release.Name "alfresco-search" "solr" -}}
{{- end -}}

{{/*
Get Alfresco Search Slave Host
*/}}
{{- define "alfresco-search-slave.host" -}}
{{- printf "%s-%s-%s" .Release.Name "alfresco-search" "solr-slave" -}}
{{- end -}}

{{/*
Get Alfresco Search Port
*/}}
{{- define "alfresco-search.port" -}}
{{- print (index .Values "alfresco-search" "common" ""service" "externalPort") -}}
{{- end -}}

{{/* ======================================================================== */}}

{{/* THE TEMPLATES DEFINED BELOW ARE SUPPOSSED TO BE USED FOR THIS CHART ONLY */}}

{{/*
Get Alfresco Search Internal Port
*/}}
{{- define "alfresco-search.internalPort" -}}
{{- if and (.Values.common.type) (eq (.Values.common.type | toString) "insight-engine") }}
{{- print .Values.common.insightEngineImage.internalPort -}}
{{- else }}
{{- print .Values.common.searchServicesImage.internalPort -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.common.type) (eq (.Values.common.type | toString) "insight-engine") }}
{{- print .Values.common.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.common.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.common.type) (eq (.Values.common.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.common.insightEngineImage.repository .Values.common.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.common.searchServicesImage.repository .Values.common.searchServicesImage.tag -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Slave Docker Image
*/}}
{{- define "alfresco-search-slave.dockerImage" -}}
{{- if (.Values.slave.enabled) and (.Values.common.type) (eq (.Values.common.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.slave.insightEngineImage.repository .Values.slave.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.slave.searchServicesImage.repository .Values.slave.searchServicesImage.tag -}}
{{- end }}
{{- end -}}