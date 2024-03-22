//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/09/05, 08:20:06
	// ----------------------------------------------------
	// Method: WKHR_SetCmmtTxtTop
	// Description
	// Calculate the top of the text comments object
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(06/19/08, 08:37:55
	Mods_2008_CM_5403("WKHRS")
End if 
C_LONGINT:C283($0)
C_LONGINT:C283($Btn1L; $Btn1T; $Btn1R; $Btn1B; $NewTextTop; $MaxSubcount)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($BtnPrefix)  // Command Replaced was o_C_STRING length was 32
If (WKHR_SubItemCount>WKHR_OffEstSubItemCount)
	$MaxSubcount:=WKHR_SubItemCount
	$BtnPrefix:="ButtonMinus"
Else 
	$MaxSubcount:=WKHR_OffEstSubItemCount
	$BtnPrefix:="ButtonMinus"
End if 

If ($MaxSubcount>0)
	OBJECT GET COORDINATES:C663(*; $BtnPrefix+String:C10($MaxSubcount)+"@"; $Btn1L; $Btn1T; $Btn1R; $Btn1B)
	If (WKHR_CommentsShown)
		$NewTextTop:=$Btn1B+15
	Else 
		$NewTextTop:=$Btn1B
	End if 
	
Else 
	OBJECT GET COORDINATES:C663(*; $BtnPrefix+"1"; $Btn1L; $Btn1T; $Btn1R; $Btn1B)
	$NewTextTop:=$Btn1T
End if 
$0:=$NewTextTop