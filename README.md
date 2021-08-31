# HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate

HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate

Xamarin.Android PoC (Proof of concept) for Android (Maven) Bindings Project template.

## Installation / DeInstallation


Local test:

build:

```
dotnet cake
```

install:

```
dotnet new --install \
    ./output/dotnet/HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp.2021.5.23.1626.nupkg 
```

uninstall:

```
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp
```

usage / test:

```
dotnet new \
    hw-structure-android-maven-bindings \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId UserInputMavenGroupId \
    --MavenArtifactId UserInputMavenArtifactId \
    --MavenArtifactVersion UserInputMavenArtifactVersion \
    --output Demo

tree Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj
```

Full uninstall, install for (lazy butts like me)


```
dotnet cake
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

dotnet new --install $(find ./output/nuget/*.nupkg)

rm -fr tests/Demo
dotnet new \
    hw-structure-android-maven-bindings \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId UserInputMavenGroupId \
    --MavenArtifactId UserInputMavenArtifactId \
    --MavenArtifactVersion UserInputMavenArtifactVersion \
    --output tests/Demo

tree tests/Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj
```



```
dotnet cake
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

dotnet new --install $(find ./output/nuget/*.nupkg)

rm -fr tests/Demo
dotnet new \
    hw-structure-android-maven-bindings \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId com.google.crypto.tink \
    --MavenArtifactId tink-android \
    --MavenArtifactVersion 1.6.1 \
    --output tests/Demo

tree tests/Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj
```

```
dotnet cake
tree ./output/dotnet/nuget-structure/content/
tree ./output/nuget/nuget-structure/content/

dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

dotnet new --install $(find ./output/nuget/*.nupkg)

rm -fr tests/Demo
dotnet new \
    hw-structure-android-maven-bindings \
    --TargetFrameworks "MonoAndroid9.0;monoandroid10.0;monoandroid11.0;net6.0-android30.0" \
    --NET.SDK Xamarin.Legacy.Sdk \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId androidx.startup \
    --MavenArtifactId startup-runtime \
    --MavenArtifactVersion 1.0.0 \
    --output tests/Demo

tree tests/Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj
```

After publishing:

```
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

dotnet new --install \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

rm -fr tests/Demo
dotnet new \
    hw-structure-android-maven-bindings \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId androidx.startup \
    --MavenArtifactId startup-runtime \
    --MavenArtifactVersion 1.0.0 \
    --output tests/Demo

tree tests/Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj

```


```
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

dotnet new --install \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp

rm -fr tests/Demo
dotnet new \
    hw-structure-android-maven-bindings \
    --NugetId UserInputNugetId \
    --NugetVersion UserInputNugetVersion \
    --MavenGroupId com.google.crypto.tink \
    --MavenArtifactId tink-android \
    --MavenArtifactVersion 1.6.1 \
    --output tests/Demo

tree tests/Demo

dotnet build tests/Demo/Demo.XamarinAndroid.Maven.Bindings.csproj

```


## Links / References

*   Ability to execute some custom code after running the template engine

    *   https://github.com/dotnet/templating/issues/286

    *   https://github.com/dotnet/templating/issues/1728

    *   https://github.com/dotnet/templating/wiki/Post-Action-Registry#run-script

    *   repo

        *   https://github.com/dotnet/templating

        *   old

            *   https://github.com/ligershark/microsoft-templateengine

    *   
    
*   samples

    *   https://github.com/dotnet/templating/tree/main/test/Microsoft.TemplateEngine.TestTemplates/test_templates/PostActions


### Further Investgation

ps1 scripts in `tools/` folder

```
WARNING: NU5110: The script file '_Placeholder_.XamarinAndroid.Maven.Bindings/scripts/run-all.ps1' is outside the 'tools' folder and hence will not be executed during installation of this package. Move it into the 'tools' folder.
WARNING: NU5110: The script file '_Placeholder_.XamarinAndroid.Maven.Bindings/scripts/nugethoblaster/nugethoblaster.ps1' is outside the 'tools' folder and hence will not be executed during installation of this package. Move it into the 'tools' folder.
WARNING: NU5110: The script file '_Placeholder_.XamarinAndroid.Maven.Bindings/scripts/binderate/binderate.ps1' is outside the 'tools' folder and hence will not be executed during installation of this package. Move it into the 'tools' folder.
WARNING: NU5111: The script file '_Placeholder_.XamarinAndroid.Maven.Bindings/scripts/run-all.ps1' is not recognized by NuGet and hence will not be executed during installation of this package. Rename it to install.ps1, uninstall.ps1 or init.ps1 and place it directly under 'tools'.
```

*   nugets
        
    *   Microsoft.TemplateEngine.Cli
        
        *   https://www.nuget.org/packages/Microsoft.TemplateEngine.Cli/
        
        *   dependencies
        
            *   Microsoft.DotNet.Cli.CommandLine
            
                *   https://www.nuget.org/packages/Microsoft.DotNet.Cli.CommandLine/
            
                *   404 - not listed

            *   Microsoft.DotNet.TemplateLocator
            
                *   https://www.nuget.org/packages/Microsoft.DotNet.TemplateLocator/
            
                *   404 - not listed
