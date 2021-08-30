#!/bin/sh

export MAVEN_GROUP_ID="com.google.crypto.tink"
export MAVEN_ARTIFACT_ID="tink-android"
export MAVEN_ARTIFACT_VERSION="1.6.1"

# export MAVEN_GROUP_ID="_PlaceholderMavenGroupId_"

export URL_PART_MAVEN_GROUP_ID=$(echo $MAVEN_GROUP_ID | sed 's/\./\//g')

echo  $URL_PART_MAVEN_GROUP_ID

export URL_FILE_GOOGLE="https://dl.google.com/android/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"
export URL_FILE_CENTRAL="https://repo1.maven.org/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"

echo Google Repo        $URL_FILE_GOOGLE
echo Maven Central Repo $URL_FILE_CENTRAL


mkdir downloaded-artifact
mkdir downloaded-artifact/google
mkdir downloaded-artifact/maven-central

echo "$URL_FILE_GOOGLE.aar"  
curl \
    "$URL_FILE_GOOGLE.aar" \
    --output "ownloaded-artifact/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"

echo "$URL_FILE_GOOGLE.jar"  
curl \
    "$URL_FILE_GOOGLE.jar" \
    --output "ownloaded-artifact/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"

echo "$URL_FILE_GOOGLE.pom"  
curl \
    "$URL_FILE_GOOGLE.pom" \
    --output "ownloaded-artifact/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"

echo "$URL_FILE_GOOGLE-sources.jar"  
curl \
    "$URL_FILE_GOOGLE-sources.jar" \
    --output "ownloaded-artifact/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"   

echo "$URL_FILE_GOOGLE-javadoc.jar"  
curl \
    "$URL_FILE_GOOGLE-javadoc.jar" \
    --output "ownloaded-artifact/google$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"   



echo "$URL_FILE_CENTRAL.aar"  
curl \
    "$URL_FILE_CENTRAL.aar" \
    --output "downloaded-artifact/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"

echo "$URL_FILE_CENTRAL.jar"  
curl \
    "$URL_FILE_CENTRAL.jar" \
    --output "downloaded-artifact/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"

echo "$URL_FILE_CENTRAL.pom"  
curl \
    "$URL_FILE_CENTRAL.pom" \
    --output "downloaded-artifact/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"

echo "$URL_FILE_CENTRAL-sources.jar"  
curl \
    "$URL_FILE_CENTRAL-sources.jar" \
    --output "downloaded-artifact/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"   

echo "$URL_FILE_CENTRAL-javadoc.jar"  
curl \
    "$URL_FILE_CENTRAL-javadoc.jar" \
    --output "downloaded-artifact/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"   