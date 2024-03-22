If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// ----------------------------------------------------
	// Method: Form Method: [NBIS Secondary];"2nd In"
	
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Date and time: 04/23/08, 09:10:06
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(5/1/08 09:40:55)
	Mods_2008_CM_5403
	//  `Added code for future use to initialize the new record
	//  `Adjusted location arrangement and styles of all objects on the form
	//  `Modified input of items6a,7 to be the same as for the [Bridge MHD NBIS] fields.
	//  `Changed print button to  a picture button
	// Modified by: Costas Manousakis-(Designer)-(5/21/14 17:22:46)
	Mods_2014_05
	//  `Modifications to enable adding and editing secondary records
	//  `with validation of item5
	// Modified by: Costas Manousakis-(Designer)-(4/9/19 17:35:44)
	Mods_2019_04_bug
	//  `changed filter for Item5D to allow a letter in the route (ex . 2A), changed Variable Item5D_L to Item5D_txt
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		//## Initialize transfer data
		InitChangeStack(1)
		ARRAY TEXT:C222($otherItem5_atxt; 0)
		ARRAY TEXT:C222($otherItem6a_atxt; 0)
		SIA_CheckOther2ND(->$otherItem5_atxt; ->$otherItem6a_atxt; [Bridge MHD NBIS:1]BIN:3; [NBIS Secondary:3]NBISSecondaryKey_l:39)
		ARRAY TEXT:C222($otherItem5A_atxt; Size of array:C274($otherItem5_atxt))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($otherItem5_atxt))
			$otherItem5A_atxt{$loop_L}:=Substring:C12($otherItem5_atxt{$loop_L}; 1; 1)
		End for 
		C_TEXT:C284($currUser_txt)
		$currUser_txt:=<>CurrentUser_Name
		If (Is new record:C668([NBIS Secondary:3]))
			Inc_Sequence("[NBIS Secondary]"; ->[NBIS Secondary:3]NBISSecondaryKey_l:39)
			[NBIS Secondary:3]BIN:1:=[Bridge MHD NBIS:1]BIN:3
			[NBIS Secondary:3]Item3:2:=[Bridge MHD NBIS:1]Item3:61
			[NBIS Secondary:3]Item4:3:=[Bridge MHD NBIS:1]Item4:62
			[NBIS Secondary:3]Item6A:5:=[Bridge MHD NBIS:1]Item6A:63
			[NBIS Secondary:3]Item6B:6:=[Bridge MHD NBIS:1]Item6B:64
			[NBIS Secondary:3]Item7:7:=[Bridge MHD NBIS:1]Item7:65
			[NBIS Secondary:3]Item8:38:=[Bridge MHD NBIS:1]Item8:206
			[NBIS Secondary:3]Item10:9:=[Bridge MHD NBIS:1]Item10:102
			[NBIS Secondary:3]Item16A:12:=[Bridge MHD NBIS:1]Item16A:68
			[NBIS Secondary:3]Item16B:13:=[Bridge MHD NBIS:1]Item16B:69
			[NBIS Secondary:3]Item16C:35:=[Bridge MHD NBIS:1]Item16C:109
			[NBIS Secondary:3]Item17A:14:=[Bridge MHD NBIS:1]Item17A:70
			[NBIS Secondary:3]Item17B:15:=[Bridge MHD NBIS:1]Item17B:71
			[NBIS Secondary:3]Item17C:36:=[Bridge MHD NBIS:1]Item17C:136
			[NBIS Secondary:3]Item19:16:=[Bridge MHD NBIS:1]Item19:91
			[NBIS Secondary:3]Item27:19:=[Bridge MHD NBIS:1]Item27:83
			[NBIS Secondary:3]Item28A:20:=[Bridge MHD NBIS:1]Item28A:86
			[NBIS Secondary:3]Item28B:21:=[Bridge MHD NBIS:1]Item28B:87
			[NBIS Secondary:3]Item42:23:=[Bridge MHD NBIS:1]Item42:85
			[NBIS Secondary:3]Item43:24:=[Bridge MHD NBIS:1]Item43:75
			[NBIS Secondary:3]Item47:25:=[Bridge MHD NBIS:1]Item47:104
			[NBIS Secondary:3]Item48:26:=[Bridge MHD NBIS:1]Item48:92
			[NBIS Secondary:3]Item49:27:=[Bridge MHD NBIS:1]Item49:93
			[NBIS Secondary:3]Item101:29:=[Bridge MHD NBIS:1]Item101:122
			[NBIS Secondary:3]Item103:31:=[Bridge MHD NBIS:1]Item103:124
			//try to make out item5
			C_TEXT:C284($item5a_s; $item5b_s; $item5c_s; $item5e_s)  // Command Replaced was o_C_STRING length was 2
			C_TEXT:C284($item5d_s)  // Command Replaced was o_C_STRING length was 5
			//defaults
			
			Case of 
				: (Size of array:C274($otherItem5_atxt)=0)
					$item5a_s:="2"
				: (Size of array:C274($otherItem5_atxt)>0)
					$item5a_s:=Char:C90(Character code:C91("A")+Size of array:C274($otherItem5_atxt))
					C_LONGINT:C283($badItem5_L)
					$badItem5_L:=Find in array:C230($otherItem5A_atxt; "2")
					If ($badItem5_L>0)
						C_TEXT:C284($msg)
						$msg:="You are creating multiple Secondary records and there is already a record with Item5A=2! "
						$msg:=$msg+"( I5 = "+$otherItem5_atxt{$badItem5_L}+"  I6A = "+$otherItem6a_atxt{$badItem5_L}+" ) "
						$msg:=$msg+" After finishing the current record, make sure you correct it!"
						ALERT:C41($msg)
					End if 
					
			End case 
			
			SIA_GetItem5FromFeature([NBIS Secondary:3]Item6A:5; ->$item5b_s; ->$item5c_s; ->$item5d_s; ->$item5e_s)
			
			[NBIS Secondary:3]Item5:4:=$item5a_s+$item5b_s+$item5c_s+$item5d_s+$item5e_s  //to be filled out
			
		End if 
		//Unrestricted check box for Item 10
		
		If ([Bridge MHD NBIS:1]Item10:102=99.99)
			CBItem10:=1
		Else 
			CBItem10:=0
		End if 
		//Radio buttons for Bypass detour length Item 19
		rItem19a:=0
		rItem19b:=0
		rItem19c:=0
		Case of 
			: ([NBIS Secondary:3]Item19:16=0)
				rItem19a:=1
			: ([NBIS Secondary:3]Item19:16=1)
				rItem19b:=1
			: ([NBIS Secondary:3]Item19:16=199)
				rItem19c:=1
		End case 
		
		//Check box for Item 47
		If ([NBIS Secondary:3]Item47:25=99.9)
			CBItem47:=1
		Else 
			CBItem47:=0
		End if 
		item43a:=Substring:C12([NBIS Secondary:3]Item43:24; 1; 1)
		POPUPMENUC(->aItem43aDes; ->aItem43a; ->item43a)
		item43b:=Substring:C12([NBIS Secondary:3]Item43:24; 2; 2)
		POPUPMENUC(->aItem43bDes; ->aItem43b; ->item43b)
		item42b:=Substring:C12([NBIS Secondary:3]Item42:23; 2; 1)
		POPUPMENUC(->aItem42bDes; ->aItem42b; ->item42b)
		item42a:=Substring:C12([NBIS Secondary:3]Item42:23; 1; 1)
		POPUPMENUC(->aItem42aDes; ->aItem42a; ->item42a)
		POPUPMENUC(->aItem101d_; ->aItem101_; ->[NBIS Secondary:3]Item101:29)
		SIA_Feature_OM(->[NBIS Secondary:3]Item7:7; ->IDa7FDescr_; ->IDv7FDescr; ->IDa7FCodes_; ->IDv7RteNum; ->IDv7suffix; ->IDv7Descr)
		SIA_Feature_OM(->[NBIS Secondary:3]Item6A:5; ->IDaFeatDescr_; ->IDvFeatDescr; ->IDaFeatCodes_; ->IDvRteNum; ->IDvSuffix; ->IDv6Descr)
		SIA_Item5_OM(->[NBIS Secondary:3]Item5:4)
		
		C_TEXT:C284($item5A_Filter_txt)
		$item5A_Filter_txt:="2"
		
		For ($loop_L; Character code:C91("A"); Character code:C91("Z"))
			$item5A_Filter_txt:=$item5A_Filter_txt+";"+Char:C90($loop_L)
		End for 
		
		If (Size of array:C274($otherItem5A_atxt)=0)
			
		Else 
			//if more than 1 - remove the 2
			$item5A_Filter_txt:=Substring:C12($item5A_Filter_txt; 3)
			//then remove the other existing 5As
			C_LONGINT:C283($charpos_L)
			For ($loop_L; 1; Size of array:C274($otherItem5A_atxt))
				$charpos_L:=Position:C15($otherItem5A_atxt{$loop_L}; $item5A_Filter_txt)
				
				If ($charpos_L>0)
					$item5A_Filter_txt:=Substring:C12($item5A_Filter_txt; 1; ($charpos_L-1))+Substring:C12($item5A_Filter_txt; ($charpos_L+2))
				End if 
				
			End for 
			
		End if 
		$item5A_Filter_txt:="!_~"+<>sQU+$item5A_Filter_txt+<>sQU+"#"
		OBJECT SET FILTER:C235(Item5A_txt; $item5A_Filter_txt)
		
		//need to LOCK form for permissions
		If (Not:C34(User in group:C338($currUser_txt; "SIA Access")) | Not:C34(BRG_RWAccess))
			OBJECT SET ENTERABLE:C238(*; "Field@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "Featur@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
			
			OBJECT SET RGB COLORS:C628(*; "Field@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Field@"; <>Color_not_editable)
			OBJECT SET RGB COLORS:C628(*; "Featur@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Featur@"; <>Color_not_editable)
			OBJECT SET RGB COLORS:C628(*; "DE @"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE @"; <>Color_not_editable)
			OBJECT SET ENTERABLE:C238(*; "Variable@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Variable@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Featur@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "VariableCopyLatLon"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			C_BOOLEAN:C305($tableRO_b)
			$tableRO_b:=Read only state:C362([NBIS Secondary:3])
			
			If (Not:C34($tableRO_b))
				READ ONLY:C145([NBIS Secondary:3])
			End if 
			UNLOAD RECORD:C212([NBIS Secondary:3])
			LOAD RECORD:C52([NBIS Secondary:3])
			
			If (Not:C34($tableRO_b))
				READ WRITE:C146([NBIS Secondary:3])
			End if 
		Else 
			If (User in group:C338($currUser_txt; "Key Access"))
				OBJECT SET ENTERABLE:C238(*; "Features@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "Features@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				//Update Item8 if different
				
				If ([NBIS Secondary:3]Item8:38#[Bridge MHD NBIS:1]Item8:206)
					ALERT:C41("Updating old Item 8 ("+[NBIS Secondary:3]Item8:38+") on secondary record to match Item 8 on Primary ("+[Bridge MHD NBIS:1]Item8:206+")")
					[NBIS Secondary:3]Item8:38:=[Bridge MHD NBIS:1]Item8:206
					PushChange(1; ->[NBIS Secondary:3]Item8:38)
				End if 
				
			Else 
				OBJECT SET ENTERABLE:C238(*; "Features@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "Features@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
			
			If ((User in group:C338(Current user:C182; "Design Access Group")) | (utf_ConnectedToBoston_b & User in group:C338(<>CurrentUser_Name; "InspectionReview")))
				OBJECT SET ENABLED:C1123(*; "DE Delete"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123(*; "DE Delete"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
			
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
End case 