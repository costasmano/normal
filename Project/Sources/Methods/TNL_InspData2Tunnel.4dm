//%attributes = {"invisible":true}
//Method: TNL_InspData2Tunnel
//Description
//  ` Handle the copy of data from tunnel inspection report to SIA;
//  `Two steps 
//  `  `a) from [Inspections] to SIA ;
//  `  `b) [tunnelinspection] to [tunnelinfo]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/14/13, 13:19:53
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
	// Modified by: Costas Manousakis-(Designer)-(09/26/13 11:20:11)
	Mods_2013_09
	//  `added Check of special member frequencies method INSP_CheckTunnelSpcFreq
	// Modified by: Costas Manousakis-(Designer)-(10/2/13 11:20:11)
	Mods_2013_10
	//  `Changed text message in alerts
	
End if 
//
C_TEXT:C284($msg)
C_BOOLEAN:C305($one_b; $many_b)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)  //save the state of auto relations
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)  // save them to false
QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
$msg:="Approving a "+[Inspection Type:31]Description:2+" inspection - Step 1 : Saving data to Bridge SI & A for BIN : "
$msg:=$msg+[Bridge MHD NBIS:1]BIN:3+" BDEPT : "+[Bridge MHD NBIS:1]BDEPT:1
ALERT:C41($msg)
G_RoutinetoBMS  //record saved in this method

If (Not:C34(Is record loaded:C669([Bridge MHD NBIS:1])))
	LOAD RECORD:C52([Bridge MHD NBIS:1])
End if 

$msg:="Approving a "+[Inspection Type:31]Description:2+" inspection - Step 2 : Saving data to Tunnel SI & A for BIN : "
$msg:=$msg+[Bridge MHD NBIS:1]BIN:3+" BDEPT : "+[Bridge MHD NBIS:1]BDEPT:1
ALERT:C41($msg)

//Need the tunnelinfo record and make sure we have the [tunnelinsection] record

If ([TunnelInspection:152]InspID:1#[Inspections:27]InspID:2)
	QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
End if 

C_BOOLEAN:C305($loadRec_b)
QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Inspections:27]BIN:1)

If (Records in selection:C76([TunnelInfo:151])=1)
	If (ut_LoadRecordInteractive(->[TunnelInfo:151]))
		TNL_SIA_Insp("INSP2SIA")
		C_BOOLEAN:C305($SaveRec_b)
		InitChangeStack(1)
		
		INSP_CheckTunnelSpcFreq
		//check changes
		PushAllChanges(1; ->[TunnelInfo:151])
		//verify changes
		$SaveRec_b:=INSP_VerifySIAChanges(1)
		If ($SaveRec_b)
			[TunnelInfo:151]ModifiedBy_s:20:=Current user:C182
			[TunnelInfo:151]ModifiedTimeStamp_s:21:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			PushChange(1; ->[TunnelInfo:151]ModifiedBy_s:20)
			PushChange(1; ->[TunnelInfo:151]ModifiedTimeStamp_s:21)
			FlushGrpChgs(1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; 0)
			SAVE RECORD:C53([TunnelInfo:151])
		End if 
		READ ONLY:C145([TunnelInfo:151])  // set this back to RO
		UNLOAD RECORD:C212([TunnelInfo:151])
		
	Else 
		ALERT:C41("Could not load the corresponding Tunnel Information record!  Please enter data manually!")
	End if 
	
Else 
	ALERT:C41("Corresponding Tunnel Information record NOT Found! The record must be creat")
End if 
SET AUTOMATIC RELATIONS:C310($one_b; $many_b)  //reset state of auto relations

//End TNL_InspData2Tunnel