//%attributes = {"invisible":true}
//Procedure: CheckDependencies
//Purpose: checks differences between other reports and inspection report.
//Uses: [Dialogs];"DependencyCheck"
If (False:C215)
	//MHD Bridge Inspection
	//Created By: Albert Leung
	//Date:  7/10/2003
	
	
	Mods_2005_CM01
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(11/3/2005 14:21:31)
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(8/9/2007 14:31:28)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:44:51)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:17:53`Upgrade from open form window to open window
	// Modified by: Bridge Section-(Designer)-(10/26/18 10:30:08)
	Mods_2018_10
	//  `changes : field [RatingReports]RecSinglePosting_L was added 
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 

C_TEXT:C284(vtxtStructTypeInsp; vtxtStructTypeSIA; vtxtItem107Insp; vtxtItem107SIA)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtItem21Insp; vtxtItem21SIA; vtxtItem22Insp; vtxtItem22SIA)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtItem26Insp; vtxtItem26SIA; vtxtItem106Insp; vtxtItem106SIA)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtWeightPosting; vtxtWeightPostingInsp)  // **Replaced old C_STRING length 10
C_TEXT:C284(vItem43a_temp)  // **Replaced old C_STRING length 1
C_TEXT:C284(vItem43b_temp)  // **Replaced old C_STRING length 2
C_BOOLEAN:C305(vblnChkItem43; vblnChkItem107; vblnWeightPosting; vblnRatingReport; vblnRatingDate)
C_BOOLEAN:C305(vblnRecomPostingH; vblnRecomPosting3; vblnRecomPosting3S2; vblnRecomPostingSgl)
C_BOOLEAN:C305(vblnEDJMTDate; vblnWaivedDate; vblnChkItem21; vblnChkItem22; vblnChkItem26; vblnChkItem106)
C_BOOLEAN:C305($blnDoCheck)
C_TEXT:C284(vtxtRatingReportInsp; vtxtRatingReport)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtRatingDateInsp; vtxtRatingDate; vtxtRecomPostingHInsp; vtxtRecomPostingH)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtRecomPosting3Insp; vtxtRecomPosting3; vtxtRecomPosting3S2Insp; vtxtRecomPosting3S2)  // **Replaced old C_STRING length 255
C_TEXT:C284(vtxtRecomPostingSglInsp; vtxtRecomPostingSgl)  // **Replaced old C_STRING length 255

vtxtEDJMTDateInsp:=""
vtxtEDJMTDate:=""
vtxtWaivedDateInsp:=""
vtxtWaivedDate:=""
vtxtStructTypeInsp:=""
vtxtStructTypeSIA:=""
vtxtItem107Insp:=""
vtxtItem107SIA:=""
vtxtItem21Insp:=""
vtxtItem21SIA:=""
vtxtItem22Insp:=""
vtxtItem22SIA:=""
vtxtItem26Insp:=""
vtxtItem26SIA:=""
vtxtItem106Insp:=""
vtxtItem106SIA:=""
vtxtWeightPosting:=""
vtxtWeightPostingInsp:=""
vItem43a_temp:=""
vItem43b_temp:=""
vtxtRatingReportInsp:=""
vtxtRatingReport:=""
vtxtRatingDateInsp:=""
vtxtRatingDate:=""
vtxtRecomPostingHInsp:=""
vtxtRecomPostingH:=""
vtxtRecomPosting3Insp:=""
vtxtRecomPosting3:=""
vtxtRecomPosting3S2Insp:=""
vtxtRecomPosting3S2:=""
vtxtRecomPostingSglInsp:=""
vtxtRecomPostingSgl:=""

