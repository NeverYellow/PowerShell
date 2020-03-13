<#

    .SYNOPSIS
        Create Sample Array/Hashes

    .DESCRIPTION
        Create Array/Hash Tables used as Sample Parameters for New-CommentBasedHelp

    .NOTES
        Filename         : Create-GlobalSampleVariable
        Creation Date    : 02-04-2020
        Author           : Paschal Bekke
        Copyright        : (c) 2020 - Paschal Bekke
        Purpose / Change : Create Array/Hash Tables used as Sample Parameters for use with New-CommentBasedHelp
        Prerequisite     : No Prerequisite
        Version          : 0.2


#>
[cmdletBinding()]
param()

# Use as Array ($ParameterArray)

$Global:ParameterArray = [System.Collections.ArrayList]@()
[Void]$ParameterArray.add("Synopsis`nA brief description of the function or script. This keyword can be used only once in each topic.")
[Void]$ParameterArray.add("Description`nA detailed description of the function or script. This keyword can be used only once in each topic.")
[Void]$ParameterArray.add("Parameter`nThe description of a parameter. Add a `".PARAMETER`" keyword for each parameter in the function or script syntax.")
[Void]$ParameterArray.add("Example`nA sample command that uses the function or script, optionally followed by sample output and a description.")
[Void]$ParameterArray.add("Inputs`nThe Microsoft .NET Framework types of objects that can be piped to the function or script. You can also include a description of the input objects.")
[Void]$ParameterArray.add("Outputs`nThe .NET Framework type of the objects that the cmdlet returns. You can also include a description of the returned objects.")
[Void]$ParameterArray.add("Notes`nAdditional information about the function or script.")
[Void]$ParameterArray.add("Link`nThe name of a related topic. The value appears on the line below the `".LINK`" keyword and must be preceded by a comment symbol # or included in the comment block.")
[Void]$ParameterArray.add("Component`nThe technology or feature that the function or script uses, or to which it is related. This content appears when the Get-Help command includes the Component parameter of Get-Help.")
[Void]$ParameterArray.add("Role`nThe user role for the help topic. This content appears when the Get-Help command includes the Role parameter of Get-Help.")
[Void]$ParameterArray.add("Functionality`nThe intended use of the function. This content appears when the Get-Help command includes the Functionality parameter of Get-Help.")
[Void]$ParameterArray.add("ForwardHelpTargetName`nRedirects to the help topic for the specified command. You can redirect users to any help topic, including help topics for a function, script, cmdlet, or provider.")
[Void]$ParameterArray.add("ForwardHelpCategory`nSpecifies the help category of the item in `"ForwardHelpTargetName`". Valid values are `"Alias`", `"Cmdlet`", `"HelpFile`", `"Function`", `"Provider`", `"General`", `"FAQ`", `"Glossary`", `"ScriptCommand`", `"ExternalScript`", `"Filter`", or `"All`". Use this keyword to aVoid conflicts when there are commands with the same name.")
[Void]$ParameterArray.add("RemoteHelpRunspace`nSpecifies a session that contains the help topic. Enter a variable that contains a `"PSSession`". This keyword is used by the Export-PSSession cmdlet to find the help topics for the exported commands.")
[Void]$ParameterArray.add("ExternalHelp`nSpecifies an XML-based help file for the script or function.")
[Void]$ParameterArray.add("ScriptFilename`nSpecifies the name of the script, used for the Notes section.`nIf specified, the specified -Notes parameter will not be used.")
[Void]$ParameterArray.add("ScriptAuthor`nName of the author of the function or script, used for the Notes section.`nIf specified, the specified -Notes parameter will not be used.")
[Void]$ParameterArray.add("ScriptPurpose`nWhat the function or script does, its purpose. Used in the Notes section.`nIf specified, the specified -Notes parameter will not be used.")
[Void]$ParameterArray.add("ScriptPrerequisite`nthe dependency the function or script needs for working correctly. Used in the Notes section`nIf specified, the specified -Notes parameter will not be used.")
[Void]$ParameterArray.add("ScriptVersion`nVersion number of the function or script. Used in the Notes section`nIf specified, the specified -Notes parameter will not be used. ")
[Void]$ParameterArray.add("ParameterAsXML`nOutputs all the used parameters and their arguments as XML")
[Void]$ParameterArray.add("WordWrap`nUse WordWrap when outputting a line of text.")
[Void]$ParameterArray.add("MaxWidth`nMaxWidth of the textline. Used in conjunction with the -WordWrap parameter.`nWhen not specified it uses a default of 100")

# Use as Array ($ExampleArray)

$Global:ExampleArray = [System.Collections.ArrayList]@()
[Void]$ExampleArray.add("Example 1`n`nNew-CommentBasedHelp `@SynopsisHash -Parameter `$ParameterArray `@VersionHash -Example `$ExampleArray")
[Void]$ExampleArray.add("Example 2`n`nNew-CommentBasedHelp -Synopsis 'Short Description' -Description 'Long Description' `@VersionHash")
[Void]$ExampleArray.add("Example 3`n`nNew-CommentBasedHelp `@SynopsisHash -Parameter `$ParameterArray `@VersionHash -Example `$ExampleArray -WordWrap -MaxWidth 115")

# Use as Hash (@VersionHash)

$Global:VersionHash = [System.Collections.Specialized.OrderedDictionary]@{}
$VersionHash.Add("ScriptFilename","New-CommentBasedHelp")
$VersionHash.Add("ScriptAuthor","NeverYellow")
$VersionHash.Add("ScriptPurpose","Creation of Comment-Based Help")
$VersionHash.Add("ScriptPrerequisite","None")
$VersionHash.Add("ScriptVersion","0.3")

# Use as Hash (@CmdletHash)

$Global:CmdletHash = [System.Collections.Specialized.OrderedDictionary]@{}
$CmdletHash.Add('Synopsis','Creation of Comment-Based Help')
$CmdletHash.add('Description','Generates a Comment-Based Help header for a function or script')

$Infotext = @"

Created the following Sample Variables for use with New-CommentBasedHelp

ParameterArray - use as Array for the -Parameter parameter (`$ParameterArray)
VersionHash    - use as Hash Table Splatting (`@VersionHash)
CmdletHash     - use as Hash Table Splatting (`@CmdletHash)
ExampleArray   - use as Array for the -Example parameter (`$ExampleArray)

Use the following syntax for use with New-CommentBasedHelp cmdlet

New-CommentBasedHelp `@CmdletHash -Parameter `$ParameterArray `@VersionHash -Example `$ExampleArray -WordWrap

"@

Write-Output $Infotext

# New-CommentBasedHelp @CmdletHash -Parameter $ParameterArray @VersionHash