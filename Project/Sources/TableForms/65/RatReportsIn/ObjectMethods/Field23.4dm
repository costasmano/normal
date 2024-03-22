
If (False:C215)
	//[RatingReports];"RatReportsIn".Field23
	
End if 
PushChange(2; Self:C308)
If ([RatingReports:65]RecSinglePosting_L:39>0)
	If ([RatingReports:65]RecPostingH:14>0)
		[RatingReports:65]RecPostingH:14:=0
		PushChange(2; ->[RatingReports:65]RecPostingH:14)
	End if 
	If ([RatingReports:65]RecPost3:15>0)
		[RatingReports:65]RecPost3:15:=0
		PushChange(2; ->[RatingReports:65]RecPost3:15)
	End if 
	If ([RatingReports:65]RecPost3S2:16>0)
		[RatingReports:65]RecPost3S2:16:=0
		PushChange(2; ->[RatingReports:65]RecPost3S2:16)
	End if 
	
	
End if 