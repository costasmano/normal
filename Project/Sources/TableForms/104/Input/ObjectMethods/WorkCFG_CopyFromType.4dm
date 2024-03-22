If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/8/2005 12:05:46)
	Mods_2005_CM20
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (WorkCFG_CopyFromType{WorkCFG_CopyFromType}#"")
			PUSH RECORD:C176([WorkHour_Config:104])
			QUERY:C277([WorkHour_Config:104]; [WorkHour_Config:104]AssignType:2=WorkCFG_CopyFromType{WorkCFG_CopyFromType})
			C_BLOB:C604($RestrictedList_Blob)
			$RestrictedList_Blob:=[WorkHour_Config:104]ConfigArrays:1
			POP RECORD:C177([WorkHour_Config:104])
			[WorkHour_Config:104]ConfigArrays:1:=$RestrictedList_Blob
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
		End if 
End case 