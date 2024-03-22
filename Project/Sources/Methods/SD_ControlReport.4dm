//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_ControlReport
// User name (OS): cjmiller
// Date and time: 11/02/04, 10:40:22
// ----------------------------------------------------
// Description
// This method will brin up dialog and control printing of structural defect repor
//
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CM04
	Mods_2005_CJM03  //04/19/05, 13:39:34`
	Mods_2009_03  //CJM  r001   `03/06/09, 14:28:12`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 10:48:33      ` Type all local variables for v11
End if 

Case of 
	: (Records in table:C83([SD_History:89])=0)
		ALERT:C41("There are no records in the SD History table!!")
	Else 
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l; $Loop_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([SD_History:89]; "QryForm"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 0; $Title_txt; "ut_CloseCancel")
		//$win:=Open form window([SD_History];"QryForm";0)
		DIALOG:C40([SD_History:89]; "QryForm")
		CLOSE WINDOW:C154($Win_l)
		ARRAY TEXT:C222(aEndMonths; 0)  //Command Replaced was o_ARRAY string length was 10
		
		If (OK=0)
			
		Else 
			If (<>SD_IncludeALL_l=1)
				<>SD_Owner_s:="ALL"
			Else 
				For ($Loop_l; 1; Size of array:C274(aIt8OwnerDesIncludedCode))
					If ($Loop_l=1)
						<>SD_Owner_s:=aIt8OwnerDesIncludedCode{$Loop_l}
					Else 
						<>SD_Owner_s:=<>SD_Owner_s+", "+aIt8OwnerDesIncludedCode{$Loop_l}
					End if 
				End for 
			End if 
			//we are doing a report
			If (<>SD_SubTotalByOwner_l=1)
				
				SD_ReportByOwner
				
			Else 
				
				If (<>SD_Detail_l=0)
					SD_NewSummaryReport
				Else 
					SD_NewDetailReport
					//SD_PrintDetail 
				End if 
			End if 
		End if 
		
		ARRAY TEXT:C222(aIt8OwnerCode; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(aIt8OwnerDes; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY LONGINT:C221($NumberSDAdded_a; 0)
		ARRAY TEXT:C222(aIt8OwnerDesIncludedCode; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(aIt8OwnerDesIncluded; 0)  //Command Replaced was o_ARRAY string length was 50
		
		ARRAY LONGINT:C221($NumberSDRemoved_a; 0)
		ARRAY LONGINT:C221($NumberPostedAdded_a; 0)
		ARRAY LONGINT:C221($NumberPostedRemoved_a; 0)
		ARRAY TEXT:C222($SearchMonths_atxt; 0)
		ARRAY TEXT:C222($SearchYears_atxt; 0)
		
		//End SD_ControlReport
End case 
