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
sh 'sudo docker login -u=${udockersusigugh} -p=${pdockersusigugh} && sudo docker push susigugh/httpdtst:v.2'
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

stage('Create AWS resource')
{
    steps
    {
        sh 'terraform init'
        sh 'terraform plan'
        sh 'terraform apply -auto-approve'
        sh 'terraform destroy -auto-approve'

    }
}

stage('Deploy HTTPD POD in Kubernetes')
{
    steps
    {
        sh 'chmod 600 jmtksrv01.pem'
        sh 'scp -i jmtksrv01.pem httpd01.yml ec2-user@ec2-13-233-148-180.ap-south-1.compute.amazonaws.com:/home/ec2-user/'
    }
}




}
}
