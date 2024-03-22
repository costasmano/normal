//%attributes = {}
//Method: fn_MinBridgeCondition
//Description
//  ` Return the minimum bridge condition based on items 58,59,60,62
//  ` will return -1 if all items are not numeric
//  `Can either pass 1-4 ratings (string 1) or if not passed will use current Bridge record
// Parameters
// $0 : $MinBridgeCond_L 
// $(1-4) : $cond1-4_s : optional : 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/14/15, 15:47:48
	// ----------------------------------------------------
	//Created : 
	Mods_2015_01
End if 
//
C_LONGINT:C283($0)
C_LONGINT:C283($MinBridgeCond_L)
$MinBridgeCond_L:=-1
ARRAY TEXT:C222($Component_as; 4)
$Component_as{1}:="N"
$Component_as{2}:="N"
$Component_as{3}:="N"
$Component_as{4}:="N"

C_LONGINT:C283($paramcount_L; $loop_L)

If (Count parameters:C259>0)
	C_TEXT:C284(${1})  // Command Replaced was o_C_STRING length was 1
	$paramcount_L:=Count parameters:C259
	
	If ($paramcount_L>4)
		$paramcount_L:=4
	End if 
	
	For ($loop_L; 1; $paramcount_L)
		$Component_as{$loop_L}:=${$loop_L}
	End for 
	
Else 
	$Component_as{1}:=[Bridge MHD NBIS:1]Item58:130
	$Component_as{2}:=[Bridge MHD NBIS:1]Item59:131
	$Component_as{3}:=[Bridge MHD NBIS:1]Item60:132
	$Component_as{4}:=[Bridge MHD NBIS:1]Item62:134
End if 
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($Component_as))
	If (bIsNumeric($Component_as{$loop_L}))
		
		Case of 
			: ($MinBridgeCond_L=-1)
				$MinBridgeCond_L:=Num:C11($Component_as{$loop_L})
			Else 
				If ($MinBridgeCond_L>Num:C11($Component_as{$loop_L}))
					$MinBridgeCond_L:=Num:C11($Component_as{$loop_L})
				End if 
		End case 
		
	End if 
End for 

$0:=$MinBridgeCond_L
//End fn_MinBridgeCondition