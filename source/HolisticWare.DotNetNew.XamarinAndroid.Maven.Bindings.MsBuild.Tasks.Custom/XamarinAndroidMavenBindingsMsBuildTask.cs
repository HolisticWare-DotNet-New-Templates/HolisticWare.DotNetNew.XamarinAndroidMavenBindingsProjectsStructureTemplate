﻿using System;

namespace HolisticWare.DotNetNew.XamarinAndroid.Maven.Bindings.MsBuild.Tasks.Custom
{
    public partial class XamarinAndroidMavenBindingsMsBuildTask : Microsoft.Build.Utilities.Task
    {
        // banner for visibility
        // HolisticWare
        // Xamarin.Android Build Tools
        // Decompilers
        // http://patorjk.com/software/taag/#p=display&c=c%2B%2B&f=Small%20Slant&t=HolisticWare%0AXamarin.Android%20Build%20Tools%0ADecompilers%0A%0A
        string Banner =
            @"
//     __ __     ___     __  _    _      __                                                                         
//    / // /__  / (_)__ / /_(_)__| | /| / /__ ________                                                              
//   / _  / _ \/ / (_-</ __/ / __/ |/ |/ / _ `/ __/ -_)                                                             
//  /_//_/\___/_/_/___/\__/_/\__/|__/|__/\_,_/_/  \__/                                                              
//     _  __                    _        ___           __         _    __  ___       _ __   __  ______          __  
//    | |/_/__ ___ _  ___ _____(_)__    / _ | ___  ___/ /______  (_)__/ / / _ )__ __(_) /__/ / /_  __/__  ___  / /__
//   _>  </ _ `/  ' \/ _ `/ __/ / _ \_ / __ |/ _ \/ _  / __/ _ \/ / _  / / _  / // / / / _  /   / / / _ \/ _ \/ (_-<
//  /_/|_|\_,_/_/_/_/\_,_/_/ /_/_//_(_)_/ |_/_//_/\_,_/_/  \___/_/\_,_/ /____/\_,_/_/_/\_,_/   /_/  \___/\___/_/___/
//    / _ \___ _______  __ _  ___  (_) /__ _______                                                                  
//   / // / -_) __/ _ \/  ' \/ _ \/ / / -_) __(_-<                                                                  
//  /____/\__/\__/\___/_/_/_/ .__/_/_/\__/_/ /___/                                                                  
//                         /_/

        HolisticWare
        Xamarin.Android Build Tools
        Decompilers
        ";
        [Microsoft.Build.Framework.Required]
        public string Executable
        {
            get;
            set;
        }

        [Microsoft.Build.Framework.Required]
        public string JarBinaryDecompiler
        {
            get;
            set;
        }

        [Microsoft.Build.Framework.Required]
        public string JarBinaryAndroidArtifact
        {
            get;
            set;
        }

        [Microsoft.Build.Framework.Required]
        public string Options
        {
            get;
            set;
        }

        string filename_output;
        string filename_error;
        string decompiler;

