//%attributes = {"invisible":true}
// Method: INSP_ElmSft_Input_FM
// Description
// Method for the form method of ElementSafety input forms.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/22/08, 12:30:16
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(5/15/09 10:20:34)
	Mods_2009_05
	//  `Made sure the focus is on the Rating field on the on load event
	//  `Unload the record when in ReadOnly mode (vbInspectionLocked=true)
	// Modified by: costasmanousakis-(Designer)-(1/18/11 16:13:17)
	Mods_2011_01
	//` Rail Road changes
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 16:14:45)
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 08:24:18)
	Mods_2013_05
	//  `Added Tunnel Elements categories
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(4/15/14 17:36:56)
	Mods_2014_04
	//  `added [ElmtRatingLoads] table and RRF RRS insp types
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:03:52)
	Mods_2014_08
	//  `Added inspection type TOV to the INSP_IsInspRoutine_b check
	// Modified by: Costas Manousakis-(Designer)-(3/18/15 12:39:07)
	Mods_2015_03_bug
	//  `Added "GEN" for the vItem variable.
	// Modified by: Costas Manousakis-(Designer)-(5/15/15 09:50:10)
	Mods_2015_05
	//  `for WET elements hide the Special member checkbox per req D.Kent 5/15/2015
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 10:58:38)
	Mods_2021_04
	//  `added call to LSS_SetPrevNextButtons - nav buttons on template are with no standard action
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 10:02:00)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 15:30:34)
	Mods_2021_09
	//    //execute on load events for objects on form to update pulldown arrays
	// Modified by: Costas Manousakis-(Designer)-(2022-10-25 17:27:43)
	Mods_2022_10_bug
	//  `Enable Write Pro area so it can be used to copy from using the mouse
End if 


