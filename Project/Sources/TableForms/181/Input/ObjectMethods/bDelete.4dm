
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 16:36:27
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:36:28)
	
End if 
NTI_MovingRecords_B:=False:C215
C_LONGINT:C283($Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]NTI_i1_s:33=[NTI_TunnelInfo:181]NTI_i1_s:6)
C_TEXT:C284($Confirm_txt)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($Count_L>0)
	If ($Count_L=1)
		$Confirm_txt:="There is 1 BIN related to Tunnel number "+[NTI_TunnelInfo:181]NTI_i1_s:6+Char:C90(Carriage return:K15:38)+"You have will to remove the link before delete can occur"
		
	Else 
		$Confirm_txt:="There are "+String:C10($Count_L)+" BINs related to Tunnel number "+[NTI_TunnelInfo:181]NTI_i1_s:6+Char:C90(Carriage return:K15:38)+"You have will to remove the link before delete can occur"
		
	End if 
	ALERT:C41($Confirm_txt)
	
	
Else 
	
	
	CONFIRM:C162("Are you sure you wish to delete this NTI_TunnelInfo record?"; "DELETE"; "Skip")
	If (OK=1)
		
		
		C_LONGINT:C283($passwordErr_L)
		$Confirm_txt:="! ! ! WARNING : To Delete the NTI_TunnelInfo record, your password is required ! ! !"+<>sCR+"Enter your password to Delete or Cancel to abort the deletion!!"
		$Confirm_txt:=Uppercase:C13($Confirm_txt)
		$passwordErr_L:=OP_GetPassword($Confirm_txt)
		
		If ($passwordErr_L=0)
			
			
			LogDeletion(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelInfo:181]NTI_i1_s:6; 0)
			$Confirm_txt:=[NTI_TunnelInfo:181]NTI_i1_s:6
			C_LONGINT:C283($Loc_L)
			$Loc_L:=Find in array:C230(NTI_SelectedRN_aL; Record number:C243([NTI_TunnelInfo:181]))
			
			DELETE RECORD:C58([NTI_TunnelInfo:181])
			
			VALIDATE TRANSACTION:C240
			If ($Loc_L>0)
				DELETE FROM ARRAY:C228(NTI_SelectedRN_aL; $Loc_L; 1)
			End if 
			CREATE SELECTION FROM ARRAY:C640([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
			
			ACCEPT:C269
		Else 
			ALERT:C41("Record not deleted!")
		End if 
		
		
	End if 
End if 
//End Object Method: [LSS_Inventory].Input.bDelete

