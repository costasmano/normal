//%attributes = {"invisible":true}
//Method: ut_UpdateSysParameter
//Description
//Update or Create a system parameter. (create is only available for design group users)
// Parameters
// $1 : $ParamName_txt
// $2 : $Additional_txt - additional text to be shown with the prompt
// $3 : $EditValue_txt optional : if it starts with "V" the value field will be updated ; else the description field (default)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/14, 17:06:23
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_TEXT:C284($1; $ParamName_txt)
$ParamName_txt:=$1
C_BOOLEAN:C305($EditValue_b)
$EditValue_b:=False:C215  //default edit the descr field
C_TEXT:C284($Additional_txt)
$Additional_txt:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$Additional_txt:=$2
End if 

If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$EditValue_b:=($3="V@")
End if 

C_BOOLEAN:C305($FoundParam_B)
$FoundParam_B:=True:C214
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$ParamName_txt)
If (Records in selection:C76([Parameters:107])#1)
	
	If (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Parameter "+$ParamName_txt+" not found! Create it?")
		
		If (OK=1)
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:=$ParamName_txt
			SAVE RECORD:C53([Parameters:107])
			LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
		Else 
			$FoundParam_B:=False:C215
		End if 
		
	Else 
		ALERT:C41("System Parameter "+$ParamName_txt+" does not exist!!! Please notify your database administrator!")
		$FoundParam_B:=False:C215
	End if 
	
End if 

If ($FoundParam_B)
	If (ut_LoadRecordInteractive(->[Parameters:107]))
		C_TEXT:C284(vtExtraText; vsExtraTextLabel)
		
		If ($EditValue_b)
			vtExtraText:=[Parameters:107]Value:3
		Else 
			vtExtraText:=[Parameters:107]Description:2
		End if 
		
		vsExtraTextLabel:="Update system parameter "+$ParamName_txt
		
		If ($Additional_txt#"")
			vsExtraTextLabel:=vsExtraTextLabel+" "+$Additional_txt
		End if 
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "System Parameter Update")
		DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
		CLOSE WINDOW:C154
		If (Ok=1)
			If ($EditValue_b)
				[Parameters:107]Value:3:=vtExtraText
				LogChanges(->[Parameters:107]Value:3; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
			Else 
				[Parameters:107]Description:2:=vtExtraText
				LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
			End if 
			SAVE RECORD:C53([Parameters:107])
			UNLOAD RECORD:C212([Parameters:107])
		End if 
	Else 
		ALERT:C41("Could not load record for Parameter "+$ParamName_txt+" for updating")
	End if 
Else 
	
End if 
//End ut_UpdateSysParameter