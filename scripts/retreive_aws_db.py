import boto3
import base64
import sys, os, json, subprocess, re
from botocore.exceptions import ClientError

aws_env = list(sys.argv)[1]
region_name = "eu-central-1"
db_env_file_path = "db.env"
db_keys = ['dburl', 'driver', 'username', 'password', 'host', 'dbname', 'scheme']
db_secrets = {}
accept_param = ["dev", "sit", "preprod", "prod"]

def main():
  if not aws_env in accept_param:
    print("Please provide something like: ${accept_param}")

  db_secrets = get_secret()
  exportSecretsToFile(db_secrets)

def get_secret():
  secret_name = "tuid-" + aws_env + "-secret-tupspnl-app-db"
  session = boto3.session.Session()
  client = session.client(
    service_name='secretsmanager',
    region_name=region_name,
    aws_access_key_id=os.environ.get('ACCESS_KEY'),
    aws_secret_access_key=os.environ.get('SECRET_KEY'),
    aws_session_token=os.environ.get('SESSION_TOKEN')
  )

  try:
    print("Retreiving credentials for " + secret_name)
    secret_response = client.get_secret_value(
        SecretId=secret_name
    )
      
  except ClientError as e:
    print("Can't find secret!")
    return
  else:
    if 'SecretString' in secret_response:
      secret = secret_response['SecretString']
    else:
      secret = base64.b64decode(secret_response['SecretBinary'])
  return json.loads(secret)

def setDbSecret(db_secrets):
  for db_key in db_keys:
    os.environ[db_key] = db_secrets[db_key]
  print("environment set for "+os.environ.get('dburl'))

def exportSecretsToFile(db_secrets):
  regEx1='export \w=.*'
  rFile = open(db_env_file_path, 'r')
  fileEntries = rFile.read()
  rFile.close()

  with open(db_env_file_path, 'w') as tFile:
    for db_key in db_keys:
      foundCount = 0
      fileSub = re.subn(r"(export " + db_key + "=)(.*)",
              r"\1'"+db_secrets[db_key]+"'", fileEntries)
      if fileSub[1] == 0:
        fileEntries = fileEntries + "\nexport "+ db_key + "='" + db_secrets[db_key] + "'"
      else:
        fileEntries = fileSub[0]
    fileEntries = fileEntries + "\nexport PGDBURL='postgresql://" + db_secrets['username'] + ":" + db_secrets['password'] + "@" + db_secrets['host'] + "/" + db_secrets['dbname'] + "'"
    tFile.write(fileEntries)
  
if __name__ == '__main__':
    main()
