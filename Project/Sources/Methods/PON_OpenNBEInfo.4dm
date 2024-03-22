//%attributes = {"invisible":true}
//Method: PON_OpenNBEInfo
//Description
// Will display the NBE Elements.pdf file after copying it to a temp folder
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/29/15, 12:58:38
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
End if 
//
C_TEXT:C284($pdfgile_txt)
$pdfgile_txt:=Get 4D folder:C485(Current resources folder:K5:16)+"NBE"+<>PL_DirectorySep_s+"NBE Elements.pdf"
If (Test path name:C476($pdfgile_txt)=Is a document:K24:1)
	If (Get document size:C479($pdfgile_txt)>0)
		C_TEXT:C284($tempName_txt)
		$tempName_txt:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)
		$tempName_txt:=Replace string:C233($tempName_txt; ":"; "")
		$tempName_txt:=Replace string:C233($tempName_txt; "-"; "")
		$tempName_txt:=String:C10(Current process:C322; "00000")+"-"+$tempName_txt
		$tempName_txt:=Temporary folder:C486+$tempName_txt+".pdf"
		COPY DOCUMENT:C541($pdfgile_txt; $tempName_txt; *)
		If (OK=1)
			ut_OpenDocument($tempName_txt)
		Else 
			ALERT:C41("Error Opening NBE Elements Info document!")
		End if 
	End if 
Else 
	ALERT:C41("Cannot Find NBE Elements Info document!")
End if 
//End PON_OpenNBEInfo