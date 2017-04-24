#r @"packages\FAKE\tools\FakeLib.dll"

open System
open System.IO

open Fake
open Fake.FileUtils
open Fake.Choco
open Fake.NuGetHelper

let chocolateyKeyVar = "CHOCO_KEY"
let chocolateyFeed = "https://chocolatey.org/api/v2/"

Target "BuildChocoPackages" (fun _ ->
    trace "Building nupkg from nuspec"
    !! "**/*.nuspec"
    |> Seq.iter (fun nuspec ->
            let directory = Path.GetDirectoryName nuspec
            let nuspecName = Path.GetFileName nuspec
            trace (sprintf  "building %s in %s" nuspecName directory)

            // workaround to make choco helper happy
            let nuspecProp = nuspec
                             |> File.ReadAllText
                             |> getNuspecProperties
            let version = nuspecProp.Version
            let packageId = nuspecProp.Id
            trace (sprintf "Package id: %s with version %s" version packageId)
            nuspec
            |> Choco.PackFromTemplate (fun p -> {
                                                    p with
                                                        OutputDir = directory
                                                        Version = version
                                                        PackageId = packageId
                                                        })
        )
)

let getPackageVersionAndStatus (repoUrl:string) packageName version =
    let webClient = new System.Net.WebClient();
    let url : string = repoUrl.TrimEnd('/') + "/Packages(Id='" + packageName + "',Version='" + version + "')"
    let resp = webClient.DownloadString(url)
    let doc = XMLDoc resp

    let entry = doc.["entry"]
    let properties = entry.["m:properties"]
    let property name =
        let p = properties.["d:" + name]
        if p = null || p.IsEmpty then "" else p.InnerText
    let boolProperty name = (property name).ToLower() = "true"

    (property "Version", boolProperty "IsApproved")

let existingPackage packageId version =
    try
        Some (getPackageVersionAndStatus chocolateyFeed packageId version)
    with
        :? Net.WebException as exc -> if exc.Message.Contains("404") then None else failwith "Error"
        | _ -> failwith "Error"

let latestVersion packageId =
    try
        Some (packageId |> getLatestPackage chocolateyFeed)
    with
        :? ArgumentException -> None
        | _ -> failwith "Error"

let shouldPushNewPackage pkg =
    let metaInfo = GetMetaDataFromPackageFile pkg
    let version = metaInfo.Version
    let packageId = metaInfo.Id
    trace (sprintf "Verify package %s %s" packageId version)

    match existingPackage packageId version with
        None -> trace "Such version does not exit"
                let lastPackage = packageId |> latestVersion
                match lastPackage with
                    Some pkg -> let repoVersion = new Version(pkg.Version)
                                let localVersion = new Version(version)
                                if localVersion > repoVersion then
                                    true // push new version
                                else
                                    trace "Higher version already exists"
                                    false
                    | None -> true // push new package
        | Some (_, approved) ->
                           trace "This version already exists"
                           if not approved then
                             trace "But it is not approved"

                           not approved

Target "PublishArtifacts" (fun _ ->
    !! "**/*.nupkg"
       -- "/packages/**"
    |> Seq.filter shouldPushNewPackage
    |> Seq.iter (fun pkg ->
            trace (sprintf "Pushing package %s" pkg)
            ProcessHelper.enableProcessTracing <- false
            pkg |> Choco.Push (fun p -> { p with ApiKey = environVar chocolateyKeyVar })
            ProcessHelper.enableProcessTracing <- true
        )
)

"BuildChocoPackages"
==> "PublishArtifacts"
RunTargetOrDefault "PublishArtifacts"