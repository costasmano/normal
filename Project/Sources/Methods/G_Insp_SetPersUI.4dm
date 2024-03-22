//%attributes = {"invisible":true}
//G_Insp_SetPersUI 
//general method to set the arrays and variables
//for popup/popdown buttons for Personnel and inspection
//agency in inspection input forms.

If (False:C215)
	Mods_2005_CM06
	Mods_2005_CM08
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 11:32:44)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 15:14:20)
	Mods_2006_CMy2
	// Modified by: costasmanousakis-(Designer)-(2/27/09 10:23:30)
	Mods_2009_CM_5404
	//When there is no team leader - will make the current person the team leader
	// Modified by: Costas Manousakis-(Designer)-(2/20/14 10:51:28)
	Mods_2014_02_bug
	//  `added call to set the tunnel and proj mgr for Tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(4/9/14 11:56:05)
	Mods_2014_04_bug
	//  `added code to set the tunnel insp engr using pers groups
	//  `removed check for app version (◊LNK_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(12/14/15 17:47:11)
	Mods_2015_12_bug
	//  `added Case for MPA inspection resp. if Insp resp does not fall in a case then leave DistNo blank.
	//  `This will pick the blank name from the personnel table
	// Modified by: Costas Manousakis-(Designer)-(1/16/17 10:22:27)
	Mods_2017_01
	//  `make current user TL only if they are TL or DBIE
	// Modified by: Costas Manousakis-(Designer)-(3/18/19 14:27:46)
	Mods_2019_03_bug
	//  `use NTI_GroupSuffix for the personnel group for DBIE in tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(6/26/19 17:23:42)
	Mods_2019_06_bug
	//  `change method of assigning the DBIE field CallReference #639
End if 

C_LONGINT:C283($i; $j; $k)  // **replaced _ o _C_INTEGER()
C_TEXT:C284($vstestUser; $vsUserName; $vsMyEmployer; $vsDivNo)  // **Replaced old C_STRING length 80
C_LONGINT:C283($viMyPersID; $DBIE_L)  // **replaced _ o _C_INTEGER()
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
If (Records in selection:C76([Personnel:42])#1)
	$vsUserName:=Current user:C182
	$vstestUser:=Replace string:C233($vsUserName; " "; "@")
	$i:=Find in array:C230(aPeople; $vstestUser)
	If ($i>0)
		$j:=aPeople_ID{$i}
	Else 
		$j:=-1
	End if 
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$j)
End if 

If (Records in selection:C76([Personnel:42])=1)
	LOAD RECORD:C52([Personnel:42])
	$vsMyEmployer:=[Personnel:42]Employer:9
	$viMyPersID:=[Personnel:42]Person ID:1
	
Else 
	$vsMyEmployer:=""
	$viMyPersID:=0
	
End if 

INSP_CheckLinks

If (Is record loaded:C669([BMS Inspections:44]))
	QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
End if 
QUERY:C277([Field Trip:43]; [Field Trip:43]InspID:1=[Inspections:27]InspID:2)
$vsDivNo:=""
C_TEXT:C284($Grpsuffix_txt)

Case of 
	: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
		$vsDivNo:="044"+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)
	: ([Bridge MHD NBIS:1]InspResp:173="MDC@")
		$vsDivNo:="DCR"
	: ([Bridge MHD NBIS:1]InspResp:173="MBTA@")
		$vsDivNo:="MBTA"
	: ([Bridge MHD NBIS:1]InspResp:173="MTA@")
		$vsDivNo:="MTA"
	: ([Bridge MHD NBIS:1]InspResp:173="MPA@")
		$vsDivNo:="MPA"
	Else 
		//$vsDivNo:="044"+String(Num([Bridge MHD NBIS]Item2))
End case 

