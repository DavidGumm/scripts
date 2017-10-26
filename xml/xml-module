function new-xml {
Param (
    [parameter(Mandatory=$true,
    ValueFromPipeline=$true)]
    [String[]]
    $Path,
    [parameter(Mandatory=$false,
    ValueFromPipeline=$true)]
    [String[]]
    $RootName,
    [parameter(Mandatory=$false,
    ValueFromPipeline=$true)]
    [ValidateSet('iso-8859-1','utf-8','utf-16')]
    [String[]]
    $Encoding,
    [parameter(Mandatory=$false,
    ValueFromPipeline=$true)]
    [ValidateSet('yes','no')]
    [String[]]
    $Standalone,
    [parameter(Mandatory=$false,
    ValueFromPipeline=$true)]
    [switch]
    $Force = $true)

      <#
      .SYNOPSIS
      Build new xml documents.
      .DESCRIPTION
      Build new xml documents with custom parameters.
      .EXAMPLE
      new-xml -Path "SomePath\SomeFileName.xml" -RootName "root" -Encoding utf-8 -Standalone yes -Force
      .EXAMPLE
      new-xml -Path "SomePath\SomeFileName.xml"
      .PARAMETER Path
      Set the path and file name to save to.
      .PARAMETER RootName
      Set the name of the root element in the xml document.
      .PARAMETER Encoding
      Set the encoding option in the xml declaration.
      .PARAMETER Standalone
      Set the standalone option in the xml declaration.
      .PARAMETER Force
      This is a switch, turn on and it will auto overwrite the file.
      .AUTHOR
      Copyright David Gumm.
      .DOWNLOAD
      https://github.com/DavidGumm/PowerShell
      #>

    IF($RootName -eq $null) {$RootName = "root"}
    IF($Encoding -eq $null) {$Encoding = "utf-8"}
    IF($Standalone -eq $null) {$Standalone = "yes"}

    $FullPath = Split-Path $Path
    $FileName = Split-Path $Path -Leaf
    $PathTest = Test-Path $FullPath

    IF(!$PathTest){
    "Path does not exist.`r`nPlease try again"
    }
    IF($PathTest){
        $FileTest = Test-Path $Path
        IF($FileTest){
            IF($Force){
                $Overwrite = $True
            }
            IF($Force -eq $null){
                [ValidateSet('y','n','yes','no')]$OverwritePrompt = (Read-Host -Prompt "File `'$FileName`' already exists, would you like to overwrite it?`r`n[y]es [n]o").ToLower()
                Write-Host $OverwritePrompt[0]
                IF($OverwritePrompt[0] -eq 'y'){$Overwrite = $true}
                IF($OverwritePrompt[0] -eq 'n'){
                "Stopping new-xml, without overwriting file `'$FileName`'"
                Break
            }
            }
            IF($Overwrite){
                $XmlDocument = New-Object System.Xml.XmlDocument
                $XmlDeclaration = $XmlDocument.CreateXmlDeclaration("1.0",$Encoding,$Standalone)
                $XmlDocument.AppendChild($XmlDeclaration);
                $XmlRoot = $XmlDocument.CreateElement($RootName)
                $XmlDocument.appendChild($XmlRoot)
                $XmlDocument.Save($Path)
            }
        }
    }
}





<#

$Path = "$env:HOMEDRIVE" + "$env:HOMEPATH\Desktop\Document.xml"
new-xml -Path $Path -RootName "root" -Encoding utf-8 -Standalone yes -Force


$filePath = "$env:HOMEPATH\Desktop\Document.xml"
$xmlinfo = @"
<?xml version="1.0" encoding="utf-8"?>
<data/>
"@

$doc = New-Object System.Xml.XmlDocument
$doc.Load($filePath)
$doc.DocumentElement.RemoveAll()
$notes = ("https://www.bing.com","Default for Edge"),("https://www.google.com","Default for Chrome"),("https://www.google.com","Default for Firefox")
$count = 0

Foreach($object in $notes){
    $child = $doc.CreateElement("website")
    $child.SetAttribute("index",$count)
    $child.SetAttribute("value",$object[0])
    $child.SetAttribute("note", $object[1])
    $doc.DocumentElement.AppendChild($child)
    $count++
}
$doc.Save($filePath)
$doc.data.website[2].value = "https://www.yahoo.com"
$doc.data.website[2].value
$doc.Save($filePath)

#>
