[cmdletBinding()]
param(
    
    [string]$Synopsis,
    [string]$Description,
    [string[]]$Parameter,
    [string[]]$Example,
    [string]$Inputs,
    [string]$Outputs,
    [string]$Notes,
    [string]$Link,
    [string]$Component,
    [string]$Role,
    [string]$Functionality,
    [string]$ForwardHelpTargetName,
    [string]$ForwardHelpCategory,
    [string]$RemoteHelpRunspace,
    [string]$ExternalHelp,
    [string]$ScriptFilename,
    [string]$ScriptAuthor,
    [string]$ScriptPurpose,
    [string]$ScriptPrerequisite,
    [string]$ScriptVersion,
    [switch]$ParameterAsXML,
    [switch]$WordWrap,
    [int]$MaxWidth,
    [switch]$DetectPipeline

)

function New-WordWrap() {

    <#

    .SYNOPSIS
        WordWrap function

    .DESCRIPTION
        Attempts to wrap a string at the word boundary given a maximum width

    .PARAMETER InputString
        String who needs tob wrapped at a certain width on a word boundary

    .PARAMETER MaxWidth
        Maximum string width

    .PARAMETER UseNewLine
        If specified, it returns a string and not an array of strings

    .EXAMPLE
        New-WordWrap -InputString $LongString -MaxWidth 45 -UseNewLine

    .NOTES
        Filename         : New-WordWrap
        BasedOn          : Word-Wrap Function Posh-IBWAPI (Ryan Bolger)
        Creation Date    : 01-07-2020
        Author           : Paschal Bekke
        Copyright        : (c) 2020 - Paschal Bekke
        Purpose / Change : Create a WordWrapped string
        Prerequisite     : None
        Version          : 0.2
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [string[]]$InputString,
        [int]$MaxWidth=$Host.UI.RawUI.BufferSize.Width,
        [switch]$UseNewLine
    )

    process {

        $TextBuffer = @()
        
        $workString = $InputString.Split([System.Environment]::NewLine) # If line contains newline, split it into multiple parts

        foreach($line in $workString){
            while ($line.length -gt $MaxWidth) {
                $NewLine = ''
                $LastSpaceIndex = $line.LastIndexOf(' ',$MaxWidth)
                if($LastSpaceIndex -le 0) {
                    $LastSpaceIndex = $MaxWidth
                }
                $NewLine = $line.substring(0,$LastSpaceIndex)

                $line = $line.Substring($lastSpaceIndex + 1)
                $TextBuffer += $NewLine
            }
            $TextBuffer += $line
        }
        
        if($UseNewLine -eq $true) { 
            $TextBuffer = $TextBuffer -join [System.Environment]::NewLine 
        }
        return($TextBuffer)
    }
}

function New-CommentBasedEntry($HeaderEntry, $EntryValue, $UseWordWrap, $MaxLineLength) {
    $HeaderText = @()
    $IndentLevel = 4
    $Spaces = "".PadRight($IndentLevel,' ')

    foreach ($entry in $EntryValue) {
        if ($UseWordWrap -eq $true) {
            $entry = New-WordWrap -InputString $entry -UseNewLine -MaxWidth $MaxLineLength
        }
        $entry = $entry -replace('\n',"`n$spaces$spaces")
        if($HeaderEntry -eq '.PARAMETER') {
            $HeaderText += "$spaces$HeaderEntry $entry"
        } else {
            $HeaderText += "$spaces$HeaderEntry"
            $HeaderText += "$spaces$spaces$entry"
        }
        $HeaderText += ""
    }
    return($HeaderText)
}
function New-NotesSection($NotesArray, $NotesEntry, $EntryValue) {
    switch($NotesEntry) {
        'ScriptFilename'     { $CreationDate = Get-Date -Format 'MM-dd-yyyy'; $NotesArray += "Filename         : $ScriptFilename`nCreation Date    : $CreationDate`n" }
        'ScriptVersion'      { $NotesArray += "Version          : $ScriptVersion`n" }
        'ScriptAuthor'       { $Year = Get-Date -Format 'yyyy'; $NotesArray += "Author           : $ScriptAuthor`nCopyright        : (c) $Year - $ScriptAuthor`n" }
        'ScriptPurpose'      { $NotesArray += "Purpose / Change : $ScriptPurpose`n" }
        'ScriptPrerequisite' { $NotesArray += "Prerequisite     : $ScriptPrerequisite`n" }
    }
    return($NotesArray)
}


$DefinedParameters = @('Synopsis','Description','Parameter','Example','Inputs','Outputs','Notes','Link','Component', `
                       'Role','Functionality','ForwardHelpTargetName','ForwardHelpCategory','RemoteHelpRunspace', `
                       'Component','ExternalHelp')

$NotesParameters = @('ScriptFilename','ScriptAuthor','ScriptPurpose','ScriptPrerequisite','ScriptVersion')

# Search the PSBoundParameters for the presence of a 'Script*' parameter, so we can build a '.NOTES' section
$SearchParameterPresent = if($PSBoundParameters.Keys -match "^Script") { $true } else { $false }
$NotesText = @()

if($SearchParameterPresent -eq $true) {
    foreach ($item in $NotesParameters) {
        if ($PSBoundParameters[$item]) { 
            $NotesText = New-NotesSection -NotesArray $NotesText -NotesEntry $item -EntryValue $PSBoundParameters.item($item)
        }
    }
    $PSBoundParameters.Remove('Notes') | Out-Null # Remove parameter 'Notes' if present, ignore True or False 
    $PSBoundParameters.Add('Notes',$NotesText) # Add the parameter 'Notes' with the NotesText block
}