Case of 
	: ([Inspections:27]Insp Type:6#"PON")
		
		If (([Inspections:27]DBrInspEngr:3=0) & Not:C34(vbInspectionLocked))
			//This is a new record.    
			If ([Inspections:27]Insp Type:6="T@")
				
				$Grpsuffix_txt:=NTI_GroupSuffix([Bridge MHD NBIS:1]InspResp:173; [Bridge MHD NBIS:1]Item2:60)
				$DBIE_L:=GRP_GetGroupRepID("TunnelInspEng"+$Grpsuffix_txt)
				
				If ($DBIE_L>0)
					[Inspections:27]DBrInspEngr:3:=$DBIE_L
					LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
				End if 
				POPUPMENUC(->Insp_DTIE_atxt; ->Insp_DTIE_aL; ->[Inspections:27]DBrInspEngr:3)
				
			Else 
				
				$DBIE_L:=INSP_GetDefaultDBIE([Bridge MHD NBIS:1]InspResp:173)
				
				If ($DBIE_L>0)
					[Inspections:27]DBrInspEngr:3:=$DBIE_L
					LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
					POPUPMENUC(->aBIE; ->aBIE_ID; ->[Inspections:27]DBrInspEngr:3)
					If (Is record loaded:C669([BMS Inspections:44]))
						[BMS Inspections:44]DBrInspEngr:5:=$DBIE_L
						LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
						SAVE RECORD:C53([BMS Inspections:44])
					End if 
					
				End if 
				
			End if 
			
		End if 
		
		$k:=Find in array:C230(aPeople_ID; [Inspections:27]DBrInspEngr:3)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			aPeople_ID:=0
			If ([Inspections:27]DBrInspEngr:3>0)
				vBIE:="UnKnown Insp. Engineer"
			Else 
				vBIE:="Select Insp. Engineer"
			End if 
			
		End if 
		
		//Set up the Agency display variable.
		If (([Inspections:27]Agency:156="") & Not:C34(vbInspectionLocked))
			Case of 
				: ($vsMyEmployer#"")
					[Inspections:27]Agency:156:=$vsMyEmployer
				: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
					[Inspections:27]Agency:156:="Mass. Highway Dept."
				: ([Bridge MHD NBIS:1]InspResp:173="MDC@")
					[Inspections:27]Agency:156:="DCR"
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA@")
					[Inspections:27]Agency:156:="MBTA"
				: ([Bridge MHD NBIS:1]InspResp:173="MTA@")
					[Inspections:27]Agency:156:="MTA"
				Else 
					[Inspections:27]Agency:156:=""
			End case 
			PushChange(1; ->[Inspections:27]Agency:156)
			POPUPMENUC(->aAgency; ->aAgency; ->[Inspections:27]Agency:156)
			If (Is record loaded:C669([BMS Inspections:44]))
				[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
				PushChange(3; ->[BMS Inspections:44]Agency:13)
				SAVE RECORD:C53([BMS Inspections:44])
			End if 
		End if 
		If (([Inspections:27]Agency:156="MDC") & Not:C34(vbInspectionLocked))
			Case of 
				: ($vsMyEmployer#"")
					[Inspections:27]Agency:156:=$vsMyEmployer
				: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
					[Inspections:27]Agency:156:="Mass. Highway Dept."
				: ([Bridge MHD NBIS:1]InspResp:173="MDC@")
					[Inspections:27]Agency:156:="DCR"
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA@")
					[Inspections:27]Agency:156:="MBTA"
				: ([Bridge MHD NBIS:1]InspResp:173="MTA@")
					[Inspections:27]Agency:156:="MTA"
				Else 
					[Inspections:27]Agency:156:=""
			End case 
			PushChange(1; ->[Inspections:27]Agency:156)
			POPUPMENUC(->aAgency; ->aAgency; ->[Inspections:27]Agency:156)
			If (Is record loaded:C669([BMS Inspections:44]))
				[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
				PushChange(3; ->[BMS Inspections:44]Agency:13)
				SAVE RECORD:C53([BMS Inspections:44])
			End if 
			
		End if 
		
		//Set up the team leader and team member arrays.
		vAgency:=[Inspections:27]Agency:156
		InitPers([Inspections:27]Agency:156)
		
		If (([Inspections:27]TeamLeader:4=0) & Not:C34(vbInspectionLocked))
			If ($viMyPersID>0)
				C_LONGINT:C283($JobCode_L)
				Begin SQL
					select [Personnel].[Job Code] from [Personnel] where [Personnel].[Person ID] = :[<>CurrentUser_PID] into :$JobCode_L ;
				End SQL
				If ($JobCode_L=2) | ($JobCode_L=1)  //TL or DBIE
					
					[Inspections:27]TeamLeader:4:=$viMyPersID
					LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
					[Inspections:27]DateModified:137:=Current date:C33
					PushChange(1; ->[Inspections:27]DateModified:137)
					If ([BMS Inspections:44]Inspection ID:1>0)
						[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
						[BMS Inspections:44]DateModified:10:=[Inspections:27]DateModified:137
						LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
						PushChange(3; ->[BMS Inspections:44]DateModified:10)
						SAVE RECORD:C53([BMS Inspections:44])
					End if 
					
				End if 
				
			End if 
		End if 
		
		//InitPers recreates the Team Leader array; reset it.  
		aTeamLeader:=Find in array:C230(aTeamLdrID; [Inspections:27]TeamLeader:4)
		If (aTeamLeader<=0)  //Just in case nothing was found in array
			aTeamLeader:=0
		End if 
		
		$k:=Find in array:C230(aPeople_ID; [Inspections:27]TeamLeader:4)
		If ($k>0)
			vTmLeader:=aPeople{$k}
		Else 
			If ([Inspections:27]TeamLeader:4>0)
				vTmLeader:="UnKnown Team Leader"
			Else 
				vTmLeader:="Select Team Leader"
			End if 
			
		End if 
		
		INSP_BuildTmMbrArea
		
		//Make sure [BMS Inspection] has same Personnel as [Inspection] rec
		If (([Combined Inspections:90]BMSInspID:3>0) & Not:C34(vbInspectionLocked))
			//[Bms Inspection] record should be loaded already... but..
			
			If ([BMS Inspections:44]Agency:13#[Inspections:27]Agency:156)
				[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
				PushChange(3; ->[BMS Inspections:44]Agency:13)
				SAVE RECORD:C53([BMS Inspections:44])
			End if 
			If ([BMS Inspections:44]DBrInspEngr:5#[Inspections:27]DBrInspEngr:3)
				[BMS Inspections:44]DBrInspEngr:5:=[Inspections:27]DBrInspEngr:3
				LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([BMS Inspections:44])
			End if 
			If ([BMS Inspections:44]TeamLeader:6#[Inspections:27]TeamLeader:4)
				[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
				LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([BMS Inspections:44])
			End if 
			ARRAY INTEGER:C220(aBMSInspTeamID; 0)
			ARRAY INTEGER:C220(aNBIInspTeamID; 0)
			SELECTION TO ARRAY:C260([BMS Field Trip:56]Person ID:2; aBMSInspTeamID)
			SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; aNBIInspTeamID)
			CREATE EMPTY SET:C140([BMS Field Trip:56]; "FieldTripstobeDel")
			C_LONGINT:C283($i; $k)  // **replaced _ o _C_INTEGER()
			For ($i; 1; Size of array:C274(aBMSInspTeamID))
				$k:=Find in array:C230(aNBIInspTeamID; aBMSInspTeamID{$i})
				If ($k<=0)
					GOTO SELECTED RECORD:C245([BMS Field Trip:56]; $i)
					LOAD RECORD:C52([BMS Field Trip:56])
					LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ->[Personnel:42]Person ID:1)
					ADD TO SET:C119([BMS Field Trip:56]; "FieldTripstobeDel")
				End if 
			End for 
			If (Records in set:C195("FieldTripstobeDel")>0)
				USE SET:C118("FieldTripstobeDel")
				DELETE SELECTION:C66([BMS Field Trip:56])
			End if 
			CLEAR SET:C117("FieldTripstobeDel")
			For ($i; 1; Size of array:C274(aNBIInspTeamID))
				$k:=Find in array:C230(aBMSInspTeamID; aNBIInspTeamID{$i})
				If ($k<=0)
					CREATE RECORD:C68([BMS Field Trip:56])
					[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
					[BMS Field Trip:56]Person ID:2:=aNBIInspTeamID{$i}
					LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
					SAVE RECORD:C53([BMS Field Trip:56])
				End if 
			End for 
			
			//re-load Field trip records      
			QUERY:C277([BMS Field Trip:56]; [BMS Field Trip:56]Inspection ID:1=[BMS Inspections:44]Inspection ID:1)
		End if 
		
		If ([Inspections:27]Insp Type:6="T@")  //Tunnel Inspections
			INSP_ConsProjMgr_OM
			INSP_DIE_OM
		End if 
		
	: ([Inspections:27]Insp Type:6="PON")
		
		If (([BMS Inspections:44]DBrInspEngr:5=0) & Not:C34(vbInspectionLocked))
			
			//This is a new record.    
			$DBIE_L:=INSP_GetDefaultDBIE([Bridge MHD NBIS:1]InspResp:173)
			
			If ($DBIE_L>0)
				[BMS Inspections:44]DBrInspEngr:5:=$DBIE_L
				LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
				SAVE RECORD:C53([BMS Inspections:44])
				POPUPMENUC(->aBIE; ->aBIE_ID; ->[BMS Inspections:44]DBrInspEngr:5)
				If (Is record loaded:C669([Inspections:27]))
					[Inspections:27]DBrInspEngr:3:=$DBIE_L
					LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
				End if 
			End if 
		End if 
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:="Select Insp. Engineer"
		End if 
		
		//Set up the Agency display variable.
		If (([BMS Inspections:44]Agency:13="") & Not:C34(vbInspectionLocked))
			Case of 
				: ($vsMyEmployer#"")
					[BMS Inspections:44]Agency:13:=$vsMyEmployer
				: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
					[BMS Inspections:44]Agency:13:="Mass. Highway Dept."
				: ([Bridge MHD NBIS:1]InspResp:173="MDC@")
					[BMS Inspections:44]Agency:13:="DCR"
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA@")
					[BMS Inspections:44]Agency:13:="MBTA"
				: ([Bridge MHD NBIS:1]InspResp:173="MTA@")
					[BMS Inspections:44]Agency:13:="MTA"
				Else 
					[BMS Inspections:44]Agency:13:=""
			End case 
			PushChange(3; ->[BMS Inspections:44]Agency:13)
			SAVE RECORD:C53([BMS Inspections:44])
			POPUPMENUC(->aAgency; ->aAgency; ->[BMS Inspections:44]Agency:13)
			If (Is record loaded:C669([Inspections:27]))
				[Inspections:27]Agency:156:=[BMS Inspections:44]Agency:13
				PushChange(1; ->[Inspections:27]Agency:156)
			End if 
			
		End if 
		If (([BMS Inspections:44]Agency:13="MDC") & Not:C34(vbInspectionLocked))
			Case of 
				: ($vsMyEmployer#"")
					[BMS Inspections:44]Agency:13:=$vsMyEmployer
				: ([Bridge MHD NBIS:1]InspResp:173="DIST@")
					[BMS Inspections:44]Agency:13:="Mass. Highway Dept."
				: ([Bridge MHD NBIS:1]InspResp:173="MDC@")
					[BMS Inspections:44]Agency:13:="DCR"
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA@")
					[BMS Inspections:44]Agency:13:="MBTA"
				: ([Bridge MHD NBIS:1]InspResp:173="MTA@")
					[BMS Inspections:44]Agency:13:="MTA"
				Else 
					[BMS Inspections:44]Agency:13:=""
			End case 
			PushChange(3; ->[BMS Inspections:44]Agency:13)
			SAVE RECORD:C53([BMS Inspections:44])
			POPUPMENUC(->aAgency; ->aAgency; ->[BMS Inspections:44]Agency:13)
			If (Is record loaded:C669([Inspections:27]))
				[Inspections:27]Agency:156:=[BMS Inspections:44]Agency:13
				PushChange(1; ->[Inspections:27]Agency:156)
			End if 
			
		End if 
		
		//Set up the team leader and team member arrays.
		vAgency:=[BMS Inspections:44]Agency:13
		InitPers([BMS Inspections:44]Agency:13)
		
		//InitPers recreates the Team Leader array; reset it.  
		aTeamLeader:=Find in array:C230(aTeamLdrID; [BMS Inspections:44]TeamLeader:6)
		If (aTeamLeader<=0)  //Just in case nothing was found in array
			aTeamLeader:=0
		End if 
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]TeamLeader:6)
		If ($k>0)
			vTmLeader:=aPeople{$k}
		Else 
			vTmLeader:="Select Team Leader"
		End if 
		
		INSP_BuildTmMbrArea(->[BMS Field Trip:56]Person ID:2)
		
End case 