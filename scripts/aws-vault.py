import re
from pathlib import Path
import sys, os, subprocess

accept_param = ["dev", "sit", "preprod", "prod"]
param = list(sys.argv)
aws_env =  param[1] if len(param) > 1 else ''
file_path = '{}/.aws/credentials'.format(Path.home())
aws_session_env = []

def main():
  print('Setup AWS {} Environment for file {}'.format(aws_env, file_path))
  rc = -1
  if checkInput():
    os.popen('aws-vault clear').close()
    os.popen('unset AWS_VAULT').close()
    process = os.popen('aws-vault exec {} -- env | grep AWS'.format(aws_env))
    for line in process.readlines():
      aws_session_env.append(line.split('=', 1))
    rc = process.close()
  if aws_session_env.count == 0:
    aws_session_env.append(['aws_access_key_id', 'xxxxxxxxxxxxxxxxxxxx\n'])
    aws_session_env.append(['aws_secret_access_key', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n'])
  real_output = ''
  for env in aws_session_env:
    real_output = real_output + '{} = {}'.format(env[0].lower(), env[1])
  if rc == None:
    exportSecretsToFile(real_output)

def exportSecretsToFile(textToReplace):
  regEx=re.compile('(manager = aws-vault\n)(?:(?>aws_.*\n)|(?>aws_.*))*')
  fileEntries = readFile()
  matches = re.findall(regEx, fileEntries)
  
  if (matches):
    with open(file_path, 'w') as writeFile:
      fileEntries = re.sub(regEx, r'\1' + textToReplace, fileEntries)
      print('Adding new Secrets.')
      writeFile.write(fileEntries)
  else:
    print('No match!')

def checkInput():
  if not aws_env in accept_param:
    print("Please provide something like: ")
    print(accept_param, end='\n\n')
    return False
  return True

def readFile():
  with open(file_path, 'r') as readFile:
    return readFile.read()


if __name__ == '__main__':
  main()
