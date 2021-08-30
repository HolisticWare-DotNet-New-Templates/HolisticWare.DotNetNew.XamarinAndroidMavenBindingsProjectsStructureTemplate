/*
run this

	dotnet cake --settings_skipverification=true

	export CAKE_SETTINGS_SKIPVERIFICATION=true
	dotnet cake
*/
#addin nuget:?package=Cake.FileHelpers
// #addin nuget:?package=Cake.FileHelpers&version=4.0.1
// #addin "MagicChunks"

var TARGET = Argument ("t", Argument ("target", "Default"));

string nuget_id = "HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp";


Task ("clean")
    .Does 
    (
        () =>
        {
			string[] directories = new string[]
			{
				"./source/Content/.vs/",
				"./source/Content/tools/",
				"./output",
			};

			foreach (string directory in directories)
			{
				if (DirectoryExists (directory))
				{
					DeleteDirectory
								(
									directory,
									new DeleteDirectorySettings
									{
										Recursive = true,
										Force = true
									}
								);

				}
			}

			FilePathCollection files = null;
			files = GetFiles("./*.nupkg");			
			DeleteFiles(files);
			files = GetFiles("./new.tmp.*.nuspec");			
			DeleteFiles(files);
			
			return;

		}
	);

Task ("build-content")
    .Does 
    (
        () =>
        {
			CakeExecuteScript
			(
				"./source/Content/build.cake",
				new CakeSettings
				{
					Arguments = new Dictionary<string, string> 
									{
										{"target", "clean"},
									}
				}
			);
			CakeExecuteScript
			(
				"./source/Content/build.cake",
				new CakeSettings
				{
					Arguments = new Dictionary<string, string> 
									{
										{"target", "build"},
									}
				}
			);
		}
	);

DateTime dt = DateTime.Now;
string version = $"{dt.ToString("yyyy.MM.dd.HHmm")}";

FilePath file_source = GetFiles ($"./source/TemplatePackaging/*.nuspec").ToList () [0];
Information($"file = {file_source} : ");
Information($"{FileReadText(file_source)}");
FilePath file_destination = new FilePath
									(
										file_source.FullPath.Replace(nuget_id, $"new.tmp.{version}")
									);
Information($"file = {file_destination} : ");
Information($"Copy");
Information($"	file_source 		= {file_source} : ");
Information($"	file_destination 	= {file_destination} : ");
CopyFile(file_source, file_destination);


// https://github.com/xamarin/GoogleApisForiOSComponents/blob/master/update.cake
// https://gsferreira.com/archive/2018/06/versioning-net-core-applications-using-cake/
XmlPoke
(
	file_destination,
    //"/ns:package/ns:metadata/ns:version/",
	"//version",
    version,
    new XmlPokeSettings 
	{
        Namespaces = new Dictionary<string, string> 
		{
            { "ns", "http://schemas.microsoft.com/packaging/2012/06/nuspec.xsd" },
        }
    }
);
Information($"{FileReadText(file_destination)}");


// https://github.com/sergeyzwezdin/magic-chunks
// TransformConfig
// (
// 	file.ToString(), 
// 	$"new.tmp.{version}.nuspec",
// 	new TransformationCollection 
// 	{
// 		{ "package/metadata/version", version },
// 	}
// );

Task ("pack-with-nuget-pack")
    .Does 
    (
        () =>
        {
			int exit_code = StartProcess
			(
				"nuget", 
				new ProcessSettings
				{ 
					Arguments = $"pack ./source/TemplatePackaging/new.tmp.{version}.nuspec -OutputDirectory ./output/nuget/" 
				}
			);

			// This should output 0 as valid arguments supplied
			Information("Exit code: {0}", exit_code);

			// NuGetPackSettings settings =
			// 						new NuGetPackSettings 
			// 									{
			// 										Version = version
			// 									}
			// 						;
			// NuGetPack
			// (
			// 	$"./nuget/{nuget_id}.nuspec",
			// 	settings
			// );

			FilePathCollection files = null;
			files = GetFiles("./source/TemplatePackaging/new.tmp.*.nuspec");
			DeleteFiles(files);

			string nupkg = GetFiles($"./output/nuget/{nuget_id}.*.nupkg")
											.FirstOrDefault()
											.ToString()
											;
			string zip = nupkg.Replace("nupkg", "zip");
			CopyFile(nupkg, zip);
			Unzip(zip, "./output/nuget/nuget-structure/");


			return;
		}
	);

Task ("pack-with-dotnet-pack")
    .Does 
    (
        () =>
        {
			// not packing though <PackOnBuild>true</PackOnBuild>
			DotNetCoreBuild("./source/TemplatePackaging/TemplatePackagingProject/TemplatePackagingProject.csproj");	
			DotNetCorePack("./source/TemplatePackaging/TemplatePackagingProject/TemplatePackagingProject.csproj");	

			string nupkg = GetFiles($"./output/dotnet/{nuget_id}.*.nupkg")
											.FirstOrDefault()
											.ToString()
											;
			string zip = nupkg.Replace("nupkg", "zip");
			CopyFile(nupkg, zip);
			Unzip(zip, "./output/dotnet/nuget-structure/");

			return;
		}
	);


Task ("pack")
    .IsDependentOn ("pack-with-dotnet-pack")
    .IsDependentOn ("pack-with-nuget-pack")
    .Does 
    (
        () =>
        {
			return;
		}
	);


Task ("Default")
    .IsDependentOn ("clean")
    //.IsDependentOn ("build-content")
    .IsDependentOn ("pack")
    ;


RunTarget (TARGET);
