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
sh 'sudo docker image tag httpdtst susigugh/httpdtst:v.2'
}
}

stage('Push Docker Image to Dockerhub')
{
steps
{
sh 'sudo docker login -u=susigugh -p=UniBall@2528 && sudo docker push susigugh/httpdtst:v.2'
}
}

stage('Run Container from Image')
{
steps
{
sh 'sudo docker stop httpdtst01'
sh 'sudo docker rm httpdtst01'
sh 'sudo docker run -dit --name httpdtst01 -p8027:80 susigugh/httpdtst:v.2'
sh 'sudo docker ps | grep httpdtst01'
}
}


}
}
