//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 09:15:20
	// ----------------------------------------------------
	// Method: WK_ScrollArea
	// Description
	// Handle Loading and unloading of selected Work Hour Line Item for Editing.
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:44:31)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 13:53:30)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:43:22)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  //("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(1/1/09 17:53:52)
	Mods_2008_CM_5404  //("WKHRSMODS")
	Mods_2009_03  //CJM  r001   `03/06/09, 14:36:47`Upgrade from open form window to open window
	
	// Modified by: costasmanousakis-(Designer)-(3/20/09 00:35:08)
	Mods_2009_CM_5404  //Copied to Server on : 03/20/09, 08:23:59   ` ("WKHRMODS")  `bug fix
	//Correct CLOSE WINDOW call
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_LONGINT:C283($ItemIndex; $tempwin)
C_TEXT:C284($ItemNum)  // Command Replaced was o_C_STRING length was 10
C_POINTER:C301($var_ptr)
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_BOOLEAN:C305(WKHR_EditLineItem)  //If can edit the line item description

Case of 
		//: (WKHR_LockEstimate)
		//: (User in group(Current user;"BridgeMaintCtrl"))
		//: (User in group(Current user;"BridgeMaintAppr"))
		//Do nothing
	: ($FormEvent_L=On Double Clicked:K2:5)
		WKHR_InitLineItemVars
		If (Arr_ItemNos>0)
			//ALERT("double Clicked on array "+$vsPointername+" index :"+String($fieldptr->))
			C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3)
			arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
			arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
			arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
			$ItemNum:=Arr_ItemNos{Arr_ItemNos}
			$itemIndex:=Find in array:C230(arrPtr_1->; $ItemNum)
			ARRAY TEXT:C222(WKHR_ItemsList_atxt; 0)
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274(Arr_ItemNos))
				If ($i=1)
					INSERT IN ARRAY:C227(WKHR_ItemsList_atxt; 1; 1)
					WKHR_ItemsList_atxt{1}:=Arr_ItemNos{$i}+" - "+Arr_ItemDesc{$i}
				Else 
					If (Arr_ItemNos{$i}#Arr_ItemNos{$i-1})
						INSERT IN ARRAY:C227(WKHR_ItemsList_atxt; (Size of array:C274(WKHR_ItemsList_atxt)+1); 1)
						WKHR_ItemsList_atxt{Size of array:C274(WKHR_ItemsList_atxt)}:=Arr_ItemNos{$i}+" - "+Arr_ItemDesc{$i}
					End if 
				End if 
			End for 
			WKHR_ItemsList_atxt:=Find in array:C230(WKHR_ItemsList_atxt; (Arr_ItemNos{Arr_ItemNos}+"@"))
			WKHR_LoadLineItem($itemIndex; "LOAD")
			
			C_BOOLEAN:C305(WKHR_DataEntered_B)
			WKHR_DataEntered_B:=False:C215
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Work_Estimate:103]; "LineEntry"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			//$tempwin:=Open form window([Work_Estimate];"LineEntry")
			DIALOG:C40([Work_Estimate:103]; "LineEntry")
			CLOSE WINDOW:C154($Win_l)
			If (OK=1)
				$itemIndex:=Find in array:C230(arrPtr_1->; Line_ItemNo)
				WKHR_LoadLineItem($itemIndex; "SAVE")
				//force validate event to kick in
				If (WKHR_DataEntered_B)
					[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6
				End if 
				//Refresh displayed variables / arrays 
			End if 
			WKHR_RecalcPage2
			WKHR_LoadItemHRs
			C_LONGINT:C283($RowIndex)
			$RowIndex:=Find in array:C230(Arr_ItemNos; arrPtr_1->{$itemIndex})
			$RowIndex:=Find in array:C230(Arr_ItemNos; Line_ItemNo)
			WKHR_SetListRow($RowIndex)
			REDRAW WINDOW:C456
		End if 
	: ($FormEvent_L=On Clicked:K2:4)
		QUERY:C277([WorkHour_Summary:105]; [WorkHour_Summary:105]ProjType:1=[Contract_Assignment_Maintenance:101]ProjectType:36; *)
		QUERY:C277([WorkHour_Summary:105];  & ; [WorkHour_Summary:105]ItemID:2=Num:C11(Arr_ItemNos{Arr_ItemNos}))
		If (Records in selection:C76([WorkHour_Summary:105])=1)
			wkhr_ItmAvg_1:=[WorkHour_Summary:105]AvgCol1:3
			wkhr_ItmAvg_2:=[WorkHour_Summary:105]AvgCol2:4
			wkhr_ItmAvg_3:=[WorkHour_Summary:105]AvgCol3:5
			wkhr_ItmAvg_4:=[WorkHour_Summary:105]AvgCol4:6
			wkhr_ItmAvg_5:=[WorkHour_Summary:105]AvgCol5:7
			wkhr_ItmAvg_6:=[WorkHour_Summary:105]AvgSum:8
		Else 
			wkhr_ItmAvg_1:=0
			wkhr_ItmAvg_2:=0
			wkhr_ItmAvg_3:=0
			wkhr_ItmAvg_4:=0
			wkhr_ItmAvg_5:=0
			wkhr_ItmAvg_6:=0
		End if 
		
End case 
Line_ItemNo:=""
LineDesc_Text:=""
ItemCmmts_Txt:=""