//%attributes = {"invisible":true}
//Method: M_Create10YearRating
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/25/17, 14:00:27
	// ----------------------------------------------------
	//Created : 
	Mods_2017_07_bug
End if 
//
If (Records in set:C195("UserSet")>0)
	
	C_BLOB:C604($ROState_x)
	$ROState_x:=ut_db_SaveROState
	READ ONLY:C145(*)
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PrePrintBrgList")
	
	USE SET:C118("UserSet")
	C_LONGINT:C283($Loop_L; $Width_L; $Height_L)
	FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "Rating Evalu 10y"; $Width_L; $Height_L)
	C_BOOLEAN:C305($WindowOpen_B)
	$WindowOpen_B:=False:C215
	For ($Loop_L; 1; Records in selection:C76([Bridge MHD NBIS:1]))
		GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_L)
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RTN"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="RTA")
		If (Records in selection:C76([Inspections:27])=0)
			ALERT:C41("Can not create 10 Yr Rating Evaluation with no routine inspections for BIN "+[Bridge MHD NBIS:1]BIN:3)
		Else 
			Compiler_FieldVariables(Table:C252(->[RatingReports:65]))
			C_TEXT:C284($BIN_txt)
			$BIN_txt:=[Bridge MHD NBIS:1]BIN:3
			//QUERY([RatingReports];[RatingReports]BIN=[Bridge MHD NBIS]BIN)
			//ORDER BY([RatingReports];[RatingReports]ReportDate;<)
			//[RatingReports]
			//REDUCE SELECTION([RatingReports];4)
			Begin SQL
				select 
				[RatingReports].[ReportDate],
				[RatingReports].[Item58],
				[RatingReports].[Item59],
				[RatingReports].[InvH20],
				[RatingReports].[InvType3],
				[RatingReports].[Inv3S2],
				[RatingReports].[InvHS2044],
				[RatingReports].[OprH20],
				[RatingReports].[OprType3],
				[RatingReports].[Opr3S2],
				[RatingReports].[OprHS2044],
				'N','N'
				from
				[RatingReports]
				where
				[RatingReports].[BIN] = :$BIN_txt
				order by 1 DESC
				limit 1
				into
				:v_65_004_d,
				:v_65_018_txt,
				:v_65_019_txt,
				:v_65_006_r,
				:v_65_007_r,
				:v_65_008_r,
				:v_65_009_r,
				:v_65_010_r,
				:v_65_011_r,
				:v_65_012_r,
				:v_65_013_r,
				:v_65_035_txt,
				:v_65_028_txt;
				
			End SQL
			
			ORDER BY:C49([Inspections:27]Insp Date:78; <)
			REDUCE SELECTION:C351([Inspections:27]; 1)
			C_BLOB:C604(report_blb)
			If (Not:C34($WindowOpen_B))
				ut_OpenNewWindow($Width_L; $Height_L; 0; Plain form window:K39:10; "10 Year Rating Evaluation")
				$WindowOpen_B:=True:C214
			End if 
			DIALOG:C40([Bridge MHD NBIS:1]; "Rating Evalu 10y")
		End if 
		
	End for 
	If ($WindowOpen_B)
		CLOSE WINDOW:C154
	End if 
	
	ut_db_RestoreROState($ROState_x)
	USE NAMED SELECTION:C332("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656([Bridge MHD NBIS:1]; "UserSet")
	
Else 
	ALERT:C41("Please Select some records first!")
End if 

//End M_Create10YearRating