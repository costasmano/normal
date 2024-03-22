//%attributes = {"invisible":true}
//G_InspGetRatings 
// retrieve recommended posting values from [RatingReports] to [inspections]
//$1 : Show alert - true/ false

If (False:C215)
	//Created Aug-2003
	
	Mods_2004_CM05
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(11/3/2005 14:21:53)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/28/07 10:26:00)
	Mods_2007_CM_5401
	Mods_2011_06  // CJ Miller`06/13/11, 16:58:00      ` Type all local variables for v11
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/23/18 12:49:39)
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 
C_BOOLEAN:C305($1; $vbShowAlert)
If (Count parameters:C259=1)
	$vbShowAlert:=$1
Else 
	$vbShowAlert:=True:C214
End if 
C_BOOLEAN:C305($vbGetRating)
$vbGetRating:=False:C215
READ ONLY:C145([RatingReports:65])
QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Inspections:27]BIN:1)
If (Records in selection:C76([RatingReports:65])>0)
	ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
	
	FIRST RECORD:C50([RatingReports:65])
	C_LONGINT:C283($vlYrRated; $vlYrBlt; $vlYrReBuilt)
	$vlYrRated:=Year of:C25([RatingReports:65]ReportDate:4)
	C_LONGINT:C283($vlYrBuilt)
	$vlYrBuilt:=[Bridge MHD NBIS:1]Item27:83
	$vlYrReBuilt:=[Bridge MHD NBIS:1]Item106:84
	If ($vlYrReBuilt#0)
		$vlYrBuilt:=$vlYrReBuilt
	End if 
	If ($vlYrRated>=$vlYrBuilt)
		$vbGetRating:=True:C214
	End if 
End if 

If ($vbGetRating)
	[Inspections:27]Rating Report:73:=True:C214
	[Inspections:27]Rating Date:74:=[RatingReports:65]ReportDate:4
	If ([Bridge MHD NBIS:1]PostingStatus:8="POSTED")  //check to see what is in the NBI table
		[Inspections:27]WeightPosting:30:=True:C214
		CBWeightPos:=0
		[Inspections:27]RecomPostingH:31:=[RatingReports:65]RecPostingH:14
		[Inspections:27]RecomPosting3:32:=[RatingReports:65]RecPost3:15
		[Inspections:27]RecomPosting3S2:33:=[RatingReports:65]RecPost3S2:16
		If ([RatingReports:65]RecSinglePosting_L:39>0)
			[Inspections:27]RecomPostingSgl:34:=[RatingReports:65]RecSinglePosting_L:39
		Else 
			If (([RatingReports:65]RecPostingH:14=[RatingReports:65]RecPost3:15) & ([RatingReports:65]RecPost3:15=[RatingReports:65]RecPost3S2:16))
				[Inspections:27]RecomPostingSgl:34:=[Inspections:27]RecomPostingH:31
			Else 
				[Inspections:27]RecomPostingSgl:34:=0
			End if 
		End if 
	Else 
		If ($vbShowAlert)
			ALERT:C41("Posting Status is NOT Posted in SI&A")
		End if 
		If ([Bridge MHD NBIS:1]PostingStatus:8="EJDMNT")  //check to see what is in the NBI table
			[Inspections:27]WeightPosting:30:=False:C215
			CBWeightPos:=0
			[Inspections:27]EDJMT Date:36:=[Bridge MHD NBIS:1]PostingDate:7
		End if 
		If ([Bridge MHD NBIS:1]PostingStatus:8="WAIVED")
			[Inspections:27]WeightPosting:30:=False:C215
			CBWeightPos:=0
			[Inspections:27]WaivedDate:35:=[Bridge MHD NBIS:1]PostingDate:7
		End if 
	End if 
	C_DATE:C307(<>InspFormRevDate_4)
	If ([Inspections:27]Insp Date:78><>InspFormRevDate_4)
		[Inspections:27]Item58_r:210:=[RatingReports:65]Item58:18
		[Inspections:27]Item59_r:211:=[RatingReports:65]Item59:19
	End if 
	
Else   //No valid rating report found....
	[Inspections:27]EDJMT Date:36:=!00-00-00!
	If ([Bridge MHD NBIS:1]PostingStatus:8="EDJMNT")  //check to see what is in the NBI table
		[Inspections:27]WeightPosting:30:=False:C215
		CBWeightPos:=0
		[Inspections:27]EDJMT Date:36:=[Bridge MHD NBIS:1]PostingDate:7
	End if 
	[Inspections:27]WaivedDate:35:=!00-00-00!
	If ([Bridge MHD NBIS:1]PostingStatus:8="WAIVED")  //check to see what is in the NBI table
		[Inspections:27]WeightPosting:30:=False:C215
		CBWeightPos:=0
		[Inspections:27]WaivedDate:35:=[Bridge MHD NBIS:1]PostingDate:7
	End if 
	[Inspections:27]Rating Report:73:=False:C215
	[Inspections:27]Rating Date:74:=!00-00-00!
	[Inspections:27]RecomPostingH:31:=0
	[Inspections:27]RecomPosting3:32:=0
	[Inspections:27]RecomPosting3S2:33:=0
	[Inspections:27]RecomPostingSgl:34:=0
End if 
PushChange(1; ->[Inspections:27]WeightPosting:30)
PushChange(1; ->[Inspections:27]Rating Report:73)
PushChange(1; ->[Inspections:27]Rating Date:74)
PushChange(1; ->[Inspections:27]RecomPostingH:31)
PushChange(1; ->[Inspections:27]RecomPosting3:32)
PushChange(1; ->[Inspections:27]RecomPosting3S2:33)
PushChange(1; ->[Inspections:27]RecomPostingSgl:34)
PushChange(1; ->[Inspections:27]EDJMT Date:36)
PushChange(1; ->[Inspections:27]WaivedDate:35)
PushChange(1; ->[Inspections:27]Item58_r:210)
PushChange(1; ->[Inspections:27]Item59_r:211)