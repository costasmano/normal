//%attributes = {"invisible":true}
//GP M_PontisReports
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($Text)
C_LONGINT:C283($NoBridges; $i)

$NoBridges:=Records in selection:C76([Bridge MHD NBIS:1])
FIRST RECORD:C50([Bridge MHD NBIS:1])
Case of 
	: ($NoBridges=0)
		$Text:="You must select bridges to print.  Please try again."
		ALERT:C41($Text)
		ABORT:C156
	: ($NoBridges=1)
		$Text:="Print a Pontis BMS Element Inspection Report for BIN='"
		$Text:=$Text+[Bridge MHD NBIS:1]BIN:3+"'?"
	Else 
		$Text:="Print Pontis BMS Element Inspection Reports for "
		$Text:=$Text+String:C10($NoBridges; "#,###,###")+" bridges?"
End case 

CONFIRM:C162($Text)

If (OK=1)
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "Print Selection of Bridges")
	For ($i; 1; $NoBridges)
		RELATE MANY:C262([Bridge MHD NBIS:1]BIN:3)
		If (Records in selection:C76([BMS Inspections:44])=0)
			FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "Pontis blank")
			PRINT RECORD:C71([Bridge MHD NBIS:1]; *)
			FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "NBIS Stack Info")
		Else 
			//Print the latest inspection.      
			ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <)
			RELATE MANY:C262([BMS Inspections:44]Inspection ID:1)
			ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
			FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt")
			PRINT SELECTION:C60([Cond Units:45]; *)
			FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
		End if 
		
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End for 
	USE NAMED SELECTION:C332("Print Selection of Bridges")
	CLEAR NAMED SELECTION:C333("Print Selection of Bridges")
End if 