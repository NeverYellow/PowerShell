# PowerShell CommentBased Help
Script for generating PowerShell CommentBased Help

## Motivation
While creating an PowerShell Module for the InfoBlox WAPI, i needed something to generate quickly comment blocks, so the script was created. You can use it in other scripts or use it solely on the command line.

## Style Inspiration
It tries to follow the guidelines from [PoshCode/PowerShellPracticeAndStyle](https://github.com/PoshCode/PowerShellPracticeAndStyle).

Currently it includes all defined keywords. For more information:
[About Comment Based Help](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7)

## Sample Usage 
New-CommentBasedHelp -Synopsis 'Creation of Comment-Based Help'  -Description 'Generates a Comment-Based Help header for a function or script' 

#### Output:
```
<#

    .SYNOPSIS
        Creation of Comment-Based Help

    .DESCRIPTION
        Generates a Comment-Based Help header for a function or script

#>
```
## Features
Usable on all PowerShell versions
