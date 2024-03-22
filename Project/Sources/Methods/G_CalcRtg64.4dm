//%attributes = {"invisible":true}
If (False:C215)
	//G_CalcRtg64
End if 

C_REAL:C285($max; $vrItem64)

Case of 
	: ([RatingReports:65]OprMS18:23#0)
		[RatingReports:65]Item64:29:=[RatingReports:65]OprMS18:23
		[RatingReports:65]Item63:28:="1"
		PushChange(2; ->[RatingReports:65]Item64:29)
		PushChange(2; ->[RatingReports:65]Item63:28)
	: ([RatingReports:65]OprHS2044:13#0)
		[RatingReports:65]Item64:29:=[RatingReports:65]OprHS2044:13*0.9
		[RatingReports:65]Item63:28:="2"
		PushChange(2; ->[RatingReports:65]Item64:29)
		PushChange(2; ->[RatingReports:65]Item63:28)
	: (([RatingReports:65]OprHS2044:13=0) & ([RatingReports:65]OprMS18:23=0))
		$max:=MaxNum([RatingReports:65]OprH20:10; [RatingReports:65]OprType3:11; [RatingReports:65]Opr3S2:12)
		Case of 
			: ($max=[RatingReports:65]OprH20:10)
				[RatingReports:65]Item64:29:=$max*1.25*0.9
			: ($max=[RatingReports:65]OprType3:11)
				[RatingReports:65]Item64:29:=$max*1*0.9
			: ($max=[RatingReports:65]Opr3S2:12)
				[RatingReports:65]Item64:29:=$max*0.7*0.9
		End case 
		[RatingReports:65]Item63:28:="2"
		PushChange(2; ->[RatingReports:65]Item64:29)
		PushChange(2; ->[RatingReports:65]Item63:28)
End case 