vItem43a_temp:=Substring:C12([Inspections:27]Item 43:140; 1; 1)
vItem43b_temp:=Substring:C12([Inspections:27]Item 43:140; 2; 2)
vtxtStructTypeInsp:=Get_Description(-><>aMaterial; -><>aMatCode; ->vItem43a_temp)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->vItem43b_temp)
vItem43a_temp:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
vItem43b_temp:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
vtxtStructTypeSIA:=Get_Description(-><>aMaterial; -><>aMatCode; ->vItem43a_temp)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->vItem43b_temp)
vtxtItem107Insp:=Get_Description(-><>aDeck; -><>aDeckCod; ->[Inspections:27]Item 107:141)
vtxtItem107SIA:=Get_Description(-><>aDeck; -><>aDeckCod; ->[Bridge MHD NBIS:1]Item107:79)
vtxtItem21Insp:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Inspections:27]Item21:166)
vtxtItem21SIA:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item21:127)
vtxtItem22Insp:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Inspections:27]Item22:197)
vtxtItem22SIA:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item22:128)
vtxtItem26Insp:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
vtxtItem26SIA:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Bridge MHD NBIS:1]Item26:120)
vtxtItem106Insp:=String:C10([Inspections:27]Item106:198; "0000")
vtxtItem106SIA:=String:C10([Bridge MHD NBIS:1]Item106:84; "0000")
vblnChkItem43:=([Inspections:27]Item 43:140#[Bridge MHD NBIS:1]Item43:75)
vblnChkItem107:=([Inspections:27]Item 107:141#[Bridge MHD NBIS:1]Item107:79)
vblnChkItem106:=([Inspections:27]Item106:198#[Bridge MHD NBIS:1]Item106:84)
vblnChkItem21:=([Inspections:27]Item21:166#[Bridge MHD NBIS:1]Item21:127)
vblnChkItem22:=([Inspections:27]Item22:197#[Bridge MHD NBIS:1]Item22:128)
vblnChkItem26:=([Inspections:27]Item26:200#[Bridge MHD NBIS:1]Item26:120)
//Check ratings
If ([Inspections:27]Rating Report:73)
	vtxtRatingReportInsp:="Rating report exists"
Else 
	vtxtRatingReportInsp:="No rating report available"
End if 
vtxtRatingDateInsp:=f_Date2String([Inspections:27]Rating Date:74; Internal date short:K1:7; "-")
If ([Inspections:27]WeightPosting:30)
	vtxtWeightPostingInsp:="True"
Else 
	vtxtWeightPostingInsp:="False"
End if 
vtxtRecomPostingHInsp:=String:C10([Inspections:27]RecomPostingH:31; "00")
vtxtRecomPosting3Insp:=String:C10([Inspections:27]RecomPosting3:32; "00")
vtxtRecomPosting3S2Insp:=String:C10([Inspections:27]RecomPosting3S2:33; "00")
vtxtRecomPostingSglInsp:=String:C10([Inspections:27]RecomPostingSgl:34; "00")
vtxtEDJMTDateInsp:=f_Date2String([Inspections:27]EDJMT Date:36; Internal date short:K1:7; "-")
vtxtWaivedDateInsp:=f_Date2String([Inspections:27]WaivedDate:35; Internal date short:K1:7; "-")
If ([Bridge MHD NBIS:1]PostingStatus:8="EJDMNT")
	vtxtEDJMTDate:=f_Date2String([Bridge MHD NBIS:1]PostingDate:7; Internal date short:K1:7; "-")
Else 
	vtxtEDJMTDate:="-"
End if 
If ([Bridge MHD NBIS:1]PostingStatus:8="WAIVED")
	vtxtWaivedDate:=f_Date2String([Bridge MHD NBIS:1]PostingDate:7; Internal date short:K1:7; "-")
Else 
	vtxtWaivedDate:="-"
End if 
vblnEDJMTDate:=(vtxtEDJMTDate#vtxtEDJMTDateInsp)
vblnWaivedDate:=(vtxtWaivedDate#vtxtWaivedDateInsp)
READ ONLY:C145([RatingReports:65])
QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Inspections:27]BIN:1)
C_LONGINT:C283($vlLastYr)  // **replaced _ o _C_INTEGER()
If ([Bridge MHD NBIS:1]Item106:84>0)
	$vlLastYr:=[Bridge MHD NBIS:1]Item106:84
Else 
	$vlLastYr:=[Bridge MHD NBIS:1]Item27:83
End if 
C_DATE:C307($vdLastDate)
$vdLastDate:=Date:C102("01/01/"+String:C10($vlLastYr; "0000"))
QUERY SELECTION:C341([RatingReports:65]; [RatingReports:65]ReportDate:4>=$vdLastDate)
If (Records in selection:C76([RatingReports:65])>0)
	vtxtRatingReport:="Rating report exists"
	ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
	
	FIRST RECORD:C50([RatingReports:65])
	vtxtRatingDate:=f_Date2String([RatingReports:65]ReportDate:4; Internal date short:K1:7; "-")
	vtxtRecomPostingH:=String:C10([RatingReports:65]RecPostingH:14; "00")
	vtxtRecomPosting3:=String:C10([RatingReports:65]RecPost3:15; "00")
	vtxtRecomPosting3S2:=String:C10([RatingReports:65]RecPost3S2:16; "00")
	
	If ([RatingReports:65]RecSinglePosting_L:39>0)
		vtxtRecomPostingSgl:=String:C10([RatingReports:65]RecSinglePosting_L:39)
	Else 
		If (([RatingReports:65]RecPostingH:14=[RatingReports:65]RecPost3:15) & ([RatingReports:65]RecPost3:15=[RatingReports:65]RecPost3S2:16))
			vtxtRecomPostingSgl:=String:C10([RatingReports:65]RecPostingH:14; "00")
		Else 
			vtxtRecomPostingSgl:="00"
		End if 
		
	End if 
	
Else 
	vtxtRatingReport:="No rating report available"
	vtxtRatingDate:="-"
	vtxtRecomPostingH:="00"
	vtxtRecomPosting3:="00"
	vtxtRecomPosting3S2:="00"
	vtxtRecomPostingSgl:="00"
End if 

If ([Bridge MHD NBIS:1]PostingStatus:8="POSTED")  //check to see what is in the NBI table
	vtxtWeightPosting:="True"
Else 
	vtxtWeightPosting:="False"
End if 

vblnRatingDate:=(vtxtRatingDate#vtxtRatingDateInsp)
vblnRatingReport:=(vtxtRatingReport#vtxtRatingReportInsp)
vblnWeightPosting:=(vtxtWeightPosting#vtxtWeightPostingInsp)
vblnRecomPostingH:=(vtxtRecomPostingH#vtxtRecomPostingHInsp)
vblnRecomPosting3:=(vtxtRecomPosting3#vtxtRecomPosting3Insp)
vblnRecomPosting3S2:=(vtxtRecomPosting3S2#vtxtRecomPosting3S2Insp)
vblnRecomPostingSgl:=(vtxtRecomPostingSgl#vtxtRecomPostingSglInsp)
//Do the check
$blnDoCheck:=(vblnChkItem43 | vblnChkItem107 | vblnWeightPosting | vblnRatingReport)
$blnDoCheck:=($blnDoCheck | vblnRatingDate | vblnRecomPostingH | vblnRecomPosting3)
$blnDoCheck:=($blnDoCheck | vblnRecomPosting3S2 | vblnRecomPostingSgl | vblnEDJMTDate)
$blnDoCheck:=($blnDoCheck | vblnWaivedDate)
$blnDoCheck:=($blnDoCheck | vblnChkItem106 | vblnChkItem21 | vblnChkItem22 | vblnChkItem26)
$blnDoCheck:=($blnDoCheck & Not:C34([Inspections:27]DoNotShowDialogDependency:196))
If ($blnDoCheck)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "DependencyCheck"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain no zoom box window:K34:1; $Title_txt; "ut_CloseCancel")
	//$FormWindow:=Open form window([Dialogs];"DependencyCheck";(Plain no zoom box window ))
	DIALOG:C40([Dialogs:21]; "DependencyCheck")
	CLOSE WINDOW:C154
	If (OK=1)
		
		If (blnStructureType=1)
			[Inspections:27]Item 43:140:=[Bridge MHD NBIS:1]Item43:75
			PushChange(1; ->[Inspections:27]Item 43:140)
			INSP_Item43Desc
		End if 
		
		If (blnItem107=1)
			[Inspections:27]Item 107:141:=[Bridge MHD NBIS:1]Item107:79
			PushChange(1; ->[Inspections:27]Item 107:141)
			INSP_Item107Desc
		End if 
		
		If (blnItem106=1)
			[Inspections:27]Item106:198:=[Bridge MHD NBIS:1]Item106:84
			PushChange(1; ->[Inspections:27]Item106:198)
		End if 
		
		If (blnItem21=1)
			[Inspections:27]Item21:166:=[Bridge MHD NBIS:1]Item21:127
			PushChange(1; ->[Inspections:27]Item21:166)
		End if 
		
		If (blnItem22=1)
			[Inspections:27]Item22:197:=[Bridge MHD NBIS:1]Item22:128
			PushChange(1; ->[Inspections:27]Item22:197)
		End if 
		
		If (blnItem26=1)
			[Inspections:27]Item26:200:=[Bridge MHD NBIS:1]Item26:120
			PushChange(1; ->[Inspections:27]Item26:200)
		End if 
		
		If (blnWeightPosting=1)
			G_CBWeightPosting(([Bridge MHD NBIS:1]PostingStatus:8#"POSTED"))
		End if 
		
		If (blnRatingReport=1)
			[Inspections:27]Rating Report:73:=(Records in selection:C76([RatingReports:65])>0)
			PushChange(1; ->[Inspections:27]Rating Report:73)
		End if 
		
		If (blnRatingDate=1)
			If (Records in selection:C76([RatingReports:65])>0)
				[Inspections:27]Rating Date:74:=[RatingReports:65]ReportDate:4
			Else 
				[Inspections:27]Rating Date:74:=!00-00-00!
			End if 
			PushChange(1; ->[Inspections:27]Rating Date:74)
		End if 
		
		If (blnRecomPostingH=1)
			If (Records in selection:C76([RatingReports:65])>0)
				[Inspections:27]RecomPostingH:31:=[RatingReports:65]RecPostingH:14
			Else 
				[Inspections:27]RecomPostingH:31:=0
			End if 
			PushChange(1; ->[Inspections:27]RecomPostingH:31)
		End if 
		
		If (blnRecomPosting3=1)
			If (Records in selection:C76([RatingReports:65])>0)
				[Inspections:27]RecomPosting3:32:=[RatingReports:65]RecPost3:15
			Else 
				[Inspections:27]RecomPosting3:32:=0
			End if 
			PushChange(1; ->[Inspections:27]RecomPosting3:32)
		End if 
		
		If (blnRecomPosting3S2=1)
			If (Records in selection:C76([RatingReports:65])>0)
				[Inspections:27]RecomPosting3S2:33:=[RatingReports:65]RecPost3S2:16
			Else 
				[Inspections:27]RecomPosting3S2:33:=0
			End if 
			PushChange(1; ->[Inspections:27]RecomPosting3S2:33)
		End if 
		
		If (blnRecomPostingSgl=1)
			If (Records in selection:C76([RatingReports:65])>0)
				
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
				[Inspections:27]RecomPostingSgl:34:=0
			End if 
			PushChange(1; ->[Inspections:27]RecomPostingSgl:34)
		End if 
		
		If (blnEDJMTDate=1)
			If ([Bridge MHD NBIS:1]PostingStatus:8="EJDMNT")
				[Inspections:27]EDJMT Date:36:=[Bridge MHD NBIS:1]PostingDate:7
			Else 
				[Inspections:27]EDJMT Date:36:=!00-00-00!
			End if 
			PushChange(1; ->[Inspections:27]EDJMT Date:36)
		End if 
		
		If (blnWaivedDate=1)
			If ([Bridge MHD NBIS:1]PostingStatus:8="WAIVED")
				[Inspections:27]WaivedDate:35:=[Bridge MHD NBIS:1]PostingDate:7
			Else 
				[Inspections:27]WaivedDate:35:=!00-00-00!
			End if 
			PushChange(1; ->[Inspections:27]WaivedDate:35)
		End if 
		
		If (blnDontAskAgain=1)
			[Inspections:27]DoNotShowDialogDependency:196:=True:C214
		End if 
		
	End if 
End if 