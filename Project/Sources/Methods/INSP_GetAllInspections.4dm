//%attributes = {"invisible":true}
//Method: INSP_GetAllInspections
//Description
//  `Get all inspections that belong to me.  Called from a hidden button
//  `in Inspection review form mapped to Shift-cmd-G

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/13, 12:08:39
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
End if 
//
C_LONGINT:C283($MyID_I; $Distr_no_I)  //Command Replaced was o_C_INTEGER
If (False:C215)
	If (User in group:C338(Current user:C182; "Inspection Engineers"))
		//Find the current district by getting the distr of current user
		READ ONLY:C145([Personnel:42])
		$MyID_I:=<>CurrentUser_UID
		QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$MyID_I)
		If (Records in selection:C76([Personnel:42])=1)
			$Distr_no_I:=Num:C11(Substring:C12([Personnel:42]Division No:7; 4))
			If (($Distr_no_I>0) & ($Distr_no_I<6))
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=("DIST"+String:C10($Distr_no_I)))
				RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
				//QUERY([Inspections];[Bridge MHD NBIS]InspResp=("DIST"+String($Distr_no_I)))
				QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"DV@")
				vbSortedHeader:=False:C215
				MainTitle:="All Above Water Inspections for District "+String:C10($Distr_no_I)
				RegionTitle
			Else 
				ALERT:C41("You do not have a District assigned to you in the Personnel Table!")
			End if 
		Else 
			ALERT:C41("You do not have a correctly linked record in the Personnel Table!")
		End if 
	Else 
		ALERT:C41("You're not a DBIE!!!!")
	End if 
	
End if 

Case of 
	: (<>INSP_BridgeInspEng_b)
		ALL RECORDS:C47([Inspections:27])
		INSP_SortReviewList
		REDRAW WINDOW:C456
		RegionTitle
	Else 
		CREATE EMPTY SET:C140([Inspections:27]; "$ALLDIVEINSPECTIONS")
		CREATE EMPTY SET:C140([Inspections:27]; "$ABOVEWATERINSPECTIONS")
		If (<>INSP_UOEng_b)
			SET QUERY DESTINATION:C396(Into set:K19:2; "$ALLDIVEINSPECTIONS")
			QUERY:C277([Inspections:27]; [Inspections:27]Insp Type:6="DV@")
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End if 
		
		If (Size of array:C274(<>INSP_MyDistricts_atxt)>0)
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(<>INSP_MyDistricts_atxt))
				SET QUERY DESTINATION:C396(Into set:K19:2; "$DISTRINSPECTIONS")
				QUERY:C277([Inspections:27]; [Bridge MHD NBIS:1]InspResp:173=<>INSP_MyDistricts_atxt{$loop_L}; *)
				QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"DV@"; *)  //not Dive inspections
				//not Highway inspections
				If (Not:C34(<>INSP_HWYBrgReview_b))
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"RT@"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"CUL"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FCR"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FRZ"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"OTH"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"DAM"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"CMI"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"CLD"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"PON"; *)
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"BOX"; *)
				End if 
				
				If (Not:C34(<>INSP_RailBrgReview_b))
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"RR@"; *)
				End if 
				
				If (Not:C34(<>INSP_TunnelReview_b))
					QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"T@"; *)
				End if 
				
				QUERY:C277([Inspections:27])
				
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				UNION:C120("$DISTRINSPECTIONS"; "$ABOVEWATERINSPECTIONS"; "$ABOVEWATERINSPECTIONS")
			End for 
			CLEAR SET:C117("$DISTRINSPECTIONS")
		End if 
		
		UNION:C120("$ALLDIVEINSPECTIONS"; "$ABOVEWATERINSPECTIONS"; "$ABOVEWATERINSPECTIONS")
		
		If (Records in set:C195("$ABOVEWATERINSPECTIONS")>0)
			USE SET:C118("$ABOVEWATERINSPECTIONS")
			INSP_SortReviewList
			REDRAW WINDOW:C456
			RegionTitle
		End if 
		
		CLEAR SET:C117("$ABOVEWATERINSPECTIONS")
		CLEAR SET:C117("$ALLDIVEINSPECTIONS")
End case 

//End INSP_GetAllInspections