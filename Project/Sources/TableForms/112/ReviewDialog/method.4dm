If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/14/06, 08:43:15
	// ----------------------------------------------------
	// Method: Form Method: [InventoryPhotoInsp];"ReviewDialog"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(1/31/2007 14:34:53)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 16:55:24)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/11/10 11:33:12)
	Mods_2010_06
	//  `Inserted a listbox; Moved the group arrays to page 2
	//  `Added a green bar at the Footer, adjusted the gery header bar, adjusted form margins
	// Modified by: Costas Manousakis-(Designer)-(2/13/12 13:49:03)
	Mods_2012_02
	//  `Use the array ◊INSP_MyDistricts_atxt to find if the person is a reviewer 
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:42:54)
	// Modified by: Costas Manousakis-(Designer)-(7/10/20 12:32:11)
	Mods_2020_07
	//  `Deleted page 2 - will not ask designer to choose LB or not;
	//  `changed form type to "None" and set Vert marg to 0
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; False:C215)
				
			Else 
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; True:C214)
				
		End case 
		
		INV_SetupSortVars
		OBJECT SET VISIBLE:C603(*; "INV_Sort@"; False:C215)
		If (Current user:C182="Designer")
			//CONFIRM("ListBox or Regular?";"LB";"REG")
			//If (OK=1)
			//FORM GOTO PAGE(1)
			//Else 
			//FORM GOTO PAGE(2)
			//End if 
			
		Else 
			OBJECT SET ENABLED:C1123(*; "ApproveButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			
			If (False:C215)
				READ ONLY:C145([Personnel:42])
				QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CurrentUser_PID)
				If (Records in selection:C76([Personnel:42])=1)
					If ([Personnel:42]Job Code:8=1)
						OBJECT SET ENABLED:C1123(*; "ApproveButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					End if 
					
				End if 
			Else 
				If (Size of array:C274(<>INSP_MyDistricts_atxt)>0)
					OBJECT SET ENABLED:C1123(*; "ApproveButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				End if 
			End if 
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 