# Process the parameters and create a Comment-Based block
$FunctionHeader = @()
$FunctionHeader += "<#`n"

foreach ($item in $DefinedParameters) {
    if ($PSBoundParameters[$item]) { 
        if ($WordWrap -eq $true) {
            if ($PSBoundParameters.ContainsKey('MaxWidth') -eq $false) { $MaxWidth = 100 }
            $FunctionHeader += New-CommentBasedEntry -HeaderEntry  ".$($item.toupper())" -EntryValue $PSBoundParameters.item($item) -UseWordWrap $true -MaxLineLength $MaxWidth
        } else {
            $FunctionHeader += New-CommentBasedEntry -HeaderEntry  ".$($item.toupper())" -EntryValue $PSBoundParameters.item($item) -UseWordWrap $false -MaxLineLength 0
        }
    }
}
$FunctionHeader += "#>`n"

if($DetectPipeline -eq $true) {
    $Line = ($PSCmdlet.MyInvocation.Line).ToString()
    if($Line.Contains('|') -eq $true ) {
        $ReturnVariable = $PSBoundParameters
    
        return(,$ReturnVariable)
    
    } else {
        If($ParameterAsXML -eq $true) {
            ConvertTo-Xml -InputObject $PSBoundParameters -As String
        } else {
            Return($FunctionHeader)
        }
    }
} else {
    Return($FunctionHeader)
}   

<#

    .SYNOPSIS
        Creation of Comment-Based Help

    .DESCRIPTION
        Generates a Comment-Based Help header for a function or script

    .PARAMETER Synopsis
        A brief description of the function or script. This keyword can be used only once in each topic.

    .PARAMETER Description
        A detailed description of the function or script. This keyword can be used only once in each topic.

    .PARAMETER Parameter
        The description of a parameter. Add a ".PARAMETER" keyword for each parameter in the function or
        script syntax.

    .PARAMETER Example
        A sample command that uses the function or script, optionally followed by sample output and a
        description.

    .PARAMETER Inputs
        The Microsoft .NET Framework types of objects that can be piped to the function or script. You can
        also include a description of the input objects.

    .PARAMETER Outputs
        The .NET Framework type of the objects that the cmdlet returns. You can also include a description
        of the returned objects.

    .PARAMETER Notes
        Additional information about the function or script.

    .PARAMETER Link
        The name of a related topic. The value appears on the line below the ".LINK" keyword and must be
        preceded by a comment symbol # or included in the comment block.

    .PARAMETER Component
        The technology or feature that the function or script uses, or to which it is related. This content
        appears when the Get-Help command includes the Component parameter of Get-Help.

    .PARAMETER Role
        The user role for the help topic. This content appears when the Get-Help command includes the Role
        parameter of Get-Help.

    .PARAMETER Functionality
        The intended use of the function. This content appears when the Get-Help command includes the
        Functionality parameter of Get-Help.

    .PARAMETER ForwardHelpTargetName
        Redirects to the help topic for the specified command. You can redirect users to any help topic,
        including help topics for a function, script, cmdlet, or provider.

    .PARAMETER ForwardHelpCategory
        Specifies the help category of the item in "ForwardHelpTargetName". Valid values are "Alias",
        "Cmdlet", "HelpFile", "Function", "Provider", "General", "FAQ", "Glossary", "ScriptCommand",
        "ExternalScript", "Filter", or "All". Use this keyword to aVoid conflicts when there are commands
        with the same name.

    .PARAMETER RemoteHelpRunspace
        Specifies a session that contains the help topic. Enter a variable that contains a "PSSession". This
        keyword is used by the Export-PSSession cmdlet to find the help topics for the exported commands.

    .PARAMETER ExternalHelp
        Specifies an XML-based help file for the script or function.

    .PARAMETER ScriptFilename
        Specifies the name of the script, used for the Notes section.
        If specified, the specified -Notes parameter will not be used.

    .PARAMETER ScriptAuthor
        Name of the author of the function or script, used for the Notes section.
        If specified, the specified -Notes parameter will not be used.

    .PARAMETER ScriptPurpose
        What the function or script does, its purpose. Used in the Notes section.
        If specified, the specified -Notes parameter will not be used.

    .PARAMETER ScriptPrerequisite
        the dependency the function or script needs for working correctly. Used in the Notes section
        If specified, the specified -Notes parameter will not be used.

    .PARAMETER ScriptVersion
        Version number of the function or script. Used in the Notes section
        If specified, the specified -Notes parameter will not be used. 

    .PARAMETER ParameterAsXML
        Outputs all the used parameters and their arguments as XML

    .PARAMETER WordWrap
        Use WordWrap when outputting a line of text.

    .PARAMETER MaxWidth
        MaxWidth of the textline. Used in conjunction with the -WordWrap parameter.
        When not specified it uses a default of 100

    .EXAMPLE
        Example 1
        
        New-CommentBasedHelp @SynopsisHash -Parameter $ParameterArray @VersionHash -Example $ExampleArray

    .EXAMPLE
        Example 2
        
        New-CommentBasedHelp -Synopsis 'Short Description' -Description 'Long Description' @VersionHash

    .EXAMPLE
        Example 3
        
        New-CommentBasedHelp @SynopsisHash -Parameter $ParameterArray @VersionHash -Example $ExampleArray
        -WordWrap -MaxWidth 115

    .NOTES
        Filename         : New-CommentBasedHelp
        Creation Date    : 03-13-2020
        Author           : NeverYellow
        Copyright        : (c) 2020 - NeverYellow
        Purpose / Change : Creation of Comment-Based Help
        Prerequisite     : None
        Version          : 0.3
        

#>