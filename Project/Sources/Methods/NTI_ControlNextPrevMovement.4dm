//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/17/15, 15:34:59
//----------------------------------------------------
//Method: NTI_ControlNextPrevMovement
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/17/15 15:35:06)
End if 

NTI_MovingRecords_B:=True:C214
If (Modified record:C314([NTI_TunnelInfo:181]))
	FM_SaveTunnelInfo
Else 
	CANCEL TRANSACTION:C241
End if 

USE NAMED SELECTION:C332("NTI_TunnelInfoSet")
GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)

ACCEPT:C269
//End NTI_ControlNextPrevMovement

