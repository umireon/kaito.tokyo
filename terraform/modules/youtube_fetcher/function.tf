data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../.."
  excludes    = [".git"]
  output_path = "${var.tmp_dir}/function-source-youtube-fetcher.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source-youtube-fetcher.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path
}

resource "google_cloudfunctions2_function" "digest" {
  name     = "youtube-fetcher-digest"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "save_search_list" {
  name     = "youtube-fetcher-save-serch-list"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "split_search_list" {
  name     = "youtube-fetcher-split-search-list"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "generate_video_list_queries" {
  name     = "youtube-fetcher-generate-video-list-queries"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "save_video_list" {
  name     = "youtube-fetcher-save-video-list"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "split_video_list" {
  name     = "youtube-fetcher-split-video-list"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}

resource "google_cloudfunctions2_function" "compose_video_list" {
  name     = "youtube-fetcher-compose-video-list"
  location = "asia-east1"

  build_config {
    runtime = "nodejs20"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.object.name
      }
    }
  }

  service_config {
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.function.email
  }
}
