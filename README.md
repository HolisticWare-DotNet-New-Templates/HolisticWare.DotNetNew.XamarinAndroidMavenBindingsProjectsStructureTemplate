# HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate

HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate

Xamarin.Android PoC (Proof of concept) for Android (Maven) Bindings Project template.

## Installation / DeInstallation


Local test:

install:

```
dotnet new --install \
    ./output/HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp.2021.5.23.1626.nupkg 
```

uninstall:

```
dotnet new --uninstall \
    HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp
```

usage:

```
dotnet new \
    hw-structure-android-maven-bindings \
    --output Demo
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
