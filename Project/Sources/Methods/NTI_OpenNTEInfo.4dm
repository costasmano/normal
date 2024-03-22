//%attributes = {"invisible":true}
//Method: NTI_OpenNTEInfo
//Description
// open the pdf for TIN Inspection help.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/18, 15:56:34
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
End if 
//

C_TEXT:C284($pdfFile_txt)
$pdfFile_txt:=Get 4D folder:C485(Current resources folder:K5:16)+"TIN"+<>PL_DirectorySep_s+"TIN Inspection.pdf"
If (Test path name:C476($pdfFile_txt)=Is a document:K24:1)
	If (Get document size:C479($pdfFile_txt)>0)
		C_TEXT:C284($tempName_txt)
		$tempName_txt:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)
		$tempName_txt:=Replace string:C233($tempName_txt; ":"; "")
		$tempName_txt:=Replace string:C233($tempName_txt; "-"; "")
		$tempName_txt:=String:C10(Current process:C322; "00000")+"-"+$tempName_txt
		$tempName_txt:=Temporary folder:C486+$tempName_txt+".pdf"
		COPY DOCUMENT:C541($pdfFile_txt; $tempName_txt; *)
		If (OK=1)
			ut_OpenDocument($tempName_txt)
		Else 
			ALERT:C41("Error Opening TIN Inspections Info document!")
		End if 
	End if 
Else 
	ALERT:C41("Cannot Find TIN Inspections Info document!")
End if 
//End NTI_OpenNTEInfo