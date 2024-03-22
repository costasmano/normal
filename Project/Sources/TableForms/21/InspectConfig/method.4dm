If (False:C215)
	//procedure: [Dialogs];"InspectConfig"
	//by: Albert Leung
	//created: 5/9/2001
	//modified:
	//purpose: initialize radio button state
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	Mods_2005_CM12
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(1/2/08 10:40:07)
	Mods_2007_CM_5401
	//  `Added MTA users
	// Modified by: costasmanousakis-(Designer)-(2/16/09 11:41:50)
	Mods_2009_CM_5404  // --- "FREEZETHAW" 
	// Modified by: costasmanousakis-(Designer)-(3/19/09 23:08:15)
	Mods_2009_CM_5404  //Copied to Server on : 03/20/09, 08:31:54  `("FREEZETHAW - bug fix")
	//modified fvariable names and objec names and resizable of form properties
	//made form fixed size
	// Modified by: costasmanousakis-(Designer)-(4/13/09 10:28:18)
	Mods_2009_04
	//Allow consultant inspectors to created Freeze Thaw inspections
	// Modified by: costasmanousakis-(Designer)-(4/8/10 15:52:58)
	Mods_2010_04
	//  `Converted the filter for District inspectors to MHDInspectors group.
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:01:50)
	Mods_2011_01
	//RR
	// Modified by: costasmanousakis-(Designer)-(9/6/11 14:05:26)
	Mods_2011_09
	//  `Added  "OTHER" inspection to the dive group
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 16:00:52)
	Mods_2012_05
	//  `Added "UWFloodBtn"
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 13:20:05)
	Mods_2012_06
	//  `Changed title of  "UWFloodBtn" to "UW Divers Activity"
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 19:07:32)
	Mods_2012_11
	//  `Added page 2 for new method of setting the insp type - test ibkt for Design users
	// Modified by: Costas Manousakis-(Designer)-(12/26/12 11:39:57)
	Mods_2012_12
	//  `More mods for the use of Page 2 both in On Load and On Clicked events
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 15:44:24)
	Mods_2012_12
	//  `Added separators between the different  categories of inspection types
	// Modified by: Costas Manousakis-(Designer)-(1/8/13 11:21:02)
	Mods_2013_01
	//  `Changed behavior so that default page is page 2 : Changed WindowSize property of dialog to "NoConstraints"; Automatic size based on obj TitleLabel;
	//  `Added code in form method to adjust window and buttons when using Page 1 of the form.
	// Modified by: Costas Manousakis-(Designer)-(4/10/13 16:55:59)
	Mods_2013_04
	//  `Added code to consider Tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(10/21/13 16:28:58)
	Mods_2013_10
	//  `Include BLD bridge category to tunnel type inspections
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 )
	Mods_2013_10
	//  `Use new method (page 2) for all users
	// Modified by: Costas Manousakis-(Designer)-(5/30/14 13:23:04)
	Mods_2014_05
	//  `Added inspection category labesl in the INSP_SelType_atxt  array indicating whether inspection is Highway, rail, pedestrian, etc.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=<>CurrentUser_Name
		//Disable all buttons to start
		OBJECT SET ENABLED:C1123(*; "@Btn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		If (User in group:C338($CurrUser_txt; "DiveGroup"))
			OBJECT SET ENABLED:C1123(*; "UnderWaterBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "UWLowClrBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "UWSpecMemberBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FreezeThawBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "OtherMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "UWFloodBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
		C_BOOLEAN:C305($DistrictUser_b)
		$DistrictUser_b:=User in group:C338($CurrUser_txt; "MHDInspectors")
		If ($DistrictUser_b)
			OBJECT SET ENABLED:C1123(*; "RoutineBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "RoutineArchBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "CulvertBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FracCritBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "SpecMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "OtherMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ClosedBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DamageBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FreezeThawBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (User in group:C338($CurrUser_txt; "ExternalInspectors"))
			OBJECT SET ENABLED:C1123(*; "RoutineBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "RoutineArchBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "CulvertBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FracCritBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "SpecMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "OtherMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ClosedBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DamageBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FreezeThawBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (User in group:C338($CurrUser_txt; "MDC"))
			OBJECT SET ENABLED:C1123(*; "RoutineBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "RoutineArchBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "CulvertBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FracCritBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "SpecMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "OtherMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ClosedBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DamageBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FreezeThawBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If (User in group:C338($CurrUser_txt; "MTA"))
			OBJECT SET ENABLED:C1123(*; "RoutineBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "RoutineArchBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "CulvertBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FracCritBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "SpecMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "OtherMemBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ClosedBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DamageBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "FreezeThawBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
			OBJECT SET VISIBLE:C603(*; "RoutineArchBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "FracCritBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "SpecMemBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "CulvertBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ClosedBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DamageBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "OtherMemBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "FreezeThawBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "UnderWaterBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "UWLowClrBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "UWSpecMemberBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "UWFloodBtn"; False:C215)
			
		End if 
		
		If ($CurrUser_txt="Designer")
			//This for testing purposes      
			OBJECT SET ENABLED:C1123(*; "@Btn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		OBJECT SET ENABLED:C1123(*; "bSelectType"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		ARRAY TEXT:C222($objNames_atxt; 0)
		ARRAY POINTER:C280($object_aptr; 0)
		FORM GET OBJECTS:C898($objNames_atxt; $object_aptr)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($objNames_atxt))
			
			If ($objNames_atxt{$loop_L}="@btn")
				$object_aptr{$loop_L}->:=0
			End if 
			
		End for 
		C_BOOLEAN:C305($doNew_b)
		$doNew_b:=True:C214
		
		If ($doNew_b)
			
			READ ONLY:C145([Inspection Type:31])
			C_TEXT:C284($TypeList_txt)
			C_TEXT:C284($itm42a_s)  // Command Replaced was o_C_STRING length was 1
			C_TEXT:C284($itm8C_s)  // Command Replaced was o_C_STRING length was 3
			$itm42a_s:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)
			$itm8C_s:=[Bridge MHD NBIS:1]Item8 BridgeCat:207
			C_BOOLEAN:C305($itm42aNum_b; $addHWY_b; $addPed_b; $addRail_b; $addUW_b; $addTnl_b; $AboveWater_b; $UnderWater_b)
			$itm42aNum_b:=bIsNumeric($itm42a_s)
			$addHWY_b:=False:C215
			$addPed_b:=False:C215
			$addRail_b:=False:C215
			$addUW_b:=False:C215
			$addTnl_b:=False:C215
			$AboveWater_b:=$DistrictUser_b | User in group:C338($CurrUser_txt; "ExternalInspectors")
			$AboveWater_b:=$AboveWater_b | User in group:C338($CurrUser_txt; "MDC")
			$AboveWater_b:=$AboveWater_b | User in group:C338($CurrUser_txt; "MTA")
			$AboveWater_b:=$AboveWater_b | User in group:C338($CurrUser_txt; "MBTA")
			$AboveWater_b:=$AboveWater_b | User in group:C338($CurrUser_txt; "Design Access Group")
			
			$UnderWater_b:=User in group:C338(Current user:C182; "Design Access Group") | User in group:C338($CurrUser_txt; "DiveGroup")
			$addUW_b:=$UnderWater_b
			
			If ($AboveWater_b)
				
				If (Not:C34($itm42aNum_b))
					//Add All - higway,
					$addHWY_b:=True:C214
					$addPed_b:=True:C214
					$addRail_b:=True:C214
				Else 
					
					If (Position:C15("-"+$itm42a_s+"-"; "-1-5-6-7-8-9-0-")>0)
						$addHWY_b:=True:C214
					End if 
					If (Position:C15("-"+$itm42a_s+"-"; "-3-0-")>0)
						$addPed_b:=True:C214
					End if 
					If (Position:C15("-"+$itm42a_s+"-"; "-2-4-0-")>0)
						$addRail_b:=True:C214
					End if 
					
				End if 
				
				If (Position:C15("-"+$itm8C_s+"-"; "-TNL-BTS-XXX-BLD-")>0)
					$addTnl_b:=True:C214
				Else 
					If (Position:C15("-"+$itm8C_s+"-"; "-634-BLD-BRI-BTS-CLO-CLP-CUL-NBI-NBP-TMP-UTL-TNL-XXX-")>0)
						$addHWY_b:=True:C214
					End if 
					If (Position:C15("-"+$itm8C_s+"-"; "-PED-BKY-CLP-XXX-")>0)
						$addPed_b:=True:C214
					End if 
					If (Position:C15("-"+$itm8C_s+"-"; "-TRO-RRO-XXX-")>0)
						$addRail_b:=True:C214
					End if 
					
				End if 
				
			End if 
			
			Case of 
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
					$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; [Bridge MHD NBIS:1]InspResp:173)
				Else 
					$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES")
			End case 
			ARRAY TEXT:C222(INSP_SelType_atxt; 0)
			ARRAY TEXT:C222(INSP_SelTypeCode_atxt; 0)
			INSP_InspTypesUtil("LOADFROMDATA")
			//  `INSP_Inspection_list_txt : defines whether we are in a Bridge or Tunnel inspection button
			Case of 
				: (INSP_Inspection_list_txt="BRIDGE")
					If ($addHWY_b)
						$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; "HWY")
						APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "-- Highway --")
						ut_TextToArray($TypeList_txt; ->INSP_SelTypeCode_atxt; ";")
					End if 
					If ($addPed_b)
						$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; "PED")
						APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "-- Pedestrian --")
						ut_TextToArray($TypeList_txt; ->INSP_SelTypeCode_atxt; ";")
					End if 
					If ($addRail_b)
						$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; "RAIL")
						APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "-- Rail/Transit --")
						ut_TextToArray($TypeList_txt; ->INSP_SelTypeCode_atxt; ";")
					End if 
					If ($addUW_b)
						$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; "UW")
						APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "-- Underwater --")
						ut_TextToArray($TypeList_txt; ->INSP_SelTypeCode_atxt; ";")
					End if 
				: (INSP_Inspection_list_txt="TUNNEL")
					If ($addTnl_b)
						$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES"; "TNL")
						APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "-- Tunnel --")
						ut_TextToArray($TypeList_txt; ->INSP_SelTypeCode_atxt; ";")
					End if 
					
			End case 
			
			C_LONGINT:C283($loop_L)
			For ($loop_L; Size of array:C274(INSP_SelTypeCode_atxt); 1; -1)
				
				If (INSP_SelTypeCode_atxt{$loop_L}#"")
					If (Find in array:C230(INSP_SelTypeCode_atxt; INSP_SelTypeCode_atxt{$loop_L})<$loop_L)
						DELETE FROM ARRAY:C228(INSP_SelTypeCode_atxt; $loop_L; 1)
					End if 
					
				End if 
				
			End for 
			
			For ($loop_L; 1; Size of array:C274(INSP_SelTypeCode_atxt))
				QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=INSP_SelTypeCode_atxt{$loop_L})
				If (Records in selection:C76([Inspection Type:31])=1)
					APPEND TO ARRAY:C911(INSP_SelType_atxt; [Inspection Type:31]Description:2)
				Else 
					If (INSP_SelTypeCode_atxt{$loop_L}#"")
						APPEND TO ARRAY:C911(INSP_SelType_atxt; INSP_SelTypeCode_atxt{$loop_L})
					Else 
						APPEND TO ARRAY:C911(INSP_SelType_atxt; "----")
					End if 
				End if 
			End for 
			
			APPEND TO ARRAY:C911(INSP_SelType_atxt; ".. Clear Selection ..")
			APPEND TO ARRAY:C911(INSP_SelTypeCode_atxt; "")
			C_TEXT:C284(INSP_SelectedNewInspType_txt)
			INSP_SelectedNewInspType_txt:=""
			INSP_SelType_atxt:=0
			INSP_SelTypeCode_atxt:=0
			
			FORM GOTO PAGE:C247(2)
		Else 
			
			C_LONGINT:C283($OL; $OT; $OR; $OB; $NewPos)
			OBJECT GET COORDINATES:C663(*; "RadioGroup"; $OL; $OT; $OR; $OB)
			$NewPos:=$OB+25
			OBJECT GET COORDINATES:C663(*; "bSelectType"; $OL; $OT; $OR; $OB)
			OBJECT MOVE:C664(*; "bSelectType"; 0; ($NewPos-$OT))
			OBJECT MOVE:C664(*; "Cancel button"; 0; ($NewPos-$OT))
			OBJECT GET COORDINATES:C663(*; "Cancel button"; $OL; $OT; $OR; $OB)
			$NewPos:=$OB+20
			GET WINDOW RECT:C443($OL; $OT; $OR; $OB)
			SET WINDOW RECT:C444($OL; $OT; $OR; ($OT+$NewPos))
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		ARRAY TEXT:C222($objNames_atxt; 0)
		ARRAY POINTER:C280($object_aptr; 0)
		FORM GET OBJECTS:C898($objNames_atxt; $object_aptr)
		C_LONGINT:C283($check_L)
		$check_L:=0
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($objNames_atxt))
			
			If ($objNames_atxt{$loop_L}="@btn")
				$check_L:=$check_L+$object_aptr{$loop_L}->
			End if 
			
		End for 
		
		If ($check_L>0)
			OBJECT SET ENABLED:C1123(*; "bSelectType"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
End case 