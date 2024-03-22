//%attributes = {"invisible":true}
//Method: PON_VerifyUniqueKeys
//Description
// Check current inspection for duplicate element key combination
// StructUnit + elemkey + envKey + parentkey + grandparentkey
// report any/all errors in a text
// Parameters
//$0 : $PontisErrors_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/04/16, 14:37:33
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	C_TEXT:C284(PON_VerifyUniqueKeys; $0)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($PontisErrors_txt)
$PontisErrors_txt:=""
ARRAY LONGINT:C221($Strunit_aL; 0)
ARRAY LONGINT:C221($elemKey_aL; 0)
ARRAY LONGINT:C221($envKey_aL; 0)
ARRAY LONGINT:C221($ParKey_aL; 0)
ARRAY LONGINT:C221($GrandPKey_aL; 0)
C_LONGINT:C283($InspID_L)
$InspID_L:=[Inspections:27]InspID:2
ARRAY TEXT:C222($CompoundKeys_atxt; 0)
Begin SQL
	select
	[PON_ELEM_INSP].[STRUNITKEY],
	[PON_ELEM_INSP].[ELEM_KEY],
	[PON_ELEM_INSP].[ENVKEY],
	[PON_ELEM_INSP].[ELEM_PARENT_KEY],
	[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
	from [PON_ELEM_INSP]
	where 
	[PON_ELEM_INSP].[INSPID] = :$InspID_L
	into 
	:$Strunit_aL,
	:$elemKey_aL,
	:$envKey_aL,
	:$ParKey_aL,
	:$GrandPKey_aL ;
End SQL
ARRAY TEXT:C222($CompoundKeys_atxt; Size of array:C274($Strunit_aL))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Strunit_aL))
	$CompoundKeys_atxt{$loop_L}:=String:C10($Strunit_aL{$loop_L})+"_"+String:C10($elemKey_aL{$loop_L})+"_"+String:C10($envKey_aL{$loop_L})+"_"+String:C10($ParKey_aL{$loop_L})+"_"+String:C10($GrandPKey_aL{$loop_L})
End for 

ARRAY TEXT:C222($Duplicates_atxt; 0)

C_LONGINT:C283($loop_L; $DupKeyIndx_L; $alreadyFound_L)
For ($loop_L; 1; (Size of array:C274($CompoundKeys_atxt)-1))
	$DupKeyIndx_L:=Find in array:C230($CompoundKeys_atxt; $CompoundKeys_atxt{$loop_L}; ($loop_L+1))
	If ($DupKeyIndx_L>0)
		//check to see if we found it already
		$alreadyFound_L:=Find in array:C230($Duplicates_atxt; $CompoundKeys_atxt{$loop_L})
		
		If ($alreadyFound_L>0)
			
		Else 
			//add it
			APPEND TO ARRAY:C911($Duplicates_atxt; $CompoundKeys_atxt{$loop_L})
			//build the Message
			$PontisErrors_txt:=$PontisErrors_txt+Char:C90(13)
			$PontisErrors_txt:=$PontisErrors_txt+"Struct. Unit "+String:C10($Strunit_aL{$loop_L})+", Element "+String:C10($elemKey_aL{$loop_L})+", Env "+String:C10($envKey_aL{$loop_L})
			If ($ParKey_aL{$loop_L}>0)
				$PontisErrors_txt:=$PontisErrors_txt+", Parent "+String:C10($ParKey_aL{$loop_L})
			End if 
			If ($GrandPKey_aL{$loop_L}>0)
				$PontisErrors_txt:=$PontisErrors_txt+", GrandParent "+String:C10($GrandPKey_aL{$loop_L})
			End if 
		End if 
		
	End if 
End for 
If ($PontisErrors_txt#"")
	$PontisErrors_txt:="ERROR !!! Multiple instances of the following Elements have been found :"+$PontisErrors_txt
End if 
$0:=$PontisErrors_txt
//End PON_CheckUniqueKeys