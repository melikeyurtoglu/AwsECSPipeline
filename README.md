<h1> Aws ECS Pipeline </h1>

<h2> Pipeline sürecinde kullanılan toollar </h2>

Github - Jenkins - Dockers - AWS ECS 

Jenkins Pipeline job'ı ile Git repodan java kodu çekilir. Jenkins üzerinde maven ile derlenip docker image oluşturulur. Daha sonra bu image Aws Ecs servisinde çalıştırılır. 

<h3>Uygulama<h3>

Hello word yazdıran bir java uygulaması.


<h2> Amazon yapılandırması </h2>

<ul>
  <li>IAM user oluşturuldu</li>
  <li>Vpc oluşturdu</li>
  <li>Keypair oluşturdu. Bu keypair ecs için optimize bir ec2 instance'ını oluşturulurken kullanıldı.</li>
  <li>EC2'nun ECS ile birlikte çalışabilmesi için IAM role oluşturuldu. (Kullanılan policy'lerin json dosyalarını repoda bulabilirsiniz.)</li>

  `# aws iam create-role --role-name ecsRole --assume-role-policy-document file://forecspolicy.json`
  `# aws iam put-role-policy --role-name ecsRole --policy-name ecsRolePolicy  --policy-document file://role.json`
  `# aws iam create-instance-profile --instance-profile-name ecsRole`
  `# aws iam add-role-to-instance-profile --instance-profile-name ecsRole --role-name ecsRole`

  <li>ECS cluster'ına eklemek için optimize edilmiş Amazon Linux 2 oluşturuldu</li>
  
  `# aws ec2 run-instances   --image-id ami-0c5abd45f676aab4f --count 1 --instance-type t2.micro --key-name helloworldkey --iam-instance-profile "Name= ecsRole" --security-groups HelloWorldSecurityGroup --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyECSInstance}]'`

  <li>ECS Cluster oluşturuldu</li>
 
  `# aws ecs create-cluster --cluster-name default`

  <li>ECS task and service oluşturuldu</li>
 
  `# sed -e "s;%BUILD_NUMBER%;0;g" helloworld.json > helloworld-v_0.json`
  `# aws ecs register-task-definition --cli-input-json file://helloworld-v_0.json`
  `# aws ecs create-service --cluster default --service-name helloworldfamilyservice --task-definition helloworldfamily --desired-count 0`

</ul>

<h3>Jekins</h3>

Pluginler:
<ul>
  <li>Docker Build and Publish</li>
  <li>dockerhub plugin</li>
  <li>Github plugin</li>
  <li>Amazon EC2 Container Service Cloud</li>
</ul>

Jenkins job'ının xml dosyasını bu repoda bulabilirsiniz. Ayrıca ECS üzerine docker deployment'i için DeployEcs.sh scripti kullanıldı. Onu da repoda bulabilirsiniz.


