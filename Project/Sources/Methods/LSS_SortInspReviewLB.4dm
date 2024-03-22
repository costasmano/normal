//%attributes = {"invisible":true}
//Method: LSS_SortInspReviewLB
//  `Description
//  ` do sorting on the insp review list box
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/16, 14:14:56
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
	
	C_LONGINT:C283(LSS_SortInspReviewLB; $0)
	
End if 
//
C_LONGINT:C283($0)

C_TEXT:C284($NameofObj_txt)
C_LONGINT:C283($dumTbl_L; $dumFld_L)
RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)

Case of 
	: ($nameofObj_txt="Header1")
		//by structure num
		If ((Header1=0) | (Header1=2))
			Header1:=1
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)
		Else 
			Header1:=2
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inventory:165]LSS_StructureNumber_s:6; <)
		End if 
		//Header1:=0
		Header2:=0
		Header3:=0
		Header4:=0
		Header5:=0
		Header6:=0
		Header7:=0
		$0:=-1  //pass -1 so sorting is not done automatically
	: ($nameofObj_txt="Header2")
		//category
		If (Header2=0) | (Header2=2)
			Header2:=1
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inventory:165]LSS_Category_s:2; >)
		Else 
			Header2:=2
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inventory:165]LSS_Category_s:2; <)
		End if 
		Header1:=0
		//Header2:=0
		Header3:=0
		Header4:=0
		Header5:=0
		Header6:=0
		Header7:=0
		$0:=-1  //pass -1 so sorting is not done automatically
	: ($nameofObj_txt="Header3")
		//insp date
		Header1:=0
		Header2:=0
		//Header3:=0
		Header4:=0
		Header5:=0
		Header6:=0
		Header7:=0
		
	: ($nameofObj_txt="Header4")  //
		//Insp type
		ARRAY LONGINT:C221($RecNums_aL; Records in selection:C76([LSS_Inspection:164]))
		ARRAY TEXT:C222($InspTYpeCodes_atxt; Records in selection:C76([LSS_Inspection:164]))
		ARRAY TEXT:C222($InspTypes_atxt; Records in selection:C76([LSS_Inspection:164]))
		
		SELECTION TO ARRAY:C260([LSS_Inspection:164]; $RecNums_aL; [LSS_Inspection:164]LSS_InspectionTypeId_s:3; $InspTYpeCodes_atxt)
		
		ALL RECORDS:C47([LSS_refInspectionType:167])
		ARRAY TEXT:C222($RefCodes_atxt; 0)
		ARRAY TEXT:C222($RefNames_atxt; 0)
		SELECTION TO ARRAY:C260([LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; $RefCodes_atxt; [LSS_refInspectionType:167]LSS_Description_txt:2; $RefNames_atxt)
		C_LONGINT:C283($loop_L; $indx_L)
		For ($loop_L; 1; Size of array:C274($InspTYpeCodes_atxt))
			$indx_L:=Find in array:C230($RefCodes_atxt; $InspTYpeCodes_atxt{$loop_L})
			If ($indx_L>0)
				$InspTypes_atxt{$loop_L}:=$RefNames_atxt{$indx_L}
			Else 
				$InspTypes_atxt{$loop_L}:=""
			End if 
			
		End for 
		
		If (Header4=0) | (Header4=2)
			Header4:=1
			SORT ARRAY:C229($InspTypes_atxt; $RecNums_aL; >)
			CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; $RecNums_aL)
		Else 
			Header4:=2
			SORT ARRAY:C229($InspTypes_atxt; $RecNums_aL; <)
			CREATE SELECTION FROM ARRAY:C640([LSS_Inspection:164]; $RecNums_aL)
		End if 
		Header1:=0
		Header2:=0
		Header3:=0
		//Header4:=0
		Header5:=0
		Header6:=0
		Header7:=0
		$0:=-1  //pass -1 so sorting is not done automatically
	: ($nameofObj_txt="Header5")
		//agency
		Header1:=0
		Header2:=0
		Header3:=0
		Header4:=0
		//Header5:=0
		Header6:=0
		Header7:=0
		
	: ($nameofObj_txt="Header6")
		//complete
		If (Header6=0) | (Header6=2)
			Header6:=1
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39; >)
		Else 
			Header6:=2
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39; <)
		End if 
		Header1:=0
		Header2:=0
		Header3:=0
		Header4:=0
		Header5:=0
		//Header6:=0
		Header7:=0
		$0:=-1  //pass -1 so sorting is not done automatically
	: ($nameofObj_txt="Header7")
		//approval
		If (Header7=0) | (Header7=2)
			Header7:=1
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43; >)
		Else 
			Header7:=2
			ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43; <)
		End if 
		Header1:=0
		Header2:=0
		Header3:=0
		Header4:=0
		Header5:=0
		Header6:=0
		//Header7:=0
		$0:=-1  //pass -1 so sorting is not done automatically
		
End case 

//End LSS_SortInspReviewLB