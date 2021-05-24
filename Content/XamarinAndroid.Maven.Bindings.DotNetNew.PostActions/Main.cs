using System;
using Microsoft.TemplateEngine.Abstractions;

//using Microsoft.TemplateEngine.Cli.PostActionProcessors;

namespace XamarinAndroid.Maven.Bindings.DotNetNew.PostActions
{
    public class ActionMain : IPostActionProcessor
    {
        public static readonly Guid ActionProcessorId = new Guid("fe366ec1-7bfe-42bb-8b2b-ecca6b568aa5");

        public Guid Id => ActionProcessorId;

        public bool Process(IEngineEnvironmentSettings settings, IPostAction actionConfig, ICreationResult templateCreationResult, string outputBasePath)
        {
            settings.Host.LogMessage("C# Code - settings.Host.LogMessage");
            Console.WriteLine("C# Code - Console.WriteLine");

            throw new Exception("C# Exception from PostActions.ActionMain");

            return true;
        }
    }
}