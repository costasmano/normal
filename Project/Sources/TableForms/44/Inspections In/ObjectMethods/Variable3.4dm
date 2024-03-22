If (False:C215)
	//SC aTeamLeader on layout [BMS Inspections];"Inspections In".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//Pop up menu for team leader.
	
	//TRACE
	
End if 
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 
REDRAW:C174(aTeamLeader)
If ((Form event code:C388=On Clicked:K2:4) & (aTeamLeader>0))
	vTmLeader:=aTeamLeader{aTeamLeader}
End if 
POPUPMENUC(->aTeamLeader; ->aTeamLdrID; ->[BMS Inspections:44]TeamLeader:6)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([BMS Inspections:44]TeamLeader:6)#[BMS Inspections:44]TeamLeader:6)
		PushChange(1; ->[BMS Inspections:44]TeamLeader:6)
	End if 
End if 