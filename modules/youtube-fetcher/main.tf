locals {
  channel_id                        = "UCfhyVWrxCmdUpst-5n7Kz_Q"
  cloudflare_pages_builder_sa_email = "cloudflare-pages-builder@www-kaito-tokyo.iam.gserviceaccount.com"
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

resource "google_project_iam_member" "youtube_fetcher_workflow_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket" "youtube_fetcher_cache" {
  name                        = "www-kaito-tokyo-youtube-fetcher-cache"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_cache_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket" "youtube_fetcher_metadata" {
  name                        = "www-kaito-tokyo-youtube-fetcher-metadata"
  location                    = "asia-east1"
  project                     = var.project_id
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_workflow_youtube_fetcher_metadata_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher_workflow.email}"
}

resource "google_storage_bucket_iam_member" "cloudflare_youtube_fetcher_metadata_object_viewer" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${local.cloudflare_pages_builder_sa_email}"
}

locals {
  workflow_env_vars = {
    CHANNEL_ID           = local.channel_id,
    CACHE_BUCKET_NAME    = google_storage_bucket.youtube_fetcher_cache.name,
    METADATA_BUCKET_NAME = google_storage_bucket.youtube_fetcher_metadata.name
  }
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "fetch-latest-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "fetch-all-search-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
}

resource "google_workflows_workflow" "fetch_all_videos_list" {
  name            = "fetch-all-videos-list"
  project         = var.project_id
  region          = "asia-east1"
  service_account = google_service_account.youtube_fetcher_workflow.email
  user_env_vars   = local.workflow_env_vars
  source_contents = file("${path.module}/workflows/fetch-all-videos-list.yaml")
}

resource "google_service_account" "youtube_fetcher" {
  project    = var.project_id
  account_id = "youtube-fetcher"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_cache_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_cache.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher.email}"
}

resource "google_storage_bucket_iam_member" "youtube_fetcher_metadata_object_user" {
  bucket = google_storage_bucket.youtube_fetcher_metadata.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.youtube_fetcher.email}"
}
