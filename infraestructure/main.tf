resource "aws_s3_bucket" "datalake" {
  # Parâmetros de configuração de recurso escolhido
  bucket = "${var.base_bucket_name}-${var.ambiente}-${var.numero_conta}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    CURSO = "EDC"
    NOME  = "SEMISSATTO"
  }
}

resource "aws_s3_bucket_object" "codigo_spark" {
  bucket = aws_s3_bucket.datalake.id
  key    = "emr-code/pyspark/job_spark_from_tf.py"
  acl    = "private"
  source = "../job_spark_rais.py"
  etag   = filemd5("../job_spark_rais.py") # faz controle de estado
}

provider "aws" {
  region = "us-east-2"
}

# Centraliza o arquivo de controle de estado do Terraform
terraform {
  bakcned "s3" {
    bucket = "terraform-state-guilherme-rais"
    key = "state/rais/terraform.tfstate"
    region = "us-east-2"
  }
}
