resource "google_service_account" "gha_www_kaito_tokyo" {
  project    = var.project_id
  account_id = "gha-www-kaito-tokyo"
}

data "google_iam_policy" "gha_www_kaito_tokyo" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.pool_id}/attribute.repository/umireon/www.kaito.tokyo"
    ]
  }
}

resource "google_service_account_iam_policy" "gha_www_kaito_tokyo" {
  service_account_id = google_service_account.gha_www_kaito_tokyo.name
  policy_data        = data.google_iam_policy.gha_www_kaito_tokyo.policy_data
}

resource "google_project_iam_member" "gha_www_kaito_tokyo_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.gha_www_kaito_tokyo.email}"
}

resource "google_project_iam_member" "gha_www_kaito_tokyo_cloudfunctions_admin" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.gha_www_kaito_tokyo.email}"
}
