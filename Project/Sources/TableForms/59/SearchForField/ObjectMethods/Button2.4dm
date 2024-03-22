If (ARCHSRC_TBL_L>0)
	C_LONGINT:C283($FldNum_L)
	$FldNum_L:=ut_SelectFieldNum(ARCHSRC_TBL_L)
	If (OK=1)
		ARCHSRC_FLD_L:=$FldNum_L
		ARCHSRC_FLD_txt:=String:C10(ARCHSRC_FLD_L; "[###] ")+Field name:C257(ARCHSRC_TBL_L; ARCHSRC_FLD_L)
		If ((ARCHSRC_FLD_L#0) & (ARCHSRC_TBL_L#0))
			OBJECT SET ENABLED:C1123(Findbtn; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
	End if 
End if 
