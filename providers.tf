provider aws {

region = var.aws_region[0]
profile = var.profile

}

provider google {

project     = var.project
region      = var.gcp_region[0]
credentials = file(var.credential_path)

}
