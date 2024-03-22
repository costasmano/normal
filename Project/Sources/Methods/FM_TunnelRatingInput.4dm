//%attributes = {"invisible":true}
//Method: FM_TunnelRatingInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/18, 16:02:25
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	
	C_LONGINT:C283(FM_TunnelRatingInput; $1)
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668([NTI_TunnelRatings:189]))
			Inc_Sequence("RatingID_L"; ->[NTI_TunnelRatings:189]RatingID_L:11)
			OBJECT SET VISIBLE:C603(*; "bFirst"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bPrevious"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bNext"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bLast"; False:C215)
			[NTI_TunnelRatings:189]NTI_i1_s:2:=[NTI_TunnelInfo:181]NTI_i1_s:6
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; 0)
			OBJECT SET VISIBLE:C603(*; "bDelete"; False:C215)
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([NTI_TunnelRatings:189]))
			OBJECT SET ENABLED:C1123(*; "bValidate"; Not:C34(Read only state:C362(Current form table:C627->)))
			OBJECT SET ENABLED:C1123(*; "bDelete"; Not:C34(Read only state:C362(Current form table:C627->)))
		End if 
		
End case 
//End FM_TunnelRatingInput