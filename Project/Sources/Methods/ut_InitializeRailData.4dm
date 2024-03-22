//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/19/11, 08:52:48
	// ----------------------------------------------------
	// Method: Method: ut_InitializeRailData
	// Description
	//  `Initialize data required for Rail and Transit
	//  `create GEN record in [ElementCat]
	//  `load elements in [elementdict] with ut_loadRRElements
	//  `create records in [RAILBridgeInfo] for bins with Item 8 Cat=@RO
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	//`RR
End if 
QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1="GEN")
If (Records in selection:C76([Element Cat:32])=0)
	CREATE RECORD:C68([Element Cat:32])
	[Element Cat:32]Code:1:="GEN"
	[Element Cat:32]Description:2:="General"
	[Element Cat:32]CulvertElement:3:=False:C215
	[Element Cat:32]RegularElement:4:=False:C215
	SAVE RECORD:C53([Element Cat:32])
	ALERT:C41("Added GEN Element Category")
Else 
	ALERT:C41("GEN Element Category exists")
End if 


QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1="RRR")
If (Records in selection:C76([Inspection Type:31])=0)
	CREATE RECORD:C68([Inspection Type:31])
	[Inspection Type:31]Code:1:="RRR"
	[Inspection Type:31]Description:2:="Routine Rail/Transit"
	SAVE RECORD:C53([Inspection Type:31])
	ALERT:C41("Added RRR [Inspection Type]")
Else 
	ALERT:C41("RRR [Inspection Type] exists")
End if 

ut_loadRRElements

READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
FIRST RECORD:C50([Bridge MHD NBIS:1])
C_LONGINT:C283($TotalRecs_L; $RecsAdded_L)
$TotalRecs_L:=Records in selection:C76([Bridge MHD NBIS:1])
$RecsAdded_L:=0
SHORT_MESSAGE("Creating Rail info records for "+String:C10($TotalRecs_L)+" total ....")
While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
	MESSAGE:C88(String:C10(Selected record number:C246([Bridge MHD NBIS:1]))+"..")
	QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	If (Records in selection:C76([RAILBridgeInfo:37])=0)
		CREATE RECORD:C68([RAILBridgeInfo:37])
		[RAILBridgeInfo:37]BIN:1:=[Bridge MHD NBIS:1]BIN:3
		SAVE RECORD:C53([RAILBridgeInfo:37])
		$RecsAdded_L:=$RecsAdded_L+1
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
End while 
CLOSE WINDOW:C154
ALERT:C41("Added "+String:C10($RecsAdded_L)+" Rail info records for total of "+String:C10($TotalRecs_L)+" Rail Over records!")