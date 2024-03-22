If (False:C215)
	
End if 

C_TEXT:C284($Confirm_txt; $Remainder_txt)
ARRAY LONGINT:C221($Counts_AL; 0)
ARRAY TEXT:C222($Tables_atxt; 0)
C_LONGINT:C283($Count_L)
If (FORM Get current page:C276=1)
	
	If (([TIN_Inspections:184]InspApproval:6#BMS Not Reviewed) | ([TIN_Inspections:184]InspReview:5#BMS Not Reviewed))
		$Confirm_txt:="Do you "+Current user:C182+" really want to delete this Inspection record, "
		$Confirm_txt:=$Confirm_txt+"which is in the Review process,"
	Else 
		$Confirm_txt:="Do you "+Current user:C182+" really want to delete this inspection record "
	End if 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: ($Count_L>1)
			$Remainder_txt:=" its "+String:C10($Count_L)+" elements"
		: ($Count_L=1)
			$Remainder_txt:=" its element "
		Else 
			
	End case 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	QUERY:C277([TIN_Insp_Images:186]; [TIN_Insp_Images:186]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: ($Count_L>1)
			If ($Remainder_txt="")
				$Remainder_txt:=" its "+String:C10($Count_L)+" photo"
			Else 
				$Remainder_txt:=$Remainder_txt+" and its "+String:C10($Count_L)+" photos"
			End if 
		: ($Count_L=1)
			If ($Remainder_txt="")
				$Remainder_txt:="its "+String:C10($Count_L)+" photo"
			Else 
				$Remainder_txt:=$Remainder_txt+" and its photos"
			End if 
			
		Else 
			
	End case 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: ($Count_L>1)
			If ($Remainder_txt="")
				$Remainder_txt:=" its "+String:C10($Count_L)+" comments"
			Else 
				$Remainder_txt:=$Remainder_txt+" and its "+String:C10($Count_L)+" comments"
			End if 
		: ($Count_L=1)
			If ($Remainder_txt="")
				$Remainder_txt:="its "+String:C10($Count_L)+" comment"
			Else 
				$Remainder_txt:=$Remainder_txt+" and its comment"
			End if 
			
		Else 
			
	End case 
	
	CONFIRM:C162($Confirm_txt+$Remainder_txt+" ?"; "DELETE"; "Skip")
	If (OK=1)
		C_LONGINT:C283($passwordErr_L)
		$Confirm_txt:="! ! ! WARNING : To Delete the entire Inspection, your password is required ! ! !"+<>sCR+"Enter your password to Delete the entire inspection or Cancel to abort the deleti"+"on!!"
		$Confirm_txt:=Uppercase:C13($Confirm_txt)
		$passwordErr_L:=OP_GetPassword($Confirm_txt)
		
		If ($passwordErr_L=0)
			ONE RECORD SELECT:C189([TIN_Inspections:184])
			LogDeletion(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
			C_BOOLEAN:C305($Skip_B)
			
			C_LONGINT:C283($Count_L)
			$Count_L:=1
			C_TEXT:C284($ConfirmMessage_txt)
			
			$ConfirmMessage_txt:="There are some locked records associated with this inspection do you want to try again?"
			
			Repeat 
				DELETE SELECTION:C66([TIN_Inspections:184])
				If (Records in set:C195("LockedSet")>0)
					If ($Count_L=1)
						CONFIRM:C162($ConfirmMessage_txt; "Yes"; "No")
						If (OK=1)
							$Count_L:=$Count_L+1
						Else 
							$Skip_B:=True:C214
						End if 
						
					End if 
					$Count_L:=$Count_L+1
					If ($Count_L=11) & (Not:C34($Skip_B))
						$ConfirmMessage_txt:="There are still some locked records associated with this inspection do you want to try again?"
						$Count_L:=1
					End if 
					If (Not:C34($Skip_B))
						DELAY PROCESS:C323(Current process:C322; 30)
					End if 
				End if 
			Until (Records in set:C195("LockedSet")=0) | ($Skip_B)
			
			If ($Skip_B)
				CANCEL TRANSACTION:C241
				ALERT:C41("Inspection record not deleted")
			Else 
				VALIDATE TRANSACTION:C240
			End if 
			CANCEL:C270
		End if 
		
	End if 
Else 
	ALERT:C41("Must be on the 1st Tab of the input form to delete this inspection report!")
End if 
