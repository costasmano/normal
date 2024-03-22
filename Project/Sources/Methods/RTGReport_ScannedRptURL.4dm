//%attributes = {"invisible":true}
//Method: RTGReport_ScannedRptURL
//Description
// returns a URL to open a scanned report found using method RTGReport_FindScanned 
// result can be used in an excel file to open the link
// Parameters
// $0 : $URL_txt
// $1 : $BDEPT
// $2 : $BIN
// $3 : $RatingReportDate_d
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/19, 16:43:29
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
	
	C_TEXT:C284(RTGReport_ScannedRptURL; $0)
	C_TEXT:C284(RTGReport_ScannedRptURL; $1; $2)
	C_DATE:C307(RTGReport_ScannedRptURL; $3)
	Mods_2020_07  //Made change to allow for correct info for $ServerMask_txt and $baseSpec_txt
	//Modified by: CJ (7/28/20 11:42:22)
	
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($1; $2)
C_DATE:C307($3)

C_TEXT:C284($PdfFound_txt; $targetspec_txt)
$targetspec_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")

$PdfFound_txt:=RTGReport_FindScanned($1; $2; $3)

If ($PdfFound_txt#"")
	$0:="File:////"+$targetspec_txt+"/"+$PdfFound_txt
Else 
	$0:=""
End if 

//End RTGReport_ScannedRptURL