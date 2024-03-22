//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/19/15, 12:02:48
//----------------------------------------------------
//Method: NTI_AssignBINtoTunnelTIN
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/19/15 12:02:52)
	
End if 
If (Read only state:C362([NTI_TunnelInfo:181]))
	ALERT:C41("You can not update data as you are in read only mode")
Else 
	C_LONGINT:C283($Row_L)
	$Row_L:=Find in array:C230(AvailableBins_LB; True:C214)
	If ($Row_L>0)
		C_BOOLEAN:C305($Assign_B)
		$Assign_B:=True:C214
		If (NTI_A_Item2_atxt{$Row_L}#[NTI_TunnelInfo:181]NTI_i6_s:11)
			CONFIRM:C162("Are you sure that you wish to add BIN "+NTI_A_Bins_atxt{$Row_L}+" District "+NTI_A_Item2_atxt{$Row_L}+" to Tunnel "+[NTI_TunnelInfo:181]NTI_i1_s:6+" in District "+[NTI_TunnelInfo:181]NTI_i6_s:11+"?"; "Yes"; "No")
			$Assign_B:=(OK=1)
			
		End if 
		If ($Assign_B)
			QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=NTI_A_Bins_atxt{$Row_L})
			If (ut_LoadRecordInteractive(->[TunnelInfo:151]))
				If (Records in selection:C76([TunnelInfo:151])=0)
					CREATE RECORD:C68([TunnelInfo:151])
					[TunnelInfo:151]BIN:1:=NTI_A_Bins_atxt{$Row_L}
					[TunnelInfo:151]CreatedBy_s:18:=<>CurrentUser_Name
					[TunnelInfo:151]CreatedTimeStamp_s:19:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
					PushChange(2; ->[TunnelInfo:151]CreatedBy_s:18)
					PushChange(2; ->[TunnelInfo:151]CreatedTimeStamp_s:19)
					LogNewRecord(->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; 0; "")
				End if 
				$Assign_B:=True:C214
				If ([TunnelInfo:151]NTI_i1_s:33#"") & ([TunnelInfo:151]NTI_i1_s:33#[NTI_TunnelInfo:181]NTI_i1_s:6)
					CONFIRM:C162("Are you sure you wish to re-assign BIN "+NTI_A_Bins_atxt{$Row_L}+" from "+[TunnelInfo:151]NTI_i1_s:33+" to "+[NTI_TunnelInfo:181]NTI_i1_s:6; "Yes"; "No")
					$Assign_B:=(OK=1)
				End if 
				If ($Assign_B)
					APPEND TO ARRAY:C911(NTI_S_Bins_atxt; NTI_A_Bins_atxt{$Row_L})
					APPEND TO ARRAY:C911(NTI_S_Item2_atxt; NTI_A_Item2_atxt{$Row_L})
					APPEND TO ARRAY:C911(NTI_S_Item8_atxt; NTI_A_Item8_atxt{$Row_L})
					APPEND TO ARRAY:C911(NTI_S_Item7_atxt; NTI_A_Item7_atxt{$Row_L})
					APPEND TO ARRAY:C911(NTI_S_Item6a_atxt; NTI_A_Item6a_atxt{$Row_L})
					LISTBOX SORT COLUMNS:C916(SelectedBins_LB; 2; >)  // sort by BIN
					
					[TunnelInfo:151]NTI_i1_s:33:=[NTI_TunnelInfo:181]NTI_i1_s:6
					[TunnelInfo:151]ModifiedBy_s:20:=<>CurrentUser_Name
					[TunnelInfo:151]ModifiedTimeStamp_s:21:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
					PushChange(2; ->[TunnelInfo:151]NTI_i1_s:33)
					PushChange(2; ->[TunnelInfo:151]ModifiedBy_s:20)
					PushChange(2; ->[TunnelInfo:151]ModifiedTimeStamp_s:21)
					FlushGrpChgs(2; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; 0)
					SAVE RECORD:C53([TunnelInfo:151])
					
					
					DELETE FROM ARRAY:C228(NTI_A_Bins_atxt; $Row_L)
					DELETE FROM ARRAY:C228(NTI_A_Item2_atxt; $Row_L)
					DELETE FROM ARRAY:C228(NTI_A_Item8_atxt; $Row_L)
					DELETE FROM ARRAY:C228(NTI_A_Item7_atxt; $Row_L)
					DELETE FROM ARRAY:C228(NTI_A_Item6a_atxt; $Row_L)
					DELETE FROM ARRAY:C228(NTI_FontColor_al; $Row_L)
					REDRAW:C174(AvailableBins_LB)
					REDRAW:C174(SelectedBins_LB)
				End if 
				
			End if 
			$Row_L:=Find in array:C230(AvailableBins_LB; True:C214)
			If ($Row_L>0)
				AvailableBins_LB{$Row_L}:=False:C215
			End if 
			UNLOAD RECORD:C212([TunnelInfo:151])
			READ ONLY:C145([TunnelInfo:151])
		Else 
			AvailableBins_LB{$Row_L}:=False:C215
		End if 
	End if 
End if 
//End NTI_AssignBINtoTunnelTIN

