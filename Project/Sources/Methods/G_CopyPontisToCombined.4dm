//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// G_CopyPontisToCombined
	// User name (OS): charlesmiller
	// Date and time: 03/06/09, 14:29:44
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(2/15/2006 12:49:19)
	Mods_2006_CM03
	Mods_2009_03  //CJM  r001   `03/06/09, 14:29:35`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(2/26/10 17:07:31)
	Mods_2010_02
	//  `Changes for new HI fields in BMS inspections.
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(3/6/13 16:11:19)
	Mods_2013_03
	//  `Filter out inspections with no CUs before displaying the list of dates
End if 

If ([Combined Inspections:90]BMSInspID:3<=0)
	ALERT:C41("Need to Create a Pontis Inspection First!   Please click the <Add Pontis Inspecti"+"on> button")
Else 
	//Save current inspection  
	C_LONGINT:C283($vCurrCombID; $vCurrBMSInspID)
	$vCurrBMSInspID:=[BMS Inspections:44]Inspection ID:1
	C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
	GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=[Bridge MHD NBIS:1]BIN:3; *)
	QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Inspection ID:1#$vCurrBMSInspID)
	C_LONGINT:C283($NumCUs_L)
	CREATE EMPTY SET:C140([BMS Inspections:44]; "BMSINSPTOCOPYFROM")
	FIRST RECORD:C50([BMS Inspections:44])
	While (Not:C34(End selection:C36([BMS Inspections:44])))
		$NumCUs_L:=0
		SET QUERY DESTINATION:C396(Into variable:K19:4; $NumCUs_L)
		QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($NumCUs_L>0)
			ADD TO SET:C119([BMS Inspections:44]; "BMSINSPTOCOPYFROM")
		End if 
		NEXT RECORD:C51([BMS Inspections:44])
	End while 
	
	USE SET:C118("BMSINSPTOCOPYFROM")
	CLEAR SET:C117("BMSINSPTOCOPYFROM")
	
	If (Records in selection:C76([BMS Inspections:44])<1)
		ALERT:C41("No other Pontis inspections to copy Pontis Elements from for current BIN <"+[Bridge MHD NBIS:1]BIN:3+"> !")
	Else 
		ARRAY DATE:C224(aSelBMSInsp; 0)
		ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <)
		SELECTION TO ARRAY:C260([BMS Inspections:44]Insp Date:4; aSelBMSInsp)
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "SelectPontisInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		//$tempWin:=Open form window([Dialogs];"SelectPontisInsp")
		DIALOG:C40([Dialogs:21]; "SelectPontisInsp")
		CLOSE WINDOW:C154($Win_l)
		If (OK=1)
			SET CURSOR:C469(4)
			C_LONGINT:C283($NoCUs; $i; $j)
			GOTO SELECTED RECORD:C245([BMS Inspections:44]; aSelBMSInsp)
			vInspToCopy:=[BMS Inspections:44]Inspection ID:1  // save the id to copy
			QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=vInspToCopy)
			$NoCUs:=Records in selection:C76([Cond Units:45])
			If ($NoCUs>0)
				COPY NAMED SELECTION:C331([Cond Units:45]; "Cond Units")
				For ($i; 1; $NoCUs)
					DUPLICATE RECORD:C225([Cond Units:45])
					[Cond Units:45]Cond Unit ID:1:=0  //This must be zero for Inc_Sequence.
					Inc_Sequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
					//      $NewCUID:=[Cond Units]Cond Unit ID
					[Cond Units:45]Inspection ID:2:=$vCurrBMSInspID
					SAVE RECORD:C53([Cond Units:45])
					LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2; "Cond Unit ID")
					InitChangeStack(2)
					PushChange(2; ->[Cond Units:45]Element ID:3)
					PushChange(2; ->[Cond Units:45]Environment:4)
					PushChange(2; ->[Cond Units:45]Total Quantity:5)
					If ([Cond Units:45]Percent:6)
						PushChange(2; ->[Cond Units:45]Percent:6)
					End if 
					For ($j; 1; vMaxCSs)
						If (a_ptr_CSfld{$j}->#0)
							PushChange(2; a_ptr_CSfld{$j})
						End if 
					End for 
					If ([Cond Units:45]Comment:7#"")
						PushChange(2; ->[Cond Units:45]Comment:7)
					End if 
					FlushGrpChgs(2; ->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
					
					USE NAMED SELECTION:C332("Cond Units")
					NEXT RECORD:C51([Cond Units:45])
					COPY NAMED SELECTION:C331([Cond Units:45]; "Cond Units")
				End for 
				CLEAR NAMED SELECTION:C333("Cond Units")
			End if 
			
			SET CURSOR:C469(0)
		End if   // if OK to copy
		
	End if 
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$vCurrBMSInspID)
	SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
	
	//restore current selections
	RememberCombined
	INSP_HICalcControl("INIT")
	INSP_HICalcControl("CALC")
	INSP_HICalcControl("TODB")
End if 
//End G_CopyPontisToCombined