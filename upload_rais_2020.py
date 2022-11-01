import boto3,boto3.s3.transfer as t
import os
import sys
import threading

# Criar um client para interagir com o S3
s3_client = boto3.client('s3')

# Mostrar o status da transferência do arquivo na saída do terminal
class ProgressPercentage(object):
    def __init__(self, filename):
        self._filename = filename
        self._size = float(os.path.getsize(filename))
        self._seen_so_far = 0
        self._lock = threading.Lock()

    def __call__(self, bytes_amount):
        with self._lock:
            self._seen_so_far += bytes_amount
            percentage = (self._seen_so_far / self._size) * 100
            sys.stdout.write(
                "\r%s  %s / %s  (%.2f%%)" % (
                    self._filename, self._seen_so_far, self._size,
                    percentage))
            sys.stdout.flush()

def uploadDirectory(path,bucketname):
        for root,dirs,files in os.walk(path):
            for file in files:
                print(f"\nfazendo upload do arquivo {str(file)} do path {path}")
                transfer.upload_file(path + file, bucket, "raw/" + file, callback=ProgressPercentage(path + file))

transfer = t.S3Transfer(s3_client)

diretorio_origem = './RAIS/' #### <- Diretório com os arquivos armazenados localmente
bucket = 'datalake-guilherme-rais' #### <- Colocar o nome do bucket aqui
uploadDirectory(path = diretorio_origem, bucketname = bucket)
