//%attributes = {"invisible":true}
If (False:C215)
	//G_CalcRtg66
End if 

C_REAL:C285($max; $vrItem66)

Case of 
	: ([RatingReports:65]InvMS18:22#0)
		[RatingReports:65]Item66:31:=[RatingReports:65]InvMS18:22
		[RatingReports:65]Item65:30:="1"
		PushChange(2; ->[RatingReports:65]Item66:31)
		PushChange(2; ->[RatingReports:65]Item65:30)
	: ([RatingReports:65]InvHS2044:9#0)
		[RatingReports:65]Item66:31:=[RatingReports:65]InvHS2044:9*0.9
		[RatingReports:65]Item65:30:="2"
		PushChange(2; ->[RatingReports:65]Item66:31)
		PushChange(2; ->[RatingReports:65]Item65:30)
	: (([RatingReports:65]InvHS2044:9=0) & ([RatingReports:65]InvMS18:22=0))
		$max:=MaxNum([RatingReports:65]InvH20:6; [RatingReports:65]InvType3:7; [RatingReports:65]Inv3S2:8)
		Case of 
			: ($max=[RatingReports:65]InvH20:6)
				[RatingReports:65]Item66:31:=$max*1.25*0.9
			: ($max=[RatingReports:65]InvType3:7)
				[RatingReports:65]Item66:31:=$max*1*0.9
			: ($max=[RatingReports:65]Inv3S2:8)
				[RatingReports:65]Item66:31:=$max*0.7*0.9
		End case 
		[RatingReports:65]Item65:30:="2"
		PushChange(2; ->[RatingReports:65]Item66:31)
		PushChange(2; ->[RatingReports:65]Item65:30)
End case 