If (False:C215)
	//LP [Bridge MHD NBIS];"BDEPT Input"
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(5/19/2006 08:37:22)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(4/30/08 15:54:02)
	Mods_2008_CM_5403
	//Added Tab control ; removed record navigation btns; re-arranged location of objects on page 1;
	//for the Facility carried and Feature intersected use the new SIA_@_OM project methods.
	
	// Modified by: costasmanousakis-(Designer)-(5/13/08 16:54:49)
	Mods_2008_CM_5403
	//Removed the next/prev page buttons.
	// Modified by: costasmanousakis-(Designer)-(6/30/08 09:50:04)
	Mods_2008_CM_5404  //Added the objects and  to implement the assigning of newly created BINs to projects
	// Modified by: costasmanousakis-(Designer)-(6/3/10 16:59:39)
	Mods_2010_06
	//Added additional fields from the existing records
	//Added a new Blue bar at the header. Made form adjustable in ht and fixed moving and growing of objects on page 1
	// Modified by: costasmanousakis-(Designer)-(8/12/10 10:28:04)
	Mods_2010_08
	//  `Fixed Move preferences of some objects.
	// Modified by: costasmanousakis-(Designer)-(8/27/10 15:43:24)
	Mods_2010_08
	//  `Added Item 8 Owner
	// Modified by: costasmanousakis-(Designer)-(10/20/10 12:13:28)
	Mods_2010_10
	//  `Added [Bridge MHD NBIS]LegacyOwner
	// Modified by: costasmanousakis-(Designer)-(5/27/11 09:26:33)
	Mods_2011_05
	//  `ReLabeled 1st Tab to MassDOT Items
	// Modified by: costasmanousakis-(Designer)-(6/20/11 10:43:47)
	Mods_2011_06
	//  `Added RR info, Agency Bridge no
	// Modified by: costasmanousakis-(Designer)-(12/14/11 09:53:17)
	Mods_2011_12
	//  `Switched from aItem7 to RefBINSelector_atxt
	// Modified by: Costas Manousakis-(Designer)-(11/5/12 11:32:09)
	Mods_2012_11
	//  `Changed label from Replacement BDEPT to BDEPT being Replaced
	// Modified by: Costas Manousakis-(Designer)-(3/29/13 13:43:20)
	Mods_2013_03
	//  `Increased width of [Bridge MHD NBIS]RRBranch fielld
	// Modified by: Costas Manousakis-(Designer)-(8/19/13 13:22:33)
	Mods_2013_08
	//  `Added  code to include creation of Townline Records on the Validate event
	//  `Changed display of initial values from pulldowns : use element 0 of the puuldown to display the prompt to 
	//  `select a value instead of a variable over the pulldown. Deleted variables over the item8 dropdowns
	//  `Re arranged tab controls, form size properties, objects
	// Modified by: Costas Manousakis-(Designer)-(2/26/16 14:25:09)
	Mods_2016_02_bug
	//  `removed extra form events (on validate, on displa detail,...) from all pulldowns; and fields/variables.
	// Modified by: Costas Manousakis-(Designer)-(3/13/19 16:59:44)
	Mods_2019_03_bug
	//  `for item 6A and 7 created new entry filter Item6_7 CallReference #617
	//Add code to check and make sure all data is filled before enabling the save button
	//Modified by: Chuck Miller (9/17/19 11:50:29)
	Mods_2019_09  //Add code to check and make sure all data is filled before enabling the save button
	//Modified by: Chuck Miller (9/17/19 11:50:29)
	// Modified by: Costas Manousakis-(Designer)-(9/23/19 15:09:56)
	Mods_2019_09_bug
	//  `changed font of Town listbox; small size and location adjustment in the reference bridge dropdown 
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ARRAY TEXT:C222(abrkey; 0)  //Command Replaced was o_ARRAY string length was 12
		ARRAY TEXT:C222(aItem5; 0)  //Command Replaced was o_ARRAY string length was 9
		ARRAY TEXT:C222(aItem6; 0)  //Command Replaced was o_ARRAY string length was 24
		ARRAY BOOLEAN:C223(aItem6b; 0)
		ARRAY TEXT:C222(aItem7; 0)  //Command Replaced was o_ARRAY string length was 18
		ARRAY TEXT:C222(aItem9; 0)  //Command Replaced was o_ARRAY string length was 25
		ARRAY REAL:C219(aItem11; 0)
		ARRAY INTEGER:C220(aItem16a; 0)
		ARRAY INTEGER:C220(aItem16b; 0)
		ARRAY REAL:C219(aItem16c; 0)
		ARRAY INTEGER:C220(aItem17a; 0)
		ARRAY INTEGER:C220(aItem17b; 0)
		ARRAY REAL:C219(aItem17c; 0)
		ARRAY TEXT:C222(aItem98a; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(aItem98b; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(aItem99; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222(aInspResp; 0)  //Command Replaced was o_ARRAY string length was 5
		ARRAY TEXT:C222(Item42_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY LONGINT:C221(Item29_aL; 0)
		ARRAY INTEGER:C220(Item30_ai; 0)
		ARRAY INTEGER:C220(Item109_ai; 0)
		ARRAY INTEGER:C220(Item19_ai; 0)
		ARRAY TEXT:C222(Item38_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY BOOLEAN:C223(Item104_ab; 0)
		ARRAY TEXT:C222(Item26_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item100_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item101_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item102_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item105_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY BOOLEAN:C223(Item110_ab; 0)
		ARRAY TEXT:C222(Item20_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item21_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(Item22_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222(BridgeName_as; 0)  //Command Replaced was o_ARRAY string length was 80
		ARRAY TEXT:C222(ParBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(Item8Owner_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(Item8LegacyOwner_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(RRBranch_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY REAL:C219(RRBridgeNo_ar; 0)
		ARRAY TEXT:C222(AgencyBrNo_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY BOOLEAN:C223(aTownLineb; 0)
		
		ARRAY TEXT:C222(RefBINSelector_atxt; 0)
		
		If (OnServer=False:C215)
			Inc_Sequence("BIN"; ->vBIN_Dec)
			[Bridge MHD NBIS:1]BIN:3:=ConvertBIN(vBIN_Dec)
			OBJECT SET ENABLED:C1123(bGetRBIN; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Variable7"; False:C215)
			
		Else 
			[Bridge MHD NBIS:1]BIN:3:=""
		End if 
		[Bridge MHD NBIS:1]DateCreated:192:=Current date:C33(*)  //+◊LDifference  `Add the difference between the server date
		[Bridge MHD NBIS:1]TimeCreated:193:=Current time:C178(*)  //+◊hDifference  `Add the difference between the server time
		[Bridge MHD NBIS:1]Modified By:191:=Current user:C182
		RefBINSelector_atxt{0}:="No reference bridge ...."
		RefBINSelector_atxt:=0
		//## Initialize transfer data
		InitChangeStack(1)
		
	: (Form event code:C388=On Validate:K2:3)
		
		//##Save changes made to table
		LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0; "BIN")
		PushChange(1; ->[Bridge MHD NBIS:1]DateCreated:192)
		PushChange(1; ->[Bridge MHD NBIS:1]TimeCreated:193)
		PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		
		If ([Bridge MHD NBIS:1]OnTwnLine:177)
			C_LONGINT:C283($Select_L)
			$Select_L:=RefBINSelector_atxt
			If ($Select_L>0)
				//Selected a bridge - get the BIN
				C_TEXT:C284(BIN_txt)
				BIN_txt:=RefBINSelector_atxt{$Select_L}
				BIN_txt:=Substring:C12(BIN_txt; (Length:C16(BIN_txt)-8); 3)
				//find the records in [TownLineInfo] table
				ARRAY TEXT:C222(TownLineBdepts_atxt; 0)
				Begin SQL
					Select [TownLineInfo].BDEPT from [TownLineInfo] WHERE [TownLineInfo].BIN = :BIN_txt into :TownLineBdepts_atxt ;
				End SQL
				
				If (Size of array:C274(TownLineBdepts_atxt)>0)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274(TownLineBdepts_atxt))
						
						If (TownLineBdepts_atxt{$loop_L}#"")
							CREATE RECORD:C68([TownLineInfo:73])
							Inc_Sequence("TownLine"; ->[TownLineInfo:73]RefID:3)
							[TownLineInfo:73]BIN:1:=[Bridge MHD NBIS:1]BIN:3
							LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1; "TownLine")
							[TownLineInfo:73]BDEPT:2:=TownLineBdepts_atxt{$loop_L}
							LogChanges(->[TownLineInfo:73]BDEPT:2; ->[Bridge MHD NBIS:1]BIN:3; ->[TownLineInfo:73]BIN:1; ->[TownLineInfo:73]RefID:3; 1)
							SAVE RECORD:C53([TownLineInfo:73])
						End if 
					End for 
					
				End if 
				
			End if 
		End if 
		
End case 