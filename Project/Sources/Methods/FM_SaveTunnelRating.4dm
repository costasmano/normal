//%attributes = {"invisible":true}
//Method: FM_SaveTunnelRating
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/18, 16:53:02
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
ON ERR CALL:C155("SQL_ERROR")
If (Is new record:C668([NTI_TunnelRatings:189]))
	LogNewRecord(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelRatings:189]NTI_i1_s:2; ->[NTI_TunnelRatings:189]RatingID_L:11; 1; "RatingID_L")
	[NTI_TunnelRatings:189]CreatedBy_s:9:=Current user:C182
	[NTI_TunnelRatings:189]ISO_CreatedDate_s:7:=ISODateTime(Current date:C33; Current time:C178)
Else 
	If (Modified record:C314([NTI_TunnelRatings:189]))
		[NTI_TunnelRatings:189]ModifiedBy_s:10:=Current user:C182
		[NTI_TunnelRatings:189]ISO_ModifedDate_s:8:=ISODateTime(Current date:C33; Current time:C178)
	End if 
End if 
ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "RatingID_L")
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "NTI_TunnelRatings_UUID_s")
If (Modified record:C314([NTI_TunnelRatings:189])) | (Is new record:C668([NTI_TunnelRatings:189]))
	If (ACT_PushGroupChanges(Table:C252(->[NTI_TunnelRatings:189]); 3; ->$FieldsToSkip_atxt; Not:C34(Is new record:C668([NTI_TunnelRatings:189]))))
		[NTI_TunnelRatings:189]RatingID_L:11:=[NTI_TunnelRatings:189]RatingID_L:11  //reset to force modified record flag for this table
		FlushGrpChgs(3; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelRatings:189]NTI_i1_s:2; ->[NTI_TunnelRatings:189]RatingID_L:11; 1)
		
		SAVE RECORD:C53([NTI_TunnelRatings:189])
		
	End if 
End if 
//ACCEPT
ON ERR CALL:C155("")
//End FM_SaveTunnelRating