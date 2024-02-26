resource "google_secret_manager_secret_iam_member" "functions_cdn_access_key_id" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.cdn_access_key_id.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.newt_www_kaito_tokyo.email}"
}

resource "google_secret_manager_secret_iam_member" "functions_cdn_secret_access_key" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.cdn_secret_access_key.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.newt_www_kaito_tokyo.email}"
}
