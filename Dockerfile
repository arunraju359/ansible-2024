FROM tomcat
COPY /Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war webapps/studentapp-studentapp.war
