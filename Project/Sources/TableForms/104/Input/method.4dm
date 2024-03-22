If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/05, 17:53:32
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 16:33:20)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(12/8/2005 12:03:54)
	Mods_2005_CM20
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BLOB:C604($RestrictedList_Blob)
		$RestrictedList_Blob:=[WorkHour_Config:104]ConfigArrays:1
		ARRAY INTEGER:C220(Arr_WKHR_RestrictedItems_I; 0)
		ARRAY INTEGER:C220(Arr_WKHR_RestrictedSubItms_I; 0)
		
		If (BLOB size:C605($RestrictedList_Blob)>0)
			C_LONGINT:C283($v_compressed_i)  //Command Replaced was o_C_INTEGER
			BLOB PROPERTIES:C536($RestrictedList_Blob; $v_compressed_i)
			If ($v_compressed_i#0)
				EXPAND BLOB:C535($RestrictedList_Blob)
			End if 
			C_LONGINT:C283($offset)
			$offset:=0
			BLOB TO VARIABLE:C533($RestrictedList_Blob; Arr_WKHR_RestrictedItems_I; $offset)
			BLOB TO VARIABLE:C533($RestrictedList_Blob; Arr_WKHR_RestrictedSubItms_I; $offset)
		Else 
			
		End if 
		SET BLOB SIZE:C606($RestrictedList_Blob; 0)
		
		C_LONGINT:C283(AllCategories_HL)  //check to see if all arrays are initialized
		If (Not:C34(Is a list:C621(AllCategories_HL)))
			WKHR_InitConfigArrays
		End if 
		ARRAY TEXT:C222(WorkCFG_Type; 0)  //Command Replaced was o_ARRAY string length was 80
		ARRAY TEXT:C222(WorkCFG_CopyFromType; 0)  //Command Replaced was o_ARRAY string length was 80
		LIST TO ARRAY:C288("CM_AssgnmntType_List"; WorkCFG_Type)
		LIST TO ARRAY:C288("CM_AssgnmntType_List"; WorkCFG_CopyFromType)
		POPUP(->WorkCFG_Type; ->[WorkHour_Config:104]AssignType:2; 0; False:C215)
		C_LONGINT:C283($NumTypes; $i; TypeExistCount)
		$NumTypes:=Size of array:C274(WorkCFG_CopyFromType)
		For ($i; $NumTypes; 1; -1)
			SET QUERY DESTINATION:C396(Into variable:K19:4; TypeExistCount)
			QUERY:C277([WorkHour_Config:104]; [WorkHour_Config:104]AssignType:2=WorkCFG_CopyFromType{$i})
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			Case of 
				: (WorkCFG_CopyFromType{$i}=[WorkHour_Config:104]AssignType:2)
					DELETE FROM ARRAY:C228(WorkCFG_CopyFromType; $i)
				: (TypeExistCount=0)
					DELETE FROM ARRAY:C228(WorkCFG_CopyFromType; $i)
			End case 
			
		End for 
		//insert a blank one
		INSERT IN ARRAY:C227(WorkCFG_CopyFromType; 1; 1)
		WorkCFG_CopyFromType{1}:=""
End case 
