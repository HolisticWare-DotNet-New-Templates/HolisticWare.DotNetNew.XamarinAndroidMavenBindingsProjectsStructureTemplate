/*
run this

	dotnet cake --settings_skipverification=true

	export CAKE_SETTINGS_SKIPVERIFICATION=true
	dotnet cake
*/
#addin nuget:?package=Cake.FileHelpers
// #addin nuget:?package=Cake.FileHelpers&version=4.0.1
// #addin "MagicChunks"

string nuget_id = "HolisticWare.DotNetNew.XamarinAndroidMavenBindingsProjectsStructureTemplate.CSharp";

FilePathCollection files = null;
files = GetFiles("./*.nupkg");
DeleteFiles(files);

string[] directories = new string[]
{
	"./Content/.vs/",
	"./Content/tools/",
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

/*
no need to test builds
CakeExecuteScript
(
	"./Content/build.cake",
	new CakeSettings
	{
		Arguments = new Dictionary<string, string> 
						{
							{"target", "clean"},
						}
	}
);
*/

DateTime dt = DateTime.Now;
string version = $"{dt.ToString("yyyy.MM.dd.HHmm")}";

FilePath file_source = GetFiles ($"./*.nuspec").ToList () [0];
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



int exit_code = StartProcess
(
	"nuget", 
	new ProcessSettings
	{ 
		Arguments = $"pack new.tmp.{version}.nuspec -OutputDirectory ./output/nuget/" 
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

files = GetFiles("./new.tmp.*.nuspec");
DeleteFiles(files);

string nupkg = GetFiles($"./output/nuget/{nuget_id}.*.nupkg")
								.FirstOrDefault()
								.ToString()
								;

string zip = nupkg.Replace("nupkg", "zip");
CopyFile(nupkg, zip);
Unzip(zip, "./output/nuget/nuget-structure/");
