data "archive_file" "function_source" {
  type       = "zip"
  source_dir = "."
  excludes = [
    "terraform"
  ]
  output_path = "${path.module}/function-source.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_source.name
  source = data.archive_file.function_source.output_path
}
