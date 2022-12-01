variable "region" {
  type        = string
  description = "GCP Region"
  default     = "us-central1"
}

variable "attribute_mapping" {
  type        = map(any)
  description = "Workload Identity Pool Provider attribute mapping. [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_mapping)"
  default = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
}

variable "repo_org" {
  type        = string
  description = "Name of org repo belongs to"
}

variable "repo_name" {
  type        = string
  description = "Name of repo"
}

variable "project_id" {
  type = string
}
