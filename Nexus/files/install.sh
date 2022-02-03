mvn deploy:deploy-file -DgroupId=com.oracle \
    -DartifactId=ojdbc6 \
    -Dversion=11.2.0.3 \
    -Dpackaging=jar \
    -Dfile=ojdbc6-11.2.0.3.jar \
    -DgeneratePom=true \
    -DrepositoryId=nexus \
    -Durl=http://localhost:8081/repository/maven-releases/

mvn deploy:deploy-file -DgroupId=com.oracle \
    -DartifactId=ojdbc8 \
    -Dversion=12.2.0.1 \
    -Dpackaging=jar \
    -Dfile=ojdbc8-12.2.0.1.jar \
    -DgeneratePom=true \
    -DrepositoryId=nexus \
    -Durl=http://localhost:8081/repository/maven-releases/

