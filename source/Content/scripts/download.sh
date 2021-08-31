#!/bin/sh

# export MAVEN_GROUP_ID="com.google.crypto.tink"
# export MAVEN_ARTIFACT_ID="tink-android"
# export MAVEN_ARTIFACT_VERSION="1.6.1"

export MAVEN_GROUP_ID="_PlaceholderMavenGroupId_"
export MAVEN_ARTIFACT_ID="_PlaceholderMavenArtifactId_"
export MAVEN_ARTIFACT_VERSION="_PlaceholderMavenArtifactVersion_"

export URL_PART_MAVEN_GROUP_ID=$(echo $MAVEN_GROUP_ID | sed 's/\./\//g')

echo  $URL_PART_MAVEN_GROUP_ID

export URL_FILE_GOOGLE="https://dl.google.com/android/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"
export URL_FILE_CENTRAL="https://repo1.maven.org/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"

echo Google Repo        $URL_FILE_GOOGLE
echo Maven Central Repo $URL_FILE_CENTRAL


mkdir downloaded-artifacts
mkdir downloaded-artifacts/google
mkdir downloaded-artifacts/maven-central

echo "$URL_FILE_GOOGLE.aar"  
curl -v -f \
    "$URL_FILE_GOOGLE.aar" \
    --output "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"
fi

echo "$URL_FILE_GOOGLE.jar"  
curl -v -f \
    "$URL_FILE_GOOGLE.jar" \
    --output "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"
fi

echo "$URL_FILE_GOOGLE.pom"  
curl -v -f \
    "$URL_FILE_GOOGLE.pom" \
    --output "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"
fi

echo "$URL_FILE_GOOGLE-sources.jar"  
curl -v -f \
    "$URL_FILE_GOOGLE-sources.jar" \
    --output "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"   
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"
fi

echo "$URL_FILE_GOOGLE-javadoc.jar"  
curl -v -f \
    "$URL_FILE_GOOGLE-javadoc.jar" \
    --output "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"   
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"
fi



echo "$URL_FILE_CENTRAL.aar"  
curl -v -f \
    "$URL_FILE_CENTRAL.aar" \
    --output "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"
fi

echo "$URL_FILE_CENTRAL.jar"  
curl -v -f \
    "$URL_FILE_CENTRAL.jar" \
    --output "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"
fi

echo "$URL_FILE_CENTRAL.pom"  
curl -v -f \
    "$URL_FILE_CENTRAL.pom" \
    --output "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"
fi

echo "$URL_FILE_CENTRAL-sources.jar"  
curl -v -f \
    "$URL_FILE_CENTRAL-sources.jar" \
    --output "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"   
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"
fi

echo "$URL_FILE_CENTRAL-javadoc.jar"  
curl -v -f \
    "$URL_FILE_CENTRAL-javadoc.jar" \
    --output "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"
if [ ! $? -eq 0 ];
then
   rm -f "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"
fi


mv \
    downloaded-artifacts/maven-central/*.aar \
    Artifacts/AARs/
mv \
    downloaded-artifacts/google/*.aar \
    Artifacts/AARs/
# mv \
#     downloaded-artifacts/maven-central/*-javadoc.jar \
#     Artifacts/JARs/javadocs/
# mv \
#     downloaded-artifacts/google/*-javadoc.jar \
#     Artifacts/JARs/javadocs/
rm downloaded-artifacts/maven-central/*-javadoc.jar
rm downloaded-artifacts/google/*-javadoc.jar
mv \
    downloaded-artifacts/maven-central/*-sources.jar \
    Artifacts/JARs/sources/
mv \
    downloaded-artifacts/google/*-sources.jar \
    Artifacts/JARs/sources/
mv \
    downloaded-artifacts/google/*.jar \
    Artifacts/JARs/
mv \
    downloaded-artifacts/maven-central/*.jar \
    Artifacts/JARs/
mv \
    downloaded-artifacts/maven-central/*.pom \
    Artifacts/POMs/
mv \
    downloaded-artifacts/google/*.pom \
    Artifacts/POMs/

rm -fr downloaded-artifacts/