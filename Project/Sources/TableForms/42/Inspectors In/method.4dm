If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Administrator
	// Date and time: 08/29/05, 10:59:00
	// ----------------------------------------------------
	// Method: Form Method: Inspectors In
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM16
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 16:52:33)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 16:40:05)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/12/2006 11:24:00)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(9/17/2007 09:38:04)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/7/08 11:58:16)
	Mods_2008_CM_5404  //("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(2/13/09 11:44:10)
	Mods_2009_CM_5404
	//Modified the form margins and the On horiz resize properties of some objects.
	Mods_2011_06  // CJ Miller`06/20/11, 11:10:58      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/19/12 17:01:19)
	Mods_2012_04
	//  `Added the cell phone field
	// Modified by: Costas Manousakis-(Designer)-(6/15/12 13:08:02)
	Mods_2012_06
	//  `Added boolean  PERS_NEWRECORD_B  - on the On Validate event the reocrd  is alreadey saved ( not new)
	// Modified by: Costas Manousakis-(Designer)-(12/27/17 12:29:32)
	Mods_2017_12
	//  `for the zero UserID make the name also zero so typeahead works better for it
	Mods_2018_04  //add groups person is member of 
	// Modified by: Costas Manousakis-(Designer)-(8/28/18 10:49:06)
	Mods_2018_08
	//  `added label on page 2 with the person id , name and employer
	// Modified by: Costas Manousakis-(Designer)-(2021-10-22T00:00:00 15:13:42)
	Mods_2021_10_bug
	//  `resize window on load to fit input form
	// Modified by: Costas Manousakis-(Designer)-(2023-04-10 17:44:50)
	Mods_2023_04
	//  `replaced inspection member info with a collection based listbox
	// Modified by: Costas Manousakis-(Designer)-(2023-06-07 10:36:30)
	Mods_2023_06_bug
	//  fixed using the wrong name for PWUserHList object
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//Resize window to fit form
		C_LONGINT:C283($FormW_L; $formH_L)
		C_TEXT:C284($formname_txt)
		$formname_txt:=CurrentFormName(Current method path:C1201)
		ut_WindowSize("FITFORM"; ->$FormW_L; ->$formH_L; Current form table:C627; $formname_txt)
		
		OBJECT SET VISIBLE:C603(*; "ViewGroups"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Variable46"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Variable45"; False:C215)
		
		If (User in group:C338(Current user:C182; "Design Access Group")) | (User in group:C338(Current user:C182; "Personnel Admin"))
			
			OBJECT SET VISIBLE:C603(*; "ViewGroups"; True:C214)
			OBJECT SET TITLE:C194(*; "ViewGroups"; "View Groups")
			
		End if 
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(PERS_NEWRECORD_B)
		PERS_NEWRECORD_B:=False:C215
		If ([Personnel:42]Person ID:1=0)
			Inc_Sequence("Personnel"; ->[Personnel:42]Person ID:1)
			PERS_NEWRECORD_B:=True:C214
		End if 
		InitChangeStack(1)
		ARRAY TEXT:C222($PWUserList; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY INTEGER:C220($PWUserIDs; 0)
		GET USER LIST:C609($PWUserList; $PWUserIDs)
		SORT ARRAY:C229($PWUserList; $PWUserIDs)
		INSERT IN ARRAY:C227($PWUserList; 0)
		INSERT IN ARRAY:C227($PWUserIDs; 0)
		$PWUserList{1}:="0"
		$PWUserIDs{1}:=0
		C_LONGINT:C283(PWUserHList)
		If (Is a list:C621(PWUserHList))
			CLEAR LIST:C377(PWUserHList; *)
		End if 
		PWUserHList:=New list:C375
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($PWUserList))
			APPEND TO LIST:C376(PWUserHList; ($PWUserList{$i}+" <"+String:C10($PWUserIDs{$i})+">"); $PWUserIDs{$i})
		End for 
		ARRAY TEXT:C222($PWUserList; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY INTEGER:C220($PWUserIDs; 0)
		
		POPUP_HL_MENUC(PWUserHList; ->[Personnel:42]UserID_4D:12)
		If ((Current user:C182="Designer") | (Current user:C182="Administrator"))
			OBJECT SET ENTERABLE:C238([Personnel:42]UserID_4D:12; True:C214)
			OBJECT SET ENABLED:C1123(*; "PWUserHList"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENTERABLE:C238([Personnel:42]UserID_4D:12; False:C215)
			OBJECT SET ENABLED:C1123(*; "PWUserHList"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		If ([Personnel:42]Person ID:1>0)
			//SET QUERY DESTINATION(Into variable;vBMSInsps_L)
			//QUERY([BMS Field Trip];[BMS Field Trip]Person ID=[Personnel]Person ID)
			//SET QUERY DESTINATION(Into variable;vNBIInsps_L)
			//QUERY([Field Trip];[Field Trip]Person ID=[Personnel]Person ID)
			//SET QUERY DESTINATION(Into current selection)
			C_COLLECTION:C1488(memberof_c)
			memberof_c:=New collection:C1472
			memberof_c.push(New object:C1471("type"; "BMS insp"; "tmcount"; \
				ds:C1482["BMS Field Trip"].query("\"Person ID\" = :1"; [Personnel:42]Person ID:1).length))
			memberof_c.push(New object:C1471("type"; "NBI insp"; \
				"tmcount"; ds:C1482["Field Trip"].query("\"Person ID\" = :1"; [Personnel:42]Person ID:1).length; \
				"tlcount"; ds:C1482.Inspections.query("TeamLeader = :1"; [Personnel:42]Person ID:1).length))
			memberof_c.push(New object:C1471("type"; "Anc. insp"; \
				"tmcount"; ds:C1482.LSS_TeamMembers.query("LSS_TeamMemberId_L = :1"; [Personnel:42]Person ID:1).length; \
				"tlcount"; ds:C1482.LSS_Inspection.query("LSS_TeamLeaderId_L = :1"; [Personnel:42]Person ID:1).length))
			memberof_c.push(New object:C1471("type"; "Tunnel insp"; \
				"tmcount"; ds:C1482.TIN_Insp_TmMembers.query("PersonID = :1"; [Personnel:42]Person ID:1).length; \
				"tlcount"; ds:C1482.TIN_Inspections.query("TeamLeader = :1"; [Personnel:42]Person ID:1).length))
			//C_POINTER($clbox_ptr)
			//$clbox_ptr:=OBJECT Get pointer(Object named;"memberof")
			//$clbox_ptr->:=memberof_c
		Else 
		End if 
		
		
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(aJob; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(ZZ5; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(bzOK; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(PWUserHList; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (PERS_NEWRECORD_B)
			SAVE RECORD:C53([Personnel:42])
			LogNewRecord(->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 4; "Personnel")
		End if 
		FlushGrpChgs(1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
		
End case 