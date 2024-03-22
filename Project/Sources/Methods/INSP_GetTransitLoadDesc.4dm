//%attributes = {"invisible":true,"executedOnServer":true}
//Method: INSP_GetTransitLoadDesc
//Description
//  `get the description of transit loads from other ElementSafety ratingload records
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/07/14, 16:00:52
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

ARRAY TEXT:C222($INSP_REVCARDESC_atxt; 0)
ARRAY TEXT:C222($INSP_WORKCARDESC_atxt; 0)
C_LONGINT:C283($INSPIDTEMP_L)
ARRAY LONGINT:C221($elmIDs_aL; 0)

$INSPIDTEMP_L:=[Inspections:27]InspID:2
If (Count parameters:C259>2)
	$INSPIDTEMP_L:=$3
End if 
Begin SQL
	select [ElmtRatingLoads].R_RevenueDesc_s, [ElmtRatingLoads].R_WorkCarDesc_s from [ElmtRatingLoads], [ElementsSafety]
	where
	[ElmtRatingLoads].ElmSafetyID = [ElementsSafety].ElmSafetyID
	and 
	[ElementsSafety].InspID = :$INSPIDTEMP_L
	into :$INSP_REVCARDESC_atxt , :$INSP_WORKCARDESC_atxt
End SQL

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($INSP_REVCARDESC_atxt))
	If ($INSP_REVCARDESC_atxt{$loop_L}#"")
		$1->:=$INSP_REVCARDESC_atxt{$loop_L}
		$loop_L:=Size of array:C274($INSP_REVCARDESC_atxt)+1
	End if 
End for 

For ($loop_L; 1; Size of array:C274($INSP_WORKCARDESC_atxt))
	If ($INSP_WORKCARDESC_atxt{$loop_L}#"")
		$2->:=$INSP_WORKCARDESC_atxt{$loop_L}
		$loop_L:=Size of array:C274($INSP_WORKCARDESC_atxt)+1
	End if 
End for 

//End INSP_GetTransitLoadDesc