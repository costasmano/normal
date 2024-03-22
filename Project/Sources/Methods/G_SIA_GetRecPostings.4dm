//%attributes = {"invisible":true}
//G_SIA_GetRecPostings
//Purpose:
//Get the Recommended Postings from [RatingReports] table for
//current SIA [Bridge MHD NBIS] record. Same as G_GetSIARecPosting, BUT
//without passing parameters.
If (False:C215)
	
	Mods_2005_CM05
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 
READ ONLY:C145([RatingReports:65])
QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
REDUCE SELECTION:C351([RatingReports:65]; 1)

C_LONGINT:C283(vRecPostingH; vRecPost3; vRecPost3S2; vREcPostSingle)  // **replaced _ o _C_INTEGER()

If (([Bridge MHD NBIS:1]PostingStatus:8="DESIGN") | ([Bridge MHD NBIS:1]PostingStatus:8="CLOSED"))
	vRecPostingH:=0
	vRecPost3:=0
	vRecPost3S2:=0
	vREcPostSingle:=0
Else 
	vREcPostSingle:=0
	vRecPostingH:=0
	vRecPost3:=0
	vRecPost3S2:=0
	If ([RatingReports:65]RecSinglePosting_L:39>0)
		vREcPostSingle:=[RatingReports:65]RecSinglePosting_L:39
	Else 
		vRecPostingH:=[RatingReports:65]RecPostingH:14
		vRecPost3:=[RatingReports:65]RecPost3:15
		vRecPost3S2:=[RatingReports:65]RecPost3S2:16
		If ([RatingReports:65]RecSinglePosting_L:39>0)
			vREcPostSingle:=[RatingReports:65]RecSinglePosting_L:39
		Else 
			If ((vRecPostingH=vRecPost3) & (vRecPost3=vRecPost3S2))
				vREcPostSingle:=vRecPostingH
			End if 
		End if 
	End if 
End if 
READ WRITE:C146([RatingReports:65])