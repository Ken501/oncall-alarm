terraform {
  backend "s3" {
    encrypt = true
    bucket  = var.backend_bucket
    region  = var.region
  }
}
