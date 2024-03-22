//%attributes = {"invisible":true}
//Method: Test_scanActLogRefIDs
//Description
// scan Act Log refIDs to find any large breaks
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/13/17, 14:57:49
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
End if 
//
ARRAY LONGINT:C221($ActLogRefIDS_aL; 0)
Begin SQL
	select [Activity Log].[RefID]
	from [Activity Log]
	into :$ActLogRefIDS_aL ;
	
End SQL
SORT ARRAY:C229($ActLogRefIDS_aL; >)

C_LONGINT:C283($loop_L; $maxDiff_L; $DeltaCheck_L; $maxDiffRefID_L)
$maxDiff_L:=0
$DeltaCheck_L:=10
For ($loop_L; 6; Size of array:C274($ActLogRefIDS_aL))
	If (($ActLogRefIDS_aL{$loop_L}-$ActLogRefIDS_aL{$loop_L-1})>$DeltaCheck_L)
		
		If ($maxDiff_L<($ActLogRefIDS_aL{$loop_L}-$ActLogRefIDS_aL{$loop_L-1}))
			$maxDiff_L:=($ActLogRefIDS_aL{$loop_L}-$ActLogRefIDS_aL{$loop_L-1})
			$maxDiffRefID_L:=$ActLogRefIDS_aL{$loop_L}
		Else 
			
		End if 
		
	End if 
	
End for 
ALERT:C41("Max diff in act log ref Ids = "+String:C10($maxDiff_L)+" at refID "+String:C10($maxDiffRefID_L))
//End Test_scanActLogRefIDs