        public override bool Execute()
        {
            Log.LogMessage(Banner);

            int position_slash_forward = JarBinaryAndroidArtifact.LastIndexOf('/');
            int length_name = JarBinaryAndroidArtifact.Length - position_slash_forward - 5;
            string artifact_name = JarBinaryAndroidArtifact.Substring(position_slash_forward + 1, length_name);


            Log.LogMessage($"DecompilerTaskForJavaBinaries.Execute: ");
            Log.LogMessage($"            Executable               : {Executable}");
            Log.LogMessage($"            JarBinaryDecompiler      : {JarBinaryDecompiler}");
            Log.LogMessage($"            JarBinaryAndroidArtifact : {JarBinaryAndroidArtifact}");
            Log.LogMessage($"            Options                  : {Options}");
            Log.LogMessage($"            artifact_name            : {artifact_name}");

            if (Executable.ToLower().Equals("javap"))
            {
                /*
                javap \
                    -classpath ../../../../externals/android/grpc-stub-1.14.0.jar \
                        $(jar -tf ../../../../externals/android/grpc-stub-1.14.0.jar | grep "class$" | sed s/\.class$//) \
                        >> grpc-stub-1.14.0.jar.class.java.txt

                handling stdout and stderr in .NET Process for such complex one liner is a bit messy

                workaround splitting into 2 steps

                1. jar -tf ../../ externals / android / grpc - stub - 1.14.0.jar 
                2. javap -classpath STRING_FROM_ABOVE
                */

                decompiler = "jar-tf";
                filename_error =
                        $"holisticware-generated" + "/" + "decompilers"
                        + "/" +
                        $"{artifact_name}-stderr-{decompiler}.API-custom-task.log"
                        ;
                filename_output =
                        $"holisticware-generated" + "/" + "decompilers"
                        + "/" +
                        $"{artifact_name}-stdout-{decompiler}.API-custom-task.classes"
                        ;
                (string o, string e) se;
                se = ProcessStart
                (
                    $@"/bin/bash",
                    $" -c \"jar -tf {JarBinaryAndroidArtifact} | grep \"class$\" | sed s/\\.class$// \""
                );

                decompiler = "javap";
                filename_error = 
                        $"holisticware-generated" +"/" + "decompilers" 
                        + "/" + 
                        $"{artifact_name}-stderr-{decompiler}.API-custom-task.log"
                        ;
                filename_output =
                        $"holisticware-generated" + "/" + "decompilers"
                        + "/" +
                        $"{artifact_name}-stdout-{decompiler}.API-custom-task.classes"
                        ;
                ProcessStart
                (
                    $@"javap",
                    $" -classpath {JarBinaryAndroidArtifact} {se.o}"
                );
                // 
            }
            else
            {
                if (JarBinaryDecompiler.ToLower().Contains("procyon-decompiler-0.5.36.jar"))
                {
                     /*
                    java \
                        -jar ./procyon-decompiler-0.5.36.jar \
                        -jar ../../../../externals/android/grpc-stub-1.14.0.jar > 
                    */
                    decompiler = "procyon";
                    filename_error =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stderr-{decompiler}.API-custom-task.log"
                            ;
                    filename_output =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stdout-{decompiler}.API-custom-task.classes"
                            ;
                    ProcessStart
                    (
                        $@"java",
                        $@"-jar {JarBinaryDecompiler} -jar {JarBinaryAndroidArtifact} {Options} "
                    );
                }
                else if (JarBinaryDecompiler.ToLower().Contains("cfr-0.148.jar"))
                {
                    /*
                    java \
                        -jar ./cfr-0.148.jar \
                        -jar ../../../../externals/android/grpc-protobuf-lite-1.14.0.jar
                    */
                    decompiler = "cfr";
                    filename_error =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stderr-{decompiler}.API-custom-task.log"
                            ;
                    filename_output =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stdout-{decompiler}.API-custom-task.classes"
                            ;
                    ProcessStart
                    (
                        $@"java",
                        $@"-jar {JarBinaryDecompiler} -jar {JarBinaryAndroidArtifact} {Options} "
                    );
                }
                else if (JarBinaryDecompiler.ToLower().Contains("Bytecode-Viewer-2.9.22.jar"))
                {
                    decompiler = "bytecode-viewer-procyon";
                    filename_error =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stderr-{decompiler}.API-custom-task.log"
                            ;
                    filename_output =
                            $"holisticware-generated" + "/" + "decompilers"
                            + "/" +
                            $"{artifact_name}-stdout-{decompiler}.API-custom-task.classes"
                            ;
                    ProcessStart
                    (
                        $@"java",
                        $@"-jar {Executable} -jar {JarBinaryDecompiler} "
                    );
                }
                else
                {
                    throw new NotSupportedException($"Unrecognized Java Decompiler {JarBinaryDecompiler}");
                }
            }

            // enforcing proper correlation between Log errors and build results (success and/or failures)
            return !Log.HasLoggedErrors;
        }

        protected (string Output, string Error) ProcessStart(string executable, string arguments )
        {
            Log.LogMessage($"                   ProcessStart executable:");
            Log.LogMessage($@"                   {executable} \");
            Log.LogMessage($@"                   {arguments} \");
            System.Diagnostics.ProcessStartInfo pi = null;
            pi = new System.Diagnostics.ProcessStartInfo(executable, arguments);
            pi.UseShellExecute = false;
            pi.RedirectStandardOutput = true;
            pi.RedirectStandardError = true;


            System.Diagnostics.Process p = new System.Diagnostics.Process();
            p.EnableRaisingEvents = true;
            p.StartInfo = pi;
            p.OutputDataReceived += OutputDataReceived;
            p.ErrorDataReceived += ErrorDataReceived;
            p.Start();

            string output = null;
            string error = null;

            using (System.IO.StreamReader so = p.StandardOutput)
            using (System.IO.StreamReader se = p.StandardError)
            {
                output = so.ReadToEnd();
                error = se.ReadToEnd();
                p.WaitForExit(20000);

                using (System.IO.StreamWriter file = new System.IO.StreamWriter(filename_output))
                {
                    file.WriteLine(output);
                    file.Flush();
                    file.Close();
                }
                using (System.IO.StreamWriter file = new System.IO.StreamWriter(filename_error))
                {
                    file.WriteLine(error);
                    file.Flush();
                    file.Close();
                }
            }

            return (output, error);
        }

        protected void OutputDataReceived(object sender, System.Diagnostics.DataReceivedEventArgs e)
        {
            Log.LogMessage($"decompiler stdout: {e.Data}");

            return;
        }

        protected void ErrorDataReceived(object sender, System.Diagnostics.DataReceivedEventArgs e)
        {
            Log.LogMessage($"decompiler stderr: {e.Data}");

            return;
        }

    }
}