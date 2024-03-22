//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/12, 11:15:56
//----------------------------------------------------
//Method: ut_DisplayUserMode
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003 `Modify launch of user mode to be in its own process
	//Modified by: Charles Miller (2/14/12 11:25:54)
	Mods_2012_10  //r003 ` Make sure to take into account invalid table numbers
	//Modified by: Charles Miller (10/30/12 16:14:00)
End if 

ControlMenuBar(12)
READ ONLY:C145([Parameters:107])

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="UserInputForms")
If (Records in selection:C76([Parameters:107])=0)
	ALERT:C41("No UserInputForms parameter record. Only forms named Input will be used or work")
End if 
ARRAY TEXT:C222($Forms_axt; 0)
C_TEXT:C284($CR; $quote)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($i)
$CR:=Char:C90(13)
ut_TextToArray([Parameters:107]Description:2; ->$Forms_axt; $CR)
ARRAY TEXT:C222(UserForms_atxt; 0)
ARRAY TEXT:C222(UserForms_atxt; Get last table number:C254)
ARRAY TEXT:C222($tableNames_atxt; 0)
ARRAY TEXT:C222($tableNames_atxt; Get last table number:C254)
ARRAY BOOLEAN:C223($Aceess_ab; 0)
ARRAY BOOLEAN:C223($Aceess_ab; Get last table number:C254)

For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		UserForms_atxt{$i}:="Input"
		$tableNames_atxt{$i}:="["+Table name:C256($i)+"]"
		$Aceess_ab{$i}:=True:C214
	Else 
		$Aceess_ab{$i}:=False:C215
	End if 
End for 

$quote:=Char:C90(Double quote:K15:41)
C_POINTER:C301($Table_ptr)
C_LONGINT:C283($Table_l)
For ($i; 1; Size of array:C274($Forms_axt))
	ARRAY TEXT:C222($SplitForms_axt; 0)
	ut_TextToArray($Forms_axt{$i}; ->$SplitForms_axt; ";")
	$Table_l:=Find in array:C230($tableNames_atxt; $SplitForms_axt{1})
	If ($Table_l>0)  //this should never be but in case don't stop
		UserForms_atxt{$Table_l}:=Replace string:C233($SplitForms_axt{2}; $quote; "")
	Else 
		ALERT:C41("Badly defined table/form in parameters file key of UserInputForms. The previous value was "+$Forms_axt{$i-1})
	End if 
End for 

//
InitProcessVar
UserMode_Forms(->UserForms_atxt)
UserMode_Access("Modify"; ->$Aceess_ab)
UserMode_Access("New"; ->$Aceess_ab)
UserMode_Access("Delete"; ->$Aceess_ab)
UserMode_Access("Report"; ->$Aceess_ab)
UserMode_Access("Import"; ->$Aceess_ab)
UserMode_Access("Export"; ->$Aceess_ab)
UserMode_Access("Execute"; ->$Aceess_ab)

UserMode_Show
//End ut_DisplayUserMode