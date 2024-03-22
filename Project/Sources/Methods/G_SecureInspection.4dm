//%attributes = {"invisible":true}
If (False:C215)
	//Project Method G_SecureInspection
	//Apply Locks to the current Inspection.
	//Called from inside the particular inspection Form Method on Load
	// Modified by: costasmanousakis-(Designer)-(12/4/07 16:37:22)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(11/18/09 12:20:23)
	Mods_2009_11
	//Added Alerts when entering in readonly mode incomplete/not approved inspections
	// Modified by: costasmanousakis-(Designer)-(12/3/09 14:35:32)
	Mods_2009_12
	//Changed checking for Designer to checking for "Design Access Group"
	// Modified by: costasmanousakis-(Designer)-(4/28/10 10:00:15)
	Mods_2010_04
	//use var ◊CurrentUser_PID to check if current user is in the Team Leader/Member DBIE list
	// Modified by: costasmanousakis-(Designer)-(10/26/11 14:51:22)
	Mods_2011_10
	//  `use ◊CurrentUser_Name
	// Modified by: Costas Manousakis-(Designer)-(1/16/13 13:53:07)
	Mods_2013_01
	//  `Added the field trip tables to the RO list
	// Modified by: Costas Manousakis-(Designer)-(5/24/13 15:58:52)
	Mods_2013_05
	//  `Added [TunnelInspection] to the RO list
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 11:54:11)
	Mods_2013_10
	//  `Added initializing of INSP_PageCountDone_b to false here
	// Modified by: Costas Manousakis-(Designer)-(4/28/14 10:48:35)
	Mods_2014_04
	//  `Added [ElmtRatingLoads]
	// Modified by: Costas Manousakis-(Designer)-(10/9/15 16:30:41)
	Mods_2015_10_bug
	//  `Added  [PON_ELEM_INSP]
End if 

//Process flag to indicate to the forms whether 
//the inspection should be locked or not
C_BOOLEAN:C305(vbInspectionLocked; INSP_PageCountDone_b)
C_TEXT:C284($currUser_txt)
$currUser_txt:=<>CurrentUser_Name
//definitely lock it for most cases        
vbInspectionLocked:=True:C214
INSP_PageCountDone_b:=False:C215
OBJECT SET ENTERABLE:C238([Inspections:27]InspApprCmts:169; False:C215)
OBJECT SET ENTERABLE:C238([Inspections:27]InspRevCmts:170; False:C215)

