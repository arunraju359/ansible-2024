FROM tomcat
ADD /Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war webapps/studentapp-studentapp.war
