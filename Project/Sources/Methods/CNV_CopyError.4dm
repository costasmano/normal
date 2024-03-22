//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/28/16, 13:05:41
//----------------------------------------------------
//Method: CNV_CopyError
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/28/16 13:06:05)
	
End if 
ARRAY LONGINT:C221($SQLErrorNumbers_al; 0)
ARRAY TEXT:C222($SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222($SQL_InternalDescriptions_atxt; 0)

C_LONGINT:C283($loop_l)
GET LAST ERROR STACK:C1015($SQLErrorNumbers_al; $SQL_InternalCodes_atxt; $SQL_InternalDescriptions_atxt)
If ($SQLErrorNumbers_al{1}=600)
	TryAgain_L:=1
Else 
	TRACE:C157
	TryAgain_L:=3
	For ($loop_l; 1; Size of array:C274($SQL_InternalDescriptions_atxt))
		
		SEND PACKET:C103(CNV_Doc_tm; $SQL_InternalDescriptions_atxt{$loop_l}+Char:C90(Tab:K15:37))
		
	End for 
End if 
//End CNV_CopyError