C_LONGINT:C283($NumInspectors; $k; $j; $l)  //Command Replaced was o_C_INTEGER
$NumInspectors:=Records in selection:C76([Field Trip:43])+2  //Plus two for team leader and DBIE
ARRAY INTEGER:C220($aInspectorIDs; 0)
ARRAY TEXT:C222($aInspUsers; $NumInspectors)  //Command Replaced was o_ARRAY string length was 40
C_TEXT:C284($vsUFname; $vsULname)  // Command Replaced was o_C_STRING length was 40
If ($NumInspectors>0)
	SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; $aInspectorIDs)
	INSERT IN ARRAY:C227($aInspectorIDs; $NumInspectors; 2)
	$aInspectorIDs{($NumInspectors-1)}:=[Inspections:27]DBrInspEngr:3
	$aInspectorIDs{$NumInspectors}:=[Inspections:27]TeamLeader:4
	For ($k; 1; $NumInspectors)
		$j:=Find in array:C230(aPeople_ID; $aInspectorIDs{$k})
		If ($j>0)
			$l:=Position:C15(" "; aPeople{$j})
			$vsUFname:=Substring:C12(aPeople{$j}; 1; $l)
			$vsULname:=Substring:C12(aPeople{$j}; ($l+1))
			$l:=Position:C15(" "; $vsULname)
			If ($l>0)
				$vsULname:=Substring:C12($vsULname; ($l+1))
			End if 
			$vsUFname:=$vsUFname+$vsULname
			If (f_GetUserID($vsUFname)#0)
				$aInspUsers{$k}:=$vsUFname
			End if 
		End if 
	End for 
End if 
C_BOOLEAN:C305($vbTeamMember)
$vbTeamMember:=(Find in array:C230($aInspUsers; $currUser_txt)>0)
$vbTeamMember:=$vbTeamMember | (Find in array:C230($aInspectorIDs; <>CurrentUser_PID)>0)
If (False:C215)
	$vbTeamMember:=$vbTeamMember | (User in group:C338($currUser_txt; "Area Engineers"))
End if 

//Check status of inspection
Case of 
		
	: (([Inspections:27]Modified By:134=$currUser_txt) | ($vbTeamMember))
		//the creator or a member of the team is opening it and ...
		If ([Inspections:27]Insp Type:6="DV@")
			//Dive Inspections
			If (([Inspections:27]InspApproved:167#BMS Approved) | (Not:C34([Inspections:27]InspComplete:168)))
				// it has not been approved yet 
				//   or it has been marked as incomplete.
				vbInspectionLocked:=False:C215
			End if 
		Else 
			//Others      
			If ((([Inspections:27]InspApproved:167#BMS Approved) & ([Inspections:27]InspReviewed:12#BMS Approved)) | (Not:C34([Inspections:27]InspComplete:168)))
				// it has not been approved yet at any level
				//   or it has been marked as incomplete.
				vbInspectionLocked:=False:C215
			End if 
		End if 
		
	: ((vApproveLvl=2) & ([Inspections:27]InspReviewed:12=BMS Approved))
		//Final approver(sic) and has been dbie approved.
		OBJECT SET ENTERABLE:C238([Inspections:27]InspApprCmts:169; True:C214)
	: ([Inspections:27]Insp Type:6="DV@")
		//for dive forms only there is no Review stage. 
		If ((vApproveLvl=2) & ([Inspections:27]InspComplete:168))
			OBJECT SET ENTERABLE:C238([Inspections:27]InspApprCmts:169; True:C214)
		End if 
		
	: ((vApproveLvl=1) & ([Inspections:27]InspComplete:168))
		//DBIE reviewer and is complete
		OBJECT SET ENTERABLE:C238([Inspections:27]InspRevCmts:170; True:C214)
		
End case 

//For general debugging/fixing purpose - allow Design Access Group option to override checks 
If (User in group:C338($CurrUser_txt; "Design Access Group"))
	If (vbInspectionLocked)
		CONFIRM:C162("Do you "+$CurrUser_txt+" want to edit the inspection?")
		If (OK=1)
			vbInspectionLocked:=False:C215
		End if 
	End if 
	If (vApproveLvl=2)
		CONFIRM:C162("Do you "+$CurrUser_txt+" want to edit the Final Approval Comments?")
		If (OK=1)
			OBJECT SET ENTERABLE:C238([Inspections:27]InspApprCmts:169; True:C214)
		End if 
	End if 
	If (vApproveLvl=1)
		CONFIRM:C162("Do you "+$CurrUser_txt+" want to edit the DBIE Review Comments?")
		If (OK=1)
			OBJECT SET ENTERABLE:C238([Inspections:27]InspRevCmts:170; True:C214)
		End if 
	End if 
	
End if 
If (vbInspectionLocked)  //Mods_2007_CM_5401
	If (Not:C34(User in group:C338($CurrUser_txt; "Design Access Group")))
		If (Not:C34(User in group:C338($currUser_txt; "MHDInspectionRWAccess")))
			C_TEXT:C284($msg_txt)
			$msg_txt:=""
			Case of 
				: (Not:C34([Inspections:27]InspComplete:168))
					If ([Inspections:27]InspApproved:167+[Inspections:27]InspReviewed:12=0)
						$msg_txt:="incomplete Inspection!"
					Else 
						$msg_txt:="Inspection rejected during the approval process!"
					End if 
					
				: ([Inspections:27]InspApproved:167#BMS Approved)
					If ([Inspections:27]Insp Type:6#"FRZ")  //Freeze thaw don't need final approval
						$msg_txt:="Inspection that does not have final approval!"
					Else 
						If ([Inspections:27]InspReviewed:12#BMS Approved)
							$msg_txt:="Inspection that does not have final approval!"
						End if 
					End if 
					
			End case 
			If ($msg_txt#"")
				$msg_txt:="Please be aware that  you are opening an "+$msg_txt+" The information might be incomplete and/or inaccurate!"
				
				ALERT:C41($msg_txt)
			End if 
			
		End if 
	End if 
	
	READ ONLY:C145([Inspections:27])
	READ ONLY:C145([Combined Inspections:90])
	READ ONLY:C145([BMS Inspections:44])
	READ ONLY:C145([ElementsSafety:29])
	READ ONLY:C145([Standard Photos:36])
	READ ONLY:C145([Cond Units:45])
	READ ONLY:C145([Field Trip:43])
	READ ONLY:C145([BMS Field Trip:56])
	READ ONLY:C145([ElmtRatingLoads:158])
	READ ONLY:C145([PON_ELEM_INSP:179])
	READ ONLY:C145([TunnelInspection:152])
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	UNLOAD RECORD:C212([Inspections:27])
	LOAD RECORD:C52([Inspections:27])
	//For these tables unload and reload only if there is a loaded record already.
	If (Is record loaded:C669([Combined Inspections:90]))
		UNLOAD RECORD:C212([Combined Inspections:90])
		LOAD RECORD:C52([Combined Inspections:90])
	End if 
	If (Is record loaded:C669([BMS Inspections:44]))
		UNLOAD RECORD:C212([BMS Inspections:44])
		LOAD RECORD:C52([BMS Inspections:44])
	End if 
	If (Is record loaded:C669([TunnelInspection:152]))
		UNLOAD RECORD:C212([TunnelInspection:152])
		LOAD RECORD:C52([TunnelInspection:152])
	End if 
	UNLOAD RECORD:C212([ElementsSafety:29])
	UNLOAD RECORD:C212([Standard Photos:36])
	UNLOAD RECORD:C212([Cond Units:45])
	UNLOAD RECORD:C212([Field Trip:43])
	UNLOAD RECORD:C212([BMS Field Trip:56])
	UNLOAD RECORD:C212([ElmtRatingLoads:158])
	UNLOAD RECORD:C212([PON_ELEM_INSP:179])
	//SET AUTOMATIC RELATIONS(True;True)
End if 