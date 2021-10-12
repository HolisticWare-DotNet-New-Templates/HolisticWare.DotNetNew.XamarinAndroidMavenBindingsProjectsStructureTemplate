# Write-Output "Windows / Unix / MacOSX";
# Write-Host "Windows / Unix / MacOSX";
# "Windows / Unix / MacOSX";

try 
{
    hw-verbindungsstappler `
    search `
        --MavenGroupId _PlaceholderMavenGroupId_ `
        --MavenArtifactId _PlaceholderMavenArtifactId_ `
        --MavenArtifactId _PlaceholderMavenArtifactId_ `
}
catch 
{
    Write-Host  "dotnet tool" 
    Write-Host  "    hw-verbindungsstappler"
    Write-Host  "not found" 

    Write-Host  "please run" 
    Write-Host  "    dotnet tool --global install "
    Write-Host  "not found" 

}
# $MAVEN_GROUP_ID="com.google.crypto.tink"
# $MAVEN_ARTIFACT_ID="tink-android"
# $MAVEN_ARTIFACT_VERSION="1.6.1"

$MAVEN_GROUP_ID="_PlaceholderMavenGroupId_"
$MAVEN_ARTIFACT_ID="_PlaceholderMavenArtifactId_"
$MAVEN_ARTIFACT_VERSION="_PlaceholderMavenArtifactVersion_"
$NUGET_ID="_PlaceholderNugetID_"
$NUGET_VERSION="_PlaceholderNugetVersion_"

$URL_PART_MAVEN_GROUP_ID= $MAVEN_GROUP_ID -replace "\.",  "/"

Write-Host  $URL_PART_MAVEN_GROUP_ID

$URL_FILE_GOOGLE="https://dl.google.com/android/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"
$URL_FILE_CENTRAL="https://repo1.maven.org/maven2/$URL_PART_MAVEN_GROUP_ID/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION"

Write-Host  Google Repo        $URL_FILE_GOOGLE
Write-Host  Maven Central Repo $URL_FILE_CENTRAL

New-Item -Path ".\" -ItemType "directory" -Name "downloaded-artifacts" 
New-Item -Path ".\" -ItemType "directory" -Name "downloaded-artifacts/google" 
New-Item -Path ".\" -ItemType "directory" -Name "downloaded-artifacts/maven-central" 

Write-Host "$URL_FILE_GOOGLE.aar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_GOOGLE.aar" `
    -OutFile "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"    
}

Write-Host "$URL_FILE_GOOGLE.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_GOOGLE.jar" `
    -OutFile "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"    
}

Write-Host "$URL_FILE_GOOGLE.pom"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_GOOGLE.pom" `
    -OutFile "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"    
}
catch 
{
    Remove-Item "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"    
}

Write-Host "$URL_FILE_GOOGLE-javadoc.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_GOOGLE-javadoc.jar" `
    -OutFile "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"    
}

Write-Host "$URL_FILE_GOOGLE-sources.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_GOOGLE-sources.jar" `
    -OutFile "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/google/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"    
}



Write-Output "$URL_FILE_CENTRAL.aar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_CENTRAL.aar" `
    -OutFile "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.aar"    
}

Write-Output "$URL_FILE_CENTRAL.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_CENTRAL.jar" `
    -OutFile "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.jar"    
}

Write-Output "$URL_FILE_CENTRAL.pom"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_CENTRAL.pom" `
    -OutFile "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"    
}
catch 
{
    Remove-Item "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION.pom"    
}

Write-Output "$URL_FILE_CENTRAL-javadoc.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_CENTRAL-javadoc.jar" `
    -OutFile "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-javadoc.jar"    
}

Write-Host "$URL_FILE_CENTRAL-sources.jar"  
try 
{
    Invoke-WebRequest `
    -Uri "$URL_FILE_CENTRAL-sources.jar" `
    -OutFile "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"    
}
catch 
{
    Remove-Item "downloaded-artifacts/maven-central/$MAVEN_ARTIFACT_ID-$MAVEN_ARTIFACT_VERSION-sources.jar"    
}


Move-Item `
    -Path downloaded-artifacts/maven-central/*.aar `
    -Destination Artifacts/AARs/
Move-Item `
    -Path downloaded-artifacts/google/*.aar `
    -Destination Artifacts/AARs/
Move-Item `
     -Path downloaded-artifacts/maven-central/*-javadoc.jar `
     -Destination Artifacts/JARs/javadocs/
Move-Item `
     -Path downloaded-artifacts/google/*-javadoc.jar `
     -Destination Artifacts/JARs/javadocs/
Move-Item `
    -Path downloaded-artifacts/maven-central/*-sources.jar `
    -Destination Artifacts/JARs/sources/
Move-Item `
    -Path downloaded-artifacts/google/*-sources.jar `
    -Destination Artifacts/JARs/sources/
Move-Item `
    -Path downloaded-artifacts/google/*.jar `
    -Destination Artifacts/JARs/
Move-Item `
    -Path downloaded-artifacts/maven-central/*.jar `
    -Destination Artifacts/JARs/
Move-Item `
    -Path downloaded-artifacts/maven-central/*.pom `
    -Destination Artifacts/POMs/
Move-Item `
    -Path downloaded-artifacts/google/*.pom `
    -Destination Artifacts/POMs/

Remove-Item -Recurse -Force downloaded-artifacts/
