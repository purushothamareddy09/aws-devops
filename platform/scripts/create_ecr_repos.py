import boto3
import os

def create_ecr_repo(repo_name, region):
    ecr = boto3.client('ecr', region_name=region)
    try:
        response = ecr.create_repository(repositoryName=repo_name)
        print(f"Created ECR repository: {repo_name}")
        return response['repository']['repositoryUri']
    except ecr.exceptions.RepositoryAlreadyExistsException:
        print(f"ECR repository already exists: {repo_name}")
        response = ecr.describe_repositories(repositoryNames=[repo_name])
        return response['repositories'][0]['repositoryUri']

if __name__ == "__main__":
    region = os.environ.get('AWS_REGION', 'us-east-1')
    repos = ['kafka-backend', 'kafka-frontend']
    for repo in repos:
        uri = create_ecr_repo(repo, region)
        print(f"ECR URI for {repo}: {uri}")