C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
		
	: ($FormEvent_L=On Load:K2:1)
		INSP_SetWPHeadings
		C_BOOLEAN:C305(bElmNotValidated)
		If (Is new record:C668([ElementsSafety:29]))
			//new record - we do not allow this here..
			
			C_TEXT:C284($alertMsg)
			$alertMsg:="Elements must be added using the Configure button on the main Inspection Form!"
			$alertMsg:=$alertMsg+<>sCR+"To edit Elements double-click on a non-blank line."
			ALERT:C41($alertMsg)
			CANCEL:C270
		Else 
			
			LSS_SetPrevNextButtons(Selected record number:C246(Current form table:C627->); Records in selection:C76(Current form table:C627->))
			
			C_LONGINT:C283($k; $KParent; $ElmCat)
			C_LONGINT:C283($ElmNo_i)  //Command Replaced was o_C_INTEGER
			$ElmNo_i:=[ElementsSafety:29]ElementNo:1
			$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmNo_i)
			
			If (INSP_IsInspRoutine_b | ([Inspections:27]Insp Type:6="CLD") | ([Inspections:27]Insp Type:6="TOV"))
				
				If ([ElementsSafety:29]SpecMemb Flag:8)  //25-nov-03
					FORM GOTO PAGE:C247(2)
					INSP_SetElmtRtgVisibility
				Else 
					FORM GOTO PAGE:C247(1)
				End if 
				If (<>ELMTDICT_Cat_as{$K}#"N59")  //Hide Weld for non-superstructure
					OBJECT SET VISIBLE:C603(*; "DE Weld@"; False:C215)  //fields
					OBJECT SET VISIBLE:C603(*; "Weld@"; False:C215)  //labels
				Else 
					OBJECT SET VISIBLE:C603(*; "DE Weld@"; True:C214)
					OBJECT SET VISIBLE:C603(*; "Weld@"; True:C214)
				End if 
				
				If (Position:C15(<>ELMTDICT_Cat_as{$K}; ";APP;OVR;TRA;GEN;")>0)  //Hide Dive for App, Ovr, Tra, GEN
					OBJECT SET VISIBLE:C603(*; "DE Dive@"; False:C215)  //fields
					OBJECT SET VISIBLE:C603(*; "Dive@"; False:C215)  //labels
				Else 
					OBJECT SET VISIBLE:C603(*; "DE Dive@"; True:C214)
					OBJECT SET VISIBLE:C603(*; "Dive@"; True:C214)
					If ([Inspections:27]Item 93b:67=!00-00-00!)
						OBJECT SET VISIBLE:C603(*; "DE Dive@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "Dive@"; False:C215)
					End if 
					
				End if 
				If ([Inspections:27]Insp Type:6="CLD")
					OBJECT SET VISIBLE:C603(*; "DE SpecMembBox"; False:C215)
				End if 
				
			Else 
				INSP_SetElmtRtgVisibility
			End if 
			//## Initialize transfer data
			InitChangeStack(2)
			TimeStamp_ut(->[ElementsSafety:29]; ->[ElementsSafety:29]DateCreated:16; ->[ElementsSafety:29]TimeCreated:17; ->[ElementsSafety:29]DateModified:18; ->[ElementsSafety:29]TimeModified:19)
			
			OBJECT SET VISIBLE:C603(*; "DE SpecMembBox"; True:C214)
			
			Case of 
				: (<>ELMTDICT_Cat_as{$K}="N60")
					vItem:="Item 60 - Substructure"
				: (<>ELMTDICT_Cat_as{$K}="N61")
					vItem:="Item 61 - Channel & Channel Protection"
				: (<>ELMTDICT_Cat_as{$K}="N62")
					vItem:="Item 62 - Culvert"
				: (<>ELMTDICT_Cat_as{$K}="N58")
					vItem:="Item 58 - Deck"
				: (<>ELMTDICT_Cat_as{$K}="N59")
					vItem:="Item 59 - Superstructure"
				: (<>ELMTDICT_Cat_as{$K}="STR")
					vItem:="62a -  Structural"
				: (<>ELMTDICT_Cat_as{$K}="ROA")
					vItem:="62b -  Roadway"
				: (<>ELMTDICT_Cat_as{$K}="CEI")
					vItem:="62c -  Ceiling/Overhead"
				: (<>ELMTDICT_Cat_as{$K}="SUP")
					vItem:="62d -  Air Ducts"
				: (<>ELMTDICT_Cat_as{$K}="CRO")
					vItem:="62e -  Cross Passage"
				: (<>ELMTDICT_Cat_as{$K}="EGR")
					vItem:="62f -  Egress"
				: (<>ELMTDICT_Cat_as{$K}="UTI")
					vItem:="62g -  Utility Room"
				: (<>ELMTDICT_Cat_as{$K}="WET")
					vItem:="Wetness"
					OBJECT SET VISIBLE:C603(*; "DE SpecMembBox"; False:C215)
				: (<>ELMTDICT_Cat_as{$K}="GEN")
					vItem:="General"
					
				Else 
					$ElmCat:=Find in array:C230(<>aInspCod; <>ELMTDICT_Cat_as{$K})
					If ($ElmCat>0)
						vItem:=<>aInspType{$ElmCat}
					Else 
						vItem:="????"
					End if 
					
			End case 
			vElmPrefix:=GetElmtNumber
			If (<>ELMTDICT_Parent_ai{$K}>0)
				$KParent:=Find in array:C230(<>ELMTDICT_ELNum_ai; <>ELMTDICT_Parent_ai{$K})
				If ($KParent>0)
					vItem:=vItem+" - "+<>ELMTDICT_Txt_as{$KParent}
				End if 
			End if 
			
			//execute on load events for objects on form to update pulldown arrays
			POPUPMENUC(->aRatCAT1_; ->aRatCode_; ->[ElementsSafety:29]Rating:2; $FormEvent_L)
			POPUPMENUC(->aRatCAT2_; ->aRatCode_; ->[ElementsSafety:29]Rating_i:15; $FormEvent_L)
			POPUPMENUC(->aRatCAT3_; ->aRatCode_; ->[ElementsSafety:29]AltRating:21; $FormEvent_L)
			POPUPMENUC(->aRatCAT4_; ->aRatCode_; ->[ElementsSafety:29]AltRating_i:24; $FormEvent_L)
			G_ElmtDefPopup($FormEvent_L)
			POPUPMENUC(->aUORCAT_; ->aUORCode_; ->[ElementsSafety:29]Priority:20; $FormEvent_L)
			INSP_ElmtLoadRated_OM($FormEvent_L)
			asElmtSftyPulldwnName:=Find in array:C230(alElmtSftyPulldwnID; [ElementsSafety:29]ElmSafetyID:7)
			
			If (vbInspectionLocked)
				
				//disable entry if inspection is locked
				OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				//WR LOCK DOCUMENT (AreaElmComments;1)  //disable 4dWrite area
				OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_Not_editable)
				ut_UnloadRecord(->[ElementsSafety:29])
				If (Is record loaded:C669([ElmtRatingLoads:158]))
					ut_UnloadRecord(->[ElmtRatingLoads:158])
				End if 
				
				//Enable Write pro area so it can be used to copy from
				OBJECT SET ENABLED:C1123(*; "@_WP"; True:C214)
				
			Else 
				//otherwise make sure they are enterable    
				OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				//WR LOCK DOCUMENT (AreaElmComments;0)  //enable 4dWrite area
				If ([ElementsSafety:29]Deficiency:3="N")
					OBJECT SET ENABLED:C1123(aUORCAT_; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Not_editable)
				Else 
					OBJECT SET ENABLED:C1123(aUORCAT_; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENTERABLE:C238([ElementsSafety:29]Priority:20; True:C214)
					OBJECT SET RGB COLORS:C628(*; "DE Priority@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Priority@"; <>Color_Editable)
				End if 
				If ([Inspections:27]Insp Type:6="CLD")
					OBJECT SET ENABLED:C1123(*; "DE Button Delete@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
				If (Position:C15([Inspections:27]Insp Type:6; ";CMI;OTH;FCR;DAM;RRF;RRS")>0)
					If (vLoadRtgNA=1)
						OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; False:C215)
						OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_Not_editable)
					Else 
						OBJECT SET ENTERABLE:C238(*; "DE LoadRating@"; True:C214)
						OBJECT SET RGB COLORS:C628(*; "DE LoadRating@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE LoadRating@"; <>Color_editable)
					End if 
				End if 
				If ([Inspections:27]Insp Type:6#"DV@")
					GOTO OBJECT:C206([ElementsSafety:29]Rating:2)
				Else 
					GOTO OBJECT:C206([ElementsSafety:29]AltRating:21)
				End if 
				If (Is record loaded:C669([ElmtRatingLoads:158]))
					ut_LoadRecordInteractive(->[ElmtRatingLoads:158])
				End if 
				
			End if 
			//This variable is set to avoid a feature of the 4D Write area
			//`where an extra on data change event is generated after the on validate event
			//when moving to another elementssafety record using the record navigation keys
			bElmNotValidated:=True:C214
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
		If (Modified record:C314([ElmtRatingLoads:158]))
			[ElementsSafety:29]Modified By:14:=<>CurrentUser_Name
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
		//check if the comments were changed
		C_LONGINT:C283($cmtIndx_L)
		$cmtIndx_L:=Find in array:C230(PTR_CHANGES{2}; ->[ElementsSafety:29]ElmComments:23)
		If ($cmtIndx_L>0)
			//set or clear flad only if needed
			If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
				If ([ElementsSafety:29]Comment Flag:6)
				Else 
					[ElementsSafety:29]Comment Flag:6:=True:C214
					PushChange(2; ->[ElementsSafety:29]Comment Flag:6)
				End if 
			Else 
				
				If ([ElementsSafety:29]Comment Flag:6)
					[ElementsSafety:29]Comment Flag:6:=False:C215
					PushChange(2; ->[ElementsSafety:29]Comment Flag:6)
				Else 
					
				End if 
				
			End if 
		End if 
		
		TimeStamp_ut(->[ElementsSafety:29]; ->[ElementsSafety:29]DateCreated:16; ->[ElementsSafety:29]TimeCreated:17; ->[ElementsSafety:29]DateModified:18; ->[ElementsSafety:29]TimeModified:19)
		[ElementsSafety:29]Modified By:14:=<>CurrentUser_Name
		PushChange(2; ->[ElementsSafety:29]Modified By:14)
		PushChange(2; ->[ElementsSafety:29]DateModified:18)
		PushChange(2; ->[ElementsSafety:29]TimeModified:19)
		
		bElmNotValidated:=False:C215
		//##Save changes made to file
		FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
		If (Modified record:C314([ElmtRatingLoads:158]))
			// use same stack as [ElementsSafety]
			PushAllChanges(2; ->[ElmtRatingLoads:158]; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
			FlushGrpChgs(2; ->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2)
			SAVE RECORD:C53([ElmtRatingLoads:158])
			
		End if 
		
End case 