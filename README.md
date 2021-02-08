# PowerShell CommentBased Help
Script for generating PowerShell CommentBased Help

# Motivation
While creating an PowerShell Module for the InfoBlox WAPI, i needed something to generate quickly comment blocks, so the script was created. You can use it in other scripts or use it solely on the command line.

# Style Inspiration
It tries to follow the guidelines from [PoshCode/PowerShellPracticeAndStyle](https://github.com/PoshCode/PowerShellPracticeAndStyle).

Currently it includes all defined keywords. For more information:
[About Comment Based Help](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7)

# Sample Usage 
New-CommentBasedHelp -Synopsis 'Creation of Comment-Based Help'  -Description 'Generates a Comment-Based Help header for a function or script' 

#### Sample Output:
```
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
        Creation Date    : 02-08-2021
        Author           : NeverYellow
        Copyright        : (c) 2021 - NeverYellow
        Purpose / Change : Creation of Comment-Based Help
        Prerequisite     : None
        Version          : 0.3
#>

```
# Features
- Usable on all PowerShell versions
- [PowerShell Splatting](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7) can be used
- Output as Text, XML or HashTable (PSBoundParameters)


# Demo Sample Variable Script
There's also an extra script which sets a set of global variables, used for demonstrating the usage of the script.

- Create-GlobalSampleVariable.ps1

