//%attributes = {"invisible":true}
If (False:C215)
	//G_Accesibility2SIA 
	//Transfer Accesibility Items from inspection to NBI record.
	//Log changes.
	//Should only be called from Methods that transfer data from inspection to SIA
	// Modified by: Costas Manousakis-(Designer)-(5/3/13 09:36:29)
	Mods_2013_05
	//  `added [Inspections]ConfinedSp
End if 

If ([Bridge MHD NBIS:1]AccessOther:180#[Inspections:27]AccessOther:96)
	[Bridge MHD NBIS:1]AccessOther:180:=[Inspections:27]AccessOther:96
	PushChange(1; ->[Bridge MHD NBIS:1]AccessOther:180)
End if 
If ([Bridge MHD NBIS:1]LiftBucket:30#[Inspections:27]LiftBucket:86)
	[Bridge MHD NBIS:1]LiftBucket:30:=[Inspections:27]LiftBucket:86
	PushChange(1; ->[Bridge MHD NBIS:1]LiftBucket:30)
End if 
If ([Bridge MHD NBIS:1]Boat:32#[Inspections:27]Boat:88)
	[Bridge MHD NBIS:1]Boat:32:=[Inspections:27]Boat:88
	PushChange(1; ->[Bridge MHD NBIS:1]Boat:32)
End if 
If ([Bridge MHD NBIS:1]Wader:33#[Inspections:27]Wader:89)
	[Bridge MHD NBIS:1]Wader:33:=[Inspections:27]Wader:89
	PushChange(1; ->[Bridge MHD NBIS:1]Wader:33)
End if 
If ([Bridge MHD NBIS:1]Ladder:31#[Inspections:27]Ladder:87)
	[Bridge MHD NBIS:1]Ladder:31:=[Inspections:27]Ladder:87
	PushChange(1; ->[Bridge MHD NBIS:1]Ladder:31)
End if 
If ([Bridge MHD NBIS:1]Inspector50:34#[Inspections:27]Inspector50:90)
	[Bridge MHD NBIS:1]Inspector50:34:=[Inspections:27]Inspector50:90
	PushChange(1; ->[Bridge MHD NBIS:1]Inspector50:34)
End if 
If ([Bridge MHD NBIS:1]Rigging:35#[Inspections:27]Rigging:91)
	[Bridge MHD NBIS:1]Rigging:35:=[Inspections:27]Rigging:91
	PushChange(1; ->[Bridge MHD NBIS:1]Rigging:35)
End if 
If ([Bridge MHD NBIS:1]Staging:36#[Inspections:27]Staging:92)
	[Bridge MHD NBIS:1]Staging:36:=[Inspections:27]Staging:92
	PushChange(1; ->[Bridge MHD NBIS:1]Staging:36)
End if 
If ([Bridge MHD NBIS:1]Traffic Control:37#[Inspections:27]Traffic Control:93)
	[Bridge MHD NBIS:1]Traffic Control:37:=[Inspections:27]Traffic Control:93
	PushChange(1; ->[Bridge MHD NBIS:1]Traffic Control:37)
End if 
If ([Bridge MHD NBIS:1]RR Flagman:38#[Inspections:27]RR Flagman:94)
	[Bridge MHD NBIS:1]RR Flagman:38:=[Inspections:27]RR Flagman:94
	PushChange(1; ->[Bridge MHD NBIS:1]RR Flagman:38)
End if 
If ([Bridge MHD NBIS:1]Police:39#[Inspections:27]Police:95)
	[Bridge MHD NBIS:1]Police:39:=[Inspections:27]Police:95
	PushChange(1; ->[Bridge MHD NBIS:1]Police:39)
End if 
If ([Bridge MHD NBIS:1]OtherAccBool:181#[Inspections:27]OtherAccBool:97)
	[Bridge MHD NBIS:1]OtherAccBool:181:=[Inspections:27]OtherAccBool:97
	PushChange(1; ->[Bridge MHD NBIS:1]OtherAccBool:181)
End if 
If ([Bridge MHD NBIS:1]ConfinedSp:217#[Inspections:27]ConfinedSp:182)
	[Bridge MHD NBIS:1]ConfinedSp:217:=[Inspections:27]ConfinedSp:182
	PushChange(1; ->[Bridge MHD NBIS:1]ConfinedSp:217)
End if 