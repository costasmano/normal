//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/18/09, 12:20:48
	// ----------------------------------------------------
	// Method: SIA_Item113_OM
	// Description
	// Object method for the Item113 field in the SIA Input form
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
PushChange(1; ->[Bridge MHD NBIS:1]Item113:151)
C_TEXT:C284($Item113ScourCritFilter_txt; $Msg_txt)

$Item113ScourCritFilter_txt:=ut_GetSysParameter("@Item113@"; ""; "VALUE")
If (Position:C15(","+[Bridge MHD NBIS:1]Item113:151+","; $Item113ScourCritFilter_txt)>0)
	//scour critical
Else 
	//not scour critical anymore - remove it from the ScourPriority Ranking table
	QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	If (Records in selection:C76([ScourPriorityRank:108])=1)
		$Msg_txt:="Do you also wish to clear the Scour Category ["+[ScourPriorityRank:108]Category:5
		$Msg_txt:=$Msg_txt+"]  and Rank ["+String:C10([ScourPriorityRank:108]Rank:6)+"] of this Bridge Record?"
		$Msg_txt:=$Msg_txt+"  Canceling out of the SIA input form will not undo this! Please note that cleari"+"ng the ranking of this Bridge"
		$Msg_txt:=$Msg_txt+" will not adjust the rankings of the remaining Bridges. That would have to be "
		$Msg_txt:=$Msg_txt+"done by executing the Scour Priority Procedure."
		G_MyConfirm($Msg_txt; "Clear Category and Rank"; "Leave As Is")  //Leave As Is
		If (OK=1)
			If (ut_LoadRecordInteractive(->[ScourPriorityRank:108]))
				DELETE RECORD:C58([ScourPriorityRank:108])
				$Msg_txt:="The Scour Rank and Category for this Bridge have been cleared!"
				$Msg_txt:=$Msg_txt+" The Rankings for the Bridges still in Scour Critical Category"
				$Msg_txt:=$Msg_txt+" have to be adjusted by executing the Scour Priority Procedure."
				SIA_ScourRank_OM(On Load:K2:1)
			Else 
				$Msg_txt:="Scour Rank and Category for this Bridge have not been cleared!"
				$Msg_txt:=$Msg_txt+" They will have to be cleared by executing the Scour Priority Procedure."
			End if 
			ALERT:C41($Msg_txt)
			
		End if 
		
	End if 
	
End if 