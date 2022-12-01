resource "google_service_account" "default" {
  account_id   = "${var.repo_namne}-github-sa"
  display_name = "Github Actions Service Account for repo: ${var.repo_name}"
}

resource "google_iam_workload_identity_pool" "default" {
  project                   = var.project_id
  provider                  = google-beta
  workload_identity_pool_id = "${var.repo_name}-github-pool"
  description               = "Workload ID Pool for use with Github Actions on ${var.repo_org}/${var.repo_name}"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "default" {
  project                            = var.project_id
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.workload_id_pool_id}-provider"
  description                        = "Workload ID OIDC Provider for Github Actions on ${var.repo_org}/${var.repo_name}"
  attribute_condition                = "attribute.repository=='${var.repo_org}/${var.repo_name}'"
  attribute_mapping                  = var.attribute_mapping
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "github-sa" {
  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.default.name}/*"
}