resource "google_project_iam_member" "functions_cb_main_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}

resource "google_project_iam_member" "functions_cb_main_functions_admin" {
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}

resource "google_project_iam_member" "functions_cb_main_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.functions_cb_main.email}"
}

resource "google_project_iam_member" "eventarc_eventreceiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

resource "google_project_iam_member" "eventarc_workflows_invoker" {
  project = var.project_id
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

resource "google_project_iam_member" "gcp_sa_pubsub_tokencreator" {
   project  = data.google_project.project.id
   role     = "roles/iam.serviceAccountTokenCreator"
   member   = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
