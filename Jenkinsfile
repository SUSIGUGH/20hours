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

}
}
