If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/16/10, 11:34:56
	// ----------------------------------------------------
	// Method: Object Method: SIA_QSelByFormula
	// Description
	//  ` Do A query selection by Formula
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_11
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		CREATE SET:C116(Current form table:C627->; "PREQUESELEFORMSET")
		
		QUERY SELECTION BY FORMULA:C207(Current form table:C627->)
		If (OK=1)
			If (Records in selection:C76(Current form table:C627->)=0)
				ALERT:C41("NO RECORDS FOUND FROM SEARCH CRITERIA!!")
			Else 
				CREATE SET:C116(Current form table:C627->; "QUESELEFORMSET")
				INTERSECTION:C121("PREQUESELEFORMSET"; "QUESELEFORMSET"; "PREQUESELEFORMSET")
				USE SET:C118("PREQUESELEFORMSET")
				CLEAR SET:C117("QUESELEFORMSET")
				C_TEXT:C284(GEN_SORTLISTCMD_txt)
				If (GEN_SORTLISTCMD_txt#"")
					EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
				End if 
				
				WindowTitle
				
			End if 
			
		End if 
		
		CLEAR SET:C117("PREQUESELEFORMSET")
End case 