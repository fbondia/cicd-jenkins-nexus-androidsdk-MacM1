docker run \
--name jenkins \
--rm \
-p 8080:8080 \
--env JENKINS_ADMIN_ID=admin \
--env JENKINS_ADMIN_PASSWORD=admin \
--env MAIL_USER=me@gmail.com \
--env MAIL_PASSWORD=mypass \
--volume /Users/fbondia/Source/cicd/Jenkins/jobs:/var/jenkins_home/jobs \
my-jenkins
