If (Records in set:C195("Userset")>0)
	CONFIRM:C162("Are you sure you want to delete the selected "+String:C10(Records in set:C195("Userset"))+" records?")
	If (OK=1)
		
		InitGrpDelete
		ARRAY LONGINT:C221($IDSLeft_al; 0)
		
		FIRST RECORD:C50([LB_QueryTable:147])
		While (Not:C34(End selection:C36([LB_QueryTable:147])))
			
			If (Is in set:C273("UserSet"))
				PushGrpDelete(->[LB_QueryTable:147]UniqueKey_l:6)
			Else 
				APPEND TO ARRAY:C911($IDSLeft_al; Record number:C243([LB_QueryTable:147]))
			End if 
			NEXT RECORD:C51([LB_QueryTable:147])
		End while 
		
		USE SET:C118("Userset")
		FlushGrpDeletions(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
		DELETE SELECTION:C66([LB_QueryTable:147])
		If (Size of array:C274($IDSLeft_al)>0)
			CREATE SELECTION FROM ARRAY:C640([LB_QueryTable:147]; $IDSLeft_al)
		Else 
			REDUCE SELECTION:C351([LB_QueryTable:147]; 0)
		End if 
	End if 
	
Else 
	ALERT:C41("You must select some records to delete!")
End if 