#!/usr/bin/env pwsh

Param(
    [Alias('f')]
    [Switch] $Force,
    [Alias('v')]
    [Switch] $Verbose,
    [Alias('b')]
    [Switch] $BlockList
)

if($args.Length -eq 0)
{
    Write-Host "No arguments supplied"
    return
}
else
{
    $url = $args[0]
    $listFile = "./blocklist.txt"
    
    $videoName = ([uri]($url)).Segments[-2] -replace ".$"
    if ($videoName -eq "video") 
    {
        $videoName = ([uri]($url)).Segments[-1]
    }
    if ($Verbose)
    {
        Write-Host "Video identifier is $videoName"
    }
    if ($BlockList)
    {
	    if ((Get-Content $listFile) -match $videoName)
	    {
		    Write-Host "The video $videoName is already blocked."
		    return
	    }
	    else
	    {
		    Add-Content $listFile $videoName
		    Write-Host "Video $videoName blocked successfully."
		    return
	    }
    }
    if ((!$Force) -And (Get-ChildItem -Recurse . | Where-Object {$_.Name -match "$videoName"})) {
        Write-Host "The video file exists, and therefore it isn't necessary to call downloader"
        return
    }
    elseif ((Get-Content $listFile) -match $videoName)
    {
	Write-Host "The video $videoName is blocked."
    	return
    }
    else
    {
        while ($(Start-Process yt-dlp "-c ${url}" -PassThru -Wait).ExitCode -ne 0)
        {
            Write-Host "DISCONNECTED, WILL RETRY"
            Start-Sleep 3
        }
    }
}
