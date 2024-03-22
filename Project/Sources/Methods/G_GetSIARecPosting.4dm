//%attributes = {"invisible":true}
//G_GetSIARecPosting
//Retrieve recommended posting values.
//Parameters $1,$2,$3 pointers to process Integer vars for
//Rec posting H, 3, 3S2
//Usage :
//G_GetSIARecPosting(->postH;->post3;->post3S2)
If (False:C215)
	
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(4/20/2006 12:48:31)
	Mods_2006_CM04
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($viRecPostH; $viRecPost3; $viRecPost3S2)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
$viRecPostH:=0
$viRecPost3:=0
$viRecPost3S2:=0

If (([Bridge MHD NBIS:1]PostingStatus:8#"DESIGN") & ([Bridge MHD NBIS:1]PostingStatus:8#"CLOSED"))
	READ ONLY:C145([RatingReports:65])
	QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	If (Records in selection:C76([RatingReports:65])>0)
		ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
		
		REDUCE SELECTION:C351([RatingReports:65]; 1)
		$viRecPostH:=[RatingReports:65]RecPostingH:14
		$viRecPost3:=[RatingReports:65]RecPost3:15
		$viRecPost3S2:=[RatingReports:65]RecPost3S2:16
	End if 
	READ WRITE:C146([RatingReports:65])
End if 

$1->:=$viRecPostH
$2->:=$viRecPost3
$3->:=$viRecPost3S2