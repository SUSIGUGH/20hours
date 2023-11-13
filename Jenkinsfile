pipeline
{
agent any
stages
{

stage('List Git Files')
{
steps
{
sh 'pwd'
sh 'ls -ltr'
}
}

stage('Build Docker Image')
{
steps
{
sh 'sudo docker build -t httpdtst .'
sh 'sudo docker images | grep httpdtst'
}
}

stage('Tag Docker Image')
{
steps
{
sh 'sudo docker image tag httpdtst susigugh/httpdtst:v.1'
}
}

stage('Push Docker Image to Dockerhub')
{
steps
{
sh 'sudo docker login -u=susigugh -p=UniBall@2528 && sudo docker push susigugh/httpdtst:v.1'
}
}


}
}
