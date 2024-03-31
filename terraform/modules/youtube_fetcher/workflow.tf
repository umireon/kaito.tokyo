locals {
  endpoints = {
    digest                   = google_cloud_run_v2_service.digest.uri
    saveSearchList           = google_cloud_run_v2_service.save_search_list.uri
    splitSearchList          = google_cloud_run_v2_service.split_search_list.uri
    generateVideoListQueries = google_cloud_run_v2_service.generate_video_list_queries.uri
    saveVideoList            = google_cloud_run_v2_service.save_video_list.uri
    splitVideoList           = google_cloud_run_v2_service.split_video_list.uri
    composeVideoList         = google_cloud_run_v2_service.compose_video_list.uri
    savePlaylistItemsList    = google_cloud_run_v2_service.save_playlist_items_list.uri
    composePlaylistItemsList = google_cloud_run_v2_service.compose_playlist_items_list.uri
  }
  buckets = {
    cache    = google_storage_bucket.cache.name
    metadata = google_storage_bucket.metadata.name
    public   = google_storage_bucket.public.name
  }
  channel_id = "UCfhyVWrxCmdUpst-5n7Kz_Q"
}

resource "google_workflows_workflow" "fetch_latest_search_list" {
  name            = "youtube-fetcher-fetch-latest-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-latest-search-list.yaml")
  user_env_vars = {
    "ENDPOINTS"            = jsonencode(local.endpoints)
    "CHANNEL_ID"           = local.channel_id
    "CACHE_BUCKET_NAME"    = google_storage_bucket.cache.name
    "METADATA_BUCKET_NAME" = google_storage_bucket.metadata.name
  }
}

resource "google_workflows_workflow" "fetch_all_search_list" {
  name            = "youtube-fetcher-fetch-all-search-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-search-list.yaml")
  user_env_vars = {
    ENDPOINTS    = jsonencode(local.endpoints)
    BUCKETS      = jsonencode(local.buckets)
    CHANNEL_IDS  = jsonencode(var.channel_ids)
    PLAYLIST_IDS = jsonencode(var.playlist_ids)
  }
}

resource "google_workflows_workflow" "fetch_all_video_list" {
  name            = "youtube-fetcher-fetch-all-video-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-video-list.yaml")
  user_env_vars = {
    ENDPOINTS    = jsonencode(local.endpoints)
    BUCKETS      = jsonencode(local.buckets)
    CHANNEL_IDS  = jsonencode(var.channel_ids)
    PLAYLIST_IDS = jsonencode(var.playlist_ids)
  }
}

resource "google_workflows_workflow" "fetch_all_playlist_items_list" {
  name            = "youtube-fetcher-fetch-all-playlist-items-list"
  region          = "asia-east1"
  service_account = google_service_account.workflow.email
  source_contents = file("${path.module}/workflows/fetch-all-playlist-items-list.yaml")
  user_env_vars = {
    ENDPOINTS    = jsonencode(local.endpoints)
    BUCKETS      = jsonencode(local.buckets)
    CHANNEL_IDS  = jsonencode(var.channel_ids)
    PLAYLIST_IDS = jsonencode(var.playlist_ids)
  }
}
