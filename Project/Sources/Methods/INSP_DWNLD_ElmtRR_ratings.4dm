//%attributes = {"invisible":true}
//Method: INSP_DWNLD_ElmtRR_ratings
//Description
// download records from table [ElmtRatingLoads] related to the [ElementsSafety] of current inspection
// Parameters
// $0 : True if downloaded ok
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/23/15, 15:28:17
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
End if 
//
C_BOOLEAN:C305($0)
$0:=True:C214
C_LONGINT:C283(RemoteInspID_L; INSP_LocalInspID_L; $TableNumber_l)
$TableNumber_l:=Table:C252(->[ElementsSafety:29])
clone_ClearFieldVariables($TableNumber_l)
//get all remote elementsafety ids
Begin SQL
	select
	[ElementsSafety].[ElmSafetyID]
	from
	[ElementsSafety]
	where
	[ElementsSafety].[InspID] = :RemoteInspID_L
	into 
	:v_29_007_aL ;
End SQL

If (Size of array:C274(v_29_007_aL)>0)
	//loop through all and get any [ElmtRatingLoads]
	C_LONGINT:C283($loop_L; $localElmID_L)
	C_TEXT:C284($localElmID_txt)
	For ($loop_L; 1; Size of array:C274(v_29_007_aL))
		$localElmID_txt:=aLookUpDest($TableNumber_l; String:C10(v_29_007_aL{$loop_L}); "HERE")
		If ($localElmID_txt="")
			$localElmID_L:=v_29_007_aL{$loop_L}
		Else 
			$localElmID_L:=Num:C11($localElmID_txt)
		End if 
		If (SQL_INSPDownloadRecords(->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElementsSafety:29]ElmSafetyID:7; "ElmtRatingLoads"; v_29_007_aL{$loop_L}; $localElmID_L))
		Else 
			$0:=False:C215
			$loop_L:=Size of array:C274(v_29_007_aL)+1
		End if 
	End for 
	
End if 

Case of 
	: (SQLError_b)
		$0:=False:C215
	: (4DError_b)
		$0:=False:C215
	: ($0=False:C215)
	Else 
		$0:=True:C214
End case 
//End INSP_DWNLD_ElmtRR_ratings