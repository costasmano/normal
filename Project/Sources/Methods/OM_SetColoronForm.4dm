//%attributes = {"invisible":true}
//Method: OM_SetColoronForm
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 16:43:38
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
	
End if 
//
C_TEXT:C284($1; $SelectedFile_txt; $Suffix_txt)
$Suffix_txt:=""
$Suffix_txt:=OBJECT Get title:C1068(*; "SuffixValue")
If ($Suffix_txt#"")
	$Suffix_txt:="_"+$Suffix_txt
End if 
$SelectedFile_txt:=String:C10(Year of:C25([RatingReports:65]ReportDate:4); "0000")
OBJECT SET TITLE:C194(*; "FileName"; [Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+" "+$SelectedFile_txt+String:C10(Month of:C24([RatingReports:65]ReportDate:4); "00")+Lowercase:C14(Substring:C12($1; 1; 1))+$Suffix_txt)
OBJECT SET VISIBLE:C603(*; "@Color"; False:C215)
OBJECT SET VISIBLE:C603(*; $1; True:C214)
OBJECT SET VISIBLE:C603(*; "CopyButton"; True:C214)

//End OM_SetColoronForm