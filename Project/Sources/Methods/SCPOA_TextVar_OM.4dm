//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/06/09, 15:10:54
	// ----------------------------------------------------
	// Method: SCPOA_TextVar_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $Text_ptr
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_POINTER:C301($1; $Text_ptr)
$Text_ptr:=$1
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284(vtExtraText)
		C_TEXT:C284(vsExtraTextLabel)  // Command Replaced was o_C_STRING length was 132
		vtExtraText:=$Text_ptr->
		vsExtraTextLabel:="Edit Text"
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l; $WL_L; $WT_L; $WR_L; $WB_L)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
		$WR_L:=(7*($WR_L-$WL_L))/8
		$WB_L:=($WB_L-$WT_L)/2
		$Width_l:=MaxNum($WR_L; $Width_l)
		$Height_l:=MaxNum($WB_L; $Height_l)
		CENTER_WINDOW($Width_l; $Height_l; Plain window:K34:13; "ScourPOA Edit Window")
		DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
		CLOSE WINDOW:C154
		
		If (OK=1)
			$Text_ptr->:=f_TrimStr(vtExtraText; True:C214; True:C214)
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		End if 
		vtExtraText:=""
		
End case 