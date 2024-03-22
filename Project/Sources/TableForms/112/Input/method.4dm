If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/10/06, 19:31:04
	// ----------------------------------------------------
	// Method: Form Method: [InventoryPhotoInsp];"Input"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(1/31/2007 14:31:39)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(2/6/2007 10:03:38)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(2/10/10 12:04:19)
	Mods_2010_02
	//  `Pass the user's company name qto InitPers to populate the team leader and member arrays
	// Modified by: costasmanousakis-(Designer)-(6/11/10 11:29:26)
	Mods_2010_06
	//  `Replaced the Green rectangle header with the GreenBar  faded picture.
	//  `Adjusted form margins
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/20/14 18:05:47)
	Mods_2014_06_bug
	//  `enabled tunnel inventory photo types
	// Modified by: Costas Manousakis-(Designer)-(5/3/16 16:57:16)
	Mods_2016_05_bug
	//  `changed tab orientation to Top (left not available in v13+) - re-arranged objects to fit
	Mods_2017_07_bug  //Add InDoubleClick_B to on load event to make sure it is reset to false
	//Remmember to remove test page once all is AOK
	// Modified by: Costas Manousakis-(Designer)-(5/21/18 13:24:06)
	Mods_2018_05
	//  `photo LB set to grow vertically
	Mods_2018_11  //Remove test tab when in as designer
	//Modified by: Chuck Miller (11/6/18 11:00:31)
	// Modified by: Costas Manousakis-(Designer)-(6/30/21 17:58:29)
	Mods_2021_06
	//  `moved calls to INV_TeamLeader_OM INV_TeamMember_OM near the end of On load 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		utl_SetSpellandContextMenu
		INV_SetHelpMsg_Insp
		If (Not:C34(In transaction:C397))
			START TRANSACTION:C239
		End if 
		
		C_LONGINT:C283($CurrentUserPID; $DBIE_PID)  //Command Replaced was o_C_INTEGER
		$CurrentUserPID:=<>CurrentUser_PID
		C_BOOLEAN:C305(INV_InventInspLocked)
		INV_InventInspLocked:=True:C214
		
		InitChangeStack(1)
		InitPers(<>PERS_MyCompany_txt)
		If (Is new record:C668([InventoryPhotoInsp:112]))
			SHORT_MESSAGE("Creating New Inventory Photo Inspection...")
			INV_InventInspLocked:=False:C215
			Inc_Sequence("InventoryPhotoInsp"; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
			[InventoryPhotoInsp:112]BIN:2:=[Bridge MHD NBIS:1]BIN:3
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; "InventoryPhotoInsp")
			If ([Bridge MHD NBIS:1]BIN:3#"")
				READ ONLY:C145([Inspections:27])
				QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
				QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"PON"; *)
				QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"DV@")
				If (Records in selection:C76([Inspections:27])>0)
					ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
					LOAD RECORD:C52([Inspections:27])
					[InventoryPhotoInsp:112]OrientationNS_b:4:=[Inspections:27]OrientationNS:133
					PushChange(1; ->[InventoryPhotoInsp:112]OrientationNS_b:4)
					UNLOAD RECORD:C212([Inspections:27])
				End if 
				READ WRITE:C146([Inspections:27])
			End if 
			[InventoryPhotoInsp:112]InvPhotoDate_D:3:=Current date:C33(*)
			PushChange(1; ->[InventoryPhotoInsp:112]InvPhotoDate_D:3)
			Case of 
				: (Find in array:C230(aTeamLdrID; $CurrentUserPID)>0)
					[InventoryPhotoInsp:112]TeamLeader_I:5:=$CurrentUserPID
					LogLink(->[InventoryPhotoInsp:112]TeamLeader_I:5; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
				: (Find in array:C230(aTeamMbrID; $CurrentUserPID)>0)
					[InventoryPhotoInsp:112]TeamMember_I:10:=$CurrentUserPID
					LogLink(->[InventoryPhotoInsp:112]TeamMember_I:10; ->[Bridge MHD NBIS:1]BIN:3; ->[InventoryPhotoInsp:112]BIN:2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; 1; ->[Personnel:42]Person ID:1)
					
			End case 
			//Create Set of std photos
			ARRAY TEXT:C222($PicLabels; 0)
			ARRAY LONGINT:C221($Seq; 0)
			C_BOOLEAN:C305($Tunnel_b)
			$Tunnel_b:=(([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BLD"))
			If ($Tunnel_b)
				//Mods_2014_06 FOR TUNNELS
				C_TEXT:C284($listname_txt)
				If ([InventoryPhotoInsp:112]OrientationNS_b:4)
					$listname_txt:="INV_TunnelPhotos_NS"
				Else 
					$listname_txt:="INV_TunnelPhotos_EW"
				End if 
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=$listname_txt)
				ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
				SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $PicLabels)
				SELECTION TO ARRAY:C260([TableOfLists:125]ListSequence_l:3; $Seq)
				
				If (Size of array:C274($PicLabels)=0)
					ALERT:C41("Required List ["+$listname_txt+"] Not found in the database!  Please notify the database administrator!")
				End if 
				
			Else 
				If ([InventoryPhotoInsp:112]OrientationNS_b:4)
					LIST TO ARRAY:C288("INV_PhotoDesc_NS"; $PicLabels)
				Else 
					LIST TO ARRAY:C288("INV_PhotoDesc_EW"; $PicLabels)
				End if 
				ARRAY LONGINT:C221($Seq; Size of array:C274($PicLabels))  //make sure it is 
				
			End if 
			
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274($PicLabels))  //Mods_2014_06
				CREATE RECORD:C68([InventoryPhotos:113])
				Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
				[InventoryPhotos:113]InvPhotoInsp_ID:2:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
				LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
				InitChangeStack(2)
				[InventoryPhotos:113]PhotoDescr_txt:3:=$PicLabels{$i}
				PushChange(2; ->[InventoryPhotos:113]PhotoDescr_txt:3)
				
				If ($Seq{$i}=0)
					
					Case of 
						: (Position:C15("APPROACH"; $PicLabels{$i})>0)
							[InventoryPhotos:113]Sequence_I:5:=1
						: (Position:C15("ELEVATION"; $PicLabels{$i})>0)
							[InventoryPhotos:113]Sequence_I:5:=2
						: (Position:C15("UNDERSIDE"; $PicLabels{$i})>0)
							[InventoryPhotos:113]Sequence_I:5:=3
							
					End case 
				Else 
					[InventoryPhotos:113]Sequence_I:5:=$Seq{$i}
					
				End if 
				
				PushChange(2; ->[InventoryPhotos:113]Sequence_I:5)
				FlushGrpChgs(2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
				SAVE RECORD:C53([InventoryPhotos:113])
				
			End for 
			C_BOOLEAN:C305($BridgeAboveWater_B)
			$BridgeAboveWater_B:=False:C215
			Case of 
				: ([Bridge MHD NBIS:1]Item6A:63="WATER@")
					$BridgeAboveWater_B:=True:C214
				: (Position:C15(Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 2); ";5;6;7;8;9;")>0)
					$BridgeAboveWater_B:=True:C214
			End case 
			
			If (($BridgeAboveWater_B) & Not:C34($Tunnel_b))  // no required water shots for tunnels
				CREATE RECORD:C68([InventoryPhotos:113])
				Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
				[InventoryPhotos:113]InvPhotoInsp_ID:2:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
				LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
				InitChangeStack(2)
				[InventoryPhotos:113]PhotoDescr_txt:3:="LOOKING UPSTREAM"
				PushChange(2; ->[InventoryPhotos:113]PhotoDescr_txt:3)
				[InventoryPhotos:113]Sequence_I:5:=4
				PushChange(2; ->[InventoryPhotos:113]Sequence_I:5)
				FlushGrpChgs(2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
				SAVE RECORD:C53([InventoryPhotos:113])
				CREATE RECORD:C68([InventoryPhotos:113])
				Inc_Sequence("InventoryPhoto"; ->[InventoryPhotos:113]InvPhoto_ID:1)
				[InventoryPhotos:113]InvPhotoInsp_ID:2:=[InventoryPhotoInsp:112]InvPhotoInspID_L:1
				LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
				InitChangeStack(2)
				[InventoryPhotos:113]PhotoDescr_txt:3:="LOOKING DOWNSTREAM"
				PushChange(2; ->[InventoryPhotos:113]PhotoDescr_txt:3)
				[InventoryPhotos:113]Sequence_I:5:=4
				PushChange(2; ->[InventoryPhotos:113]Sequence_I:5)
				FlushGrpChgs(2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
				SAVE RECORD:C53([InventoryPhotos:113])
				
			End if 
			CLOSE WINDOW:C154
		Else 
			$DBIE_PID:=utf_GetDBIE_PID
			Case of 
				: (Current user:C182="Designer")
					INV_InventInspLocked:=False:C215
				: ([InventoryPhotoInsp:112]Approved_I:6=BMS Approved)
					INV_InventInspLocked:=True:C214
				: (($CurrentUserPID=$DBIE_PID) | ($CurrentUserPID=[InventoryPhotoInsp:112]TeamLeader_I:5) | ($CurrentUserPID=[InventoryPhotoInsp:112]TeamMember_I:10))
					INV_InventInspLocked:=False:C215
					
			End case 
			
		End if 
		
		INV_TeamLeader_OM
		INV_TeamMember_OM
		
		INV_CreatePhotosList
		C_TEXT:C284(INV_ReviewCommtsOrig_txt; INV_ReviewCommtsDisp_txt; INV_ReviewCommtsAdd_txt)
		INV_ReviewCommtsOrig_txt:=[InventoryPhotoInsp:112]ApproveComments_txt:7
		INV_ReviewCommtsDisp_txt:=INV_ReviewCommtsOrig_txt
		INV_ReviewCommtsAdd_txt:=""
		If (INV_ReviewCommtsDisp_txt="")
			OBJECT SET TITLE:C194(*; "DE INV_ReplyComments@"; "Add Comments")
		Else 
			OBJECT SET TITLE:C194(*; "DE INV_ReplyComments@"; "Reply/Add Comments")
		End if 
		
		INV_LockUnLockCurrRec(INV_InventInspLocked; Current form table:C627)
		If (<>PL_LPlatfrm=Windows:K25:3)
			C_LONGINT:C283($top; $left; $right; $bot)  //Command Replaced was o_C_INTEGER
			OBJECT GET COORDINATES:C663(*; "TabBackGround"; $top; $left; $right; $bot)
			OBJECT MOVE:C664(*; "TabBackGround"; ($top-20); ($left+20); $right; $bot; *)
			OBJECT MOVE:C664(*; "@_move"; 0; 20)
			OBJECT MOVE:C664(*; "@_resize"; 0; 20; 0; -20)
		End if 
		InDoubleClick_B:=False:C215
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		
End case 
