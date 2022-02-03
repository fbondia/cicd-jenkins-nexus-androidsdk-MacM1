FROM jenkins/jenkins

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

COPY files/plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY files/casc.yaml /var/jenkins_home/casc.yaml

USER root

# Environment Variables

ENV JDK_URL="https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public" \
    SDK_URL="http://dl.google.com/android/android-sdk_r22.3-linux.tgz" \
    SDK_TOOLS_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-4.8.1-bin.zip" \
    ANDROID_HOME="/var/lib/android-sdk/" \
    GRADLE_HOME="/var/lib/gradle-4.8.1" \
    JAVA_HOME="/usr/lib/jvm/adoptopenjdk-8-hotspot-arm64/" \
    PATH="${JAVA_HOME}/bin:${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH"

# Install utilities

RUN \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
    curl \
    bzip2 \
    traceroute \
    dnsutils \
    tcpdump \
    telnet \
    wget

# Install JDK 8

RUN wget -qO - ${JDK_URL} | apt-key add -
RUN echo "deb $([ \"$(uname -m)\" = \"x86_64\" ] && echo -n '[arch=amd64]') https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main" | tee /etc/apt/sources.list.d/adoptopenjdk.list
RUN apt update
RUN apt install -y adoptopenjdk-8-hotspot

# Android SDK

RUN wget ${SDK_URL}
RUN tar -zxvf android-sdk_r22.3-linux.tgz \
  && mv android-sdk-linux/ /var/lib/ \
  && mv /var/lib/android-sdk-linux/ ${ANDROID_HOME} \
  && cp -R ${ANDROID_HOME}/tools/lib/x86_64 ${ANDROID_HOME}/tools/lib/aarch64
  
RUN cd ${ANDROID_HOME}\tools \
  && ./android update sdk --no-ui \
  && ./android update sdk -u --filter platform-tools,android-22,android-23 \
  && ./android update sdk --no-ui --filter extra-android-support,extra-android-m2repository,extra-google-m2repository

RUN chmod -R 755 ${ANDROID_HOME}
RUN chown -R jenkins:jenkins ${ANDROID_HOME}

# Gradle

RUN wget ${GRADLE_URL}
RUN unzip gradle-4.8.1-bin.zip \
  && mv gradle-4.8.1 /var/lib/

# SDK Tools

RUN wget $SDK_TOOLS_URL
RUN unzip sdk-tools-linux-4333796.zip \
  && mv tools ${ANDROID_HOME}/sdk-tools \
  && mkdir "${ANDROID_HOME}/licenses" || true \
  && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "${ANDROID_HOME}/licenses/android-sdk-license" \
  && yes | ${ANDROID_HOME}/sdk-tools/bin/sdkmanager --licenses \
  && ${ANDROID_HOME}/sdk-tools/bin/sdkmanager "build-tools;26.0.1" \
  && ${ANDROID_HOME}/sdk-tools/bin/sdkmanager "build-tools;26.0.2"
