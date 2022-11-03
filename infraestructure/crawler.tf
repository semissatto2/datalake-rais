resource "aws_glue_crawler" "glue_crawler" {
  database_name = "semissatto_rais_crawler"
  name          = "semissatto_rais_processing_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://datalake-guilherme-rais-tf-producao-338766793851/staging/"
  }

  provisioner "local-exec" {
    command = "aws glue start-crawler --name ${aws_glue_crawler.glue_crawler.name}"
  }

}
