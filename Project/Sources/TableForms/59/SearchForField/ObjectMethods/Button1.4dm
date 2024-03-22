C_LONGINT:C283($TableNm_L)
$TableNm_L:=ut_SelectTableNum
If (OK=1)
	If ($TableNm_L>0)
		OBJECT SET ENABLED:C1123(FldBtn; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		If ($TableNm_L#ARCHSRC_TBL_L)
			ARCHSRC_FLD_L:=0
			ARCHSRC_FLD_txt:=""
			ARCHSRC_TBL_L:=$TableNm_L
			ARCHSRC_TBL_txt:=String:C10(ARCHSRC_TBL_L; "[###] ")+Table name:C256(ARCHSRC_TBL_L)
		End if 
		
	End if 
	If ((ARCHSRC_FLD_L#0) & (ARCHSRC_TBL_L#0))
		OBJECT SET ENABLED:C1123(Findbtn; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	End if 
	
End if 
