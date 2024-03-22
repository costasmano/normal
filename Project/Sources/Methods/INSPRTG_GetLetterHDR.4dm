//%attributes = {"invisible":true}
//Method: INSPRTG_GetLetterHDR
//Description
// return the header of a letter based on contract type using parameter INSPRTG_LTRHeader
// Parameters
// $0 : $header_txt
// $1 : $conctractType
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/20, 14:18:15
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_TEXT:C284(INSPRTG_GetLetterHDR; $0)
	C_TEXT:C284(INSPRTG_GetLetterHDR; $1)
	
End if 
//
C_TEXT:C284($0; $1)
C_TEXT:C284($header_txt; $contrType_txt)

$contrType_txt:=$1
$header_txt:=""

C_TEXT:C284($param_txt)
$param_txt:=ut_GetSysParameter("INSPRTG_LTRHeader")
C_BOOLEAN:C305($valid_b; $foundHDR_b)
$valid_b:=False:C215
$foundHDR_b:=False:C215
If ($param_txt#"")
	C_OBJECT:C1216($param_o)
	C_TEXT:C284($methonErr)
	$methonErr:=Method called on error:C704
	C_BOOLEAN:C305(4DError_b)
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	$param_o:=JSON Parse:C1218($param_txt; Is object:K8:27)
	ON ERR CALL:C155($methonErr)
	If (4DError_b)
		ALERT:C41("Parameter INSPRTG_LTRHeader is badly formed!")
		4DError_b:=False:C215
	Else 
		ARRAY OBJECT:C1221($entries_ao; 0)
		OB GET ARRAY:C1229($param_o; "List"; $entries_ao)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($entries_ao))
			If (OB Get:C1224($entries_ao{$loop_L}; "contractype"; Is text:K8:3)=$contrType_txt)
				$header_txt:=OB Get:C1224($entries_ao{$loop_L}; "header"; Is text:K8:3)
				$foundHDR_b:=True:C214
				$loop_L:=Size of array:C274($entries_ao)+1
			End if 
		End for 
	End if 
	
End if 

If (Not:C34($foundHDR_b))
	
	Case of 
		: ($contrType_txt="@inspection@")
			$header_txt:=ut_GetSysParameter("INSPRTG_DefInspHdr"; "Statewide Bridge Inspections")
		: ($contrType_txt="@rating@")
			$header_txt:=ut_GetSysParameter("INSPRTG_DefRtgHdr"; "Statewide Bridge Ratings")
	End case 
	
End if 
$0:=$header_txt
//End INSPRTG_GetLetterHDR