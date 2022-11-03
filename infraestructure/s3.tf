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
