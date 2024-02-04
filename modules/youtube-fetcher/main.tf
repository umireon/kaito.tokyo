resource "google_storage_bucket" "youtube_fetcher_caches" {
  name                        = "www-kaito-tokyo-youtube-fetcher-cache"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = true
}

resource "google_service_account" "youtube_fetcher_workflow" {
  project    = var.project_id
  account_id = "youtube-fetcher-workflow"
}

resource "google_project_iam_member" "youtube_fetcher_workflow_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_workflows_workflow" "youtube_fetcher" {
  name            = "youtube-fetcher"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  source_contents = file("${path.module}/youtube-fetcher.yaml")
}

resource "google_service_account" "youtube_fetcher" {
  project    = var.project_id
  account_id = "youtube-fetcher"
}
