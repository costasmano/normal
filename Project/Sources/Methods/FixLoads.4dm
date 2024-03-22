//%attributes = {"invisible":true}
If (False:C215)
	//procedure: FixLoads
	//purpose: init 63-66,loads based on rating reports
	//created: 4/2/98
	//by: Albert Leung
End if 

C_LONGINT:C283($i; $numrec; $n)
C_REAL:C285($max)

If (False:C215)  // don't do this again
	
	ALL RECORDS:C47([RatingReports:65])  //Fix these first
	$numrec:=Records in selection:C76([RatingReports:65])
	FIRST RECORD:C50([RatingReports:65])
	For ($i; 1; $numrec)
		If ([RatingReports:65]Item64:29=0)
			Case of 
				: ([RatingReports:65]OprMS18:23#0)
					[RatingReports:65]Item64:29:=[RatingReports:65]OprMS18:23
					[RatingReports:65]Item63:28:="1"
				: ([RatingReports:65]OprHS2044:13#0)
					[RatingReports:65]Item64:29:=[RatingReports:65]OprHS2044:13*0.9
					[RatingReports:65]Item63:28:="2"
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
			End case 
		End if 
		If ([RatingReports:65]Item66:31=0)
			Case of 
				: ([RatingReports:65]InvMS18:22#0)
					[RatingReports:65]Item66:31:=[RatingReports:65]InvMS18:22
					[RatingReports:65]Item65:30:="1"
				: ([RatingReports:65]InvHS2044:9#0)
					[RatingReports:65]Item66:31:=[RatingReports:65]InvHS2044:9*0.9
					[RatingReports:65]Item65:30:="2"
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
			End case 
		End if 
		SAVE RECORD:C53([RatingReports:65])
		NEXT RECORD:C51([RatingReports:65])
	End for 
End if 

If (False:C215)  //Don't do this again
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	$numrec:=Records in selection:C76([Bridge MHD NBIS:1])
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	For ($i; 1; $numrec)
		RELATE MANY:C262([Bridge MHD NBIS:1])
		$n:=Records in selection:C76([RatingReports:65])
		If ($n>0)
			ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <)  //Get the latest
			If ([RatingReports:65]RatingReport:2=False:C215)
				[Bridge MHD NBIS:1]OprH20:15:=Round:C94([RatingReports:65]OprH20:10; 0)
				[Bridge MHD NBIS:1]OprType3:16:=Round:C94([RatingReports:65]OprType3:11; 0)
				[Bridge MHD NBIS:1]Opr3S2:17:=Round:C94([RatingReports:65]Opr3S2:12; 0)
				[Bridge MHD NBIS:1]OprHS:18:=Round:C94([RatingReports:65]OprHS2044:13; 0)
				[Bridge MHD NBIS:1]OprMS:204:=Round:C94([RatingReports:65]OprMS18:23; 0)
				[Bridge MHD NBIS:1]InvH20:19:=Round:C94([RatingReports:65]InvH20:6; 0)
				[Bridge MHD NBIS:1]InvType3:20:=Round:C94([RatingReports:65]InvType3:7; 0)
				[Bridge MHD NBIS:1]Inv3S2:21:=Round:C94([RatingReports:65]Inv3S2:8; 0)
				[Bridge MHD NBIS:1]InvHS:22:=Round:C94([RatingReports:65]InvHS2044:9; 0)
				[Bridge MHD NBIS:1]InvMS:203:=Round:C94([RatingReports:65]InvMS18:22; 0)
				[Bridge MHD NBIS:1]Item64:137:=[RatingReports:65]Item64:29
				[Bridge MHD NBIS:1]Item66:139:=[RatingReports:65]Item66:31
				[Bridge MHD NBIS:1]Item 63:199:=[RatingReports:65]Item63:28
				[Bridge MHD NBIS:1]Item 65:200:=[RatingReports:65]Item65:30
				SAVE RECORD:C53([Bridge MHD NBIS:1])
			End if 
		End if 
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End for 
End if 

ALL RECORDS:C47([Bridge MHD NBIS:1])
$numrec:=Records in selection:C76([Bridge MHD NBIS:1])
FIRST RECORD:C50([Bridge MHD NBIS:1])
For ($i; 1; $numrec)
	If ([Bridge MHD NBIS:1]OprH20:15>99)
		[Bridge MHD NBIS:1]OprH20:15:=99
	End if 
	If ([Bridge MHD NBIS:1]OprType3:16>99)
		[Bridge MHD NBIS:1]OprType3:16:=99
	End if 
	If ([Bridge MHD NBIS:1]Opr3S2:17>99)
		[Bridge MHD NBIS:1]Opr3S2:17:=99
	End if 
	If ([Bridge MHD NBIS:1]OprHS:18>99)
		[Bridge MHD NBIS:1]OprHS:18:=99
	End if 
	If ([Bridge MHD NBIS:1]OprMS:204>99)
		[Bridge MHD NBIS:1]OprMS:204:=99
	End if 
	If ([Bridge MHD NBIS:1]InvH20:19>99)
		[Bridge MHD NBIS:1]InvH20:19:=99
	End if 
	If ([Bridge MHD NBIS:1]InvType3:20>99)
		[Bridge MHD NBIS:1]InvType3:20:=99
	End if 
	If ([Bridge MHD NBIS:1]Inv3S2:21>99)
		[Bridge MHD NBIS:1]Inv3S2:21:=99
	End if 
	If ([Bridge MHD NBIS:1]InvHS:22>99)
		[Bridge MHD NBIS:1]InvHS:22:=99
	End if 
	If ([Bridge MHD NBIS:1]InvMS:203>99)
		[Bridge MHD NBIS:1]InvMS:203:=99
	End if 
	SAVE RECORD:C53([Bridge MHD NBIS:1])
	NEXT RECORD:C51([Bridge MHD NBIS:1])
End for 