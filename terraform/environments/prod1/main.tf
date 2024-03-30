locals {
  env = "prod1"
}

module "youtube_fetcher" {
  source                        = "../../modules/youtube_fetcher"
  project_id                    = var.project_id
  cloudbuild_trigger_repository = var.cloudbuild_trigger_repository
  run_image                     = var.run_image
  playlist_ids                  = var.playlist_ids
}

module "newt_storage" {
  source                        = "../../modules/newt_storage"
  project_id                    = var.project_id
  cloudbuild_trigger_repository = var.cloudbuild_trigger_repository
  run_image                     = var.run_image
  cdn_region                    = var.cdn_region
  cdn_endpoint                  = var.cdn_endpoint
  cdn_bucket_name               = var.cdn_bucket_name
}
