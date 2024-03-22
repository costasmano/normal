//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ImportFromOldScour
// User name (OS): charlesmiller
// Date and time: 06/04/09, 11:46:24
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_06  //r003 `06/04/09, 11:46:31  `Write import routine from old scour
	// Modified by: costasmanousakis-(Designer)-(12/15/09 19:50:28)
	Mods_2009_12
	//Added Loging changes to activity log
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_TEXT:C284($Bin_txt)
C_TEXT:C284($SummaryEngineer1_txt)
C_TEXT:C284($SummaryDiscipline1_txt)
C_TEXT:C284($SummaryEngineer2_txt)
C_TEXT:C284($SummaryDiscipline2_txt)
C_TEXT:C284($SummaryEngineer3_txt)
C_TEXT:C284($SummaryDiscipline3_txt)
C_TEXT:C284($Notes_txt)  //113scrrmd
C_TEXT:C284($FoundationType_txt)
C_TEXT:C284($StreamBedmaterial_txt)
C_TEXT:C284($PH2Engineer1_txt)
C_TEXT:C284($PH2Date1_txt)
C_TEXT:C284($PH2Discipline1_txt)
C_TEXT:C284($PH2Engineer2_txt)
C_TEXT:C284($PH2Date2_txt)
C_TEXT:C284($PH2Discipline2_txt)
C_TEXT:C284($PH3AEngineer1_txt)
C_TEXT:C284($PH3ADate1_txt)
C_TEXT:C284($PH3ADiscipline1_txt)
C_TEXT:C284($PH3AEngineer2_txt)
C_TEXT:C284($PH3ADate2_txt)
C_TEXT:C284($PH3ADiscipline2_txt)
C_DATE:C307($Compare1_d)
C_DATE:C307($Compare2_d)
C_TEXT:C284($Tab_txt; $CR_txt)
$Tab_txt:=Char:C90(Tab:K15:37)
$CR_txt:=Char:C90(Carriage return:K15:38)
C_BOOLEAN:C305($FoundStrucural_b; $FoundGeo_b; $FoundHydro_b)
C_TEXT:C284($UseThisEng_txt)
C_DATE:C307($Latest_d)
C_LONGINT:C283($Loop_l; $Position_l)

SCPOA_Variables("SETUP")
C_TIME:C306($Doc)
$Doc:=Open document:C264("")
Repeat 
	RECEIVE PACKET:C104($Doc; $Bin_txt; $Tab_txt)
	If ($Bin_txt#"")
		RECEIVE PACKET:C104($Doc; $SummaryEngineer1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $SummaryDiscipline1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $SummaryEngineer2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $SummaryDiscipline2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $SummaryEngineer3_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $SummaryDiscipline3_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $Notes_txt; $Tab_txt)  //113scrrmd
		RECEIVE PACKET:C104($Doc; $FoundationType_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $StreamBedmaterial_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Engineer1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Date1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Discipline1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Engineer2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Date2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH2Discipline2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3AEngineer1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3ADate1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3ADiscipline1_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3AEngineer2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3ADate2_txt; $Tab_txt)
		RECEIVE PACKET:C104($Doc; $PH3ADiscipline2_txt; $CR_txt)
		//Code for 
		QUERY:C277([ScourPOA:132]; [ScourPOA:132]BIN:2=$Bin_txt)
		If (Records in selection:C76([ScourPOA:132])=1)
			If (ut_LoadRecord(->[ScourPOA:132]))
			End if   //code for disciplines
			InitChangeStack(1)
			If ($FoundationType_txt#"")
				[ScourPOA:132]FoundationType:19:=SCPOA_TransFtgUtil($FoundationType_txt)
				PushChange(1; ->[ScourPOA:132]FoundationType:19)
			End if 
			If ($StreamBedmaterial_txt#"")
				[ScourPOA:132]StreamBedMaterial:25:=Substring:C12($StreamBedmaterial_txt; 1; 80)
				PushChange(1; ->[ScourPOA:132]StreamBedMaterial:25)
			End if 
			//do we want variable or text to blob
			$Notes_txt:=Replace string:C233($Notes_txt; "}"; $CR_txt)
			$Notes_txt:=Replace string:C233($Notes_txt; "{"; $Tab_txt)
			$Notes_txt:=f_TrimStr($Notes_txt; True:C214; True:C214)
			VARIABLE TO BLOB:C532($Notes_txt; [ScourPOA:132]ScourEvalSummary:6; *)
			PushChange(1; ->[ScourPOA:132]ScourEvalSummary:6)
			//Structural
			ARRAY POINTER:C280($EngineerPointers_aptr; 0)
			ARRAY POINTER:C280($DatePointers_aptr; 0)
			
			If ($PH2Discipline1_txt="Struc@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date1_txt)
			End if 
			If ($PH2Discipline2_txt="Struc@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date2_txt)
			End if 
			If ($PH3ADiscipline1_txt="Struc@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate1_txt)
			End if 
			If ($PH3ADiscipline2_txt="Struc@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate2_txt)
			End if 
			$Latest_d:=!00-00-00!
			$Position_l:=0
			For ($Loop_l; 1; Size of array:C274($EngineerPointers_aptr))
				If (Date:C102($DatePointers_aptr{$Loop_l}->)>$Latest_d)
					$Latest_d:=Date:C102($DatePointers_aptr{$Loop_l}->)
					$Position_l:=$Loop_l
				End if 
			End for 
			$UseThisEng_txt:=""
			If ($Position_l=0)  //no dates
				$Latest_d:=!00-00-00!
				Case of 
					: ($SummaryDiscipline1_txt="Struc@")
						$UseThisEng_txt:=$SummaryEngineer1_txt
					: ($SummaryDiscipline2_txt="Struc@")
						$UseThisEng_txt:=$SummaryEngineer2_txt
					: ($SummaryDiscipline3_txt="Struc@")
						$UseThisEng_txt:=$SummaryEngineer3_txt
					Else 
				End case 
			Else 
				$UseThisEng_txt:=$EngineerPointers_aptr{$Position_l}->
			End if 
			If ($UseThisEng_txt#"")  //update structural stuff
				[ScourPOA:132]StructAssessBy:15:=$UseThisEng_txt
				[ScourPOA:132]StructAssessDate:13:=$Latest_d
				PushChange(1; ->[ScourPOA:132]StructAssessDate:13)
				PushChange(1; ->[ScourPOA:132]StructAssessBy:15)
			End if 
			//hydaulics
			ARRAY POINTER:C280($EngineerPointers_aptr; 0)
			ARRAY POINTER:C280($DatePointers_aptr; 0)
			
			If ($PH2Discipline1_txt="Hyd@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date1_txt)
			End if 
			If ($PH2Discipline2_txt="Hyd@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date2_txt)
			End if 
			If ($PH3ADiscipline1_txt="Hyd@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate1_txt)
			End if 
			If ($PH3ADiscipline2_txt="Hyd@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate2_txt)
			End if 
			$Latest_d:=!00-00-00!
			$Position_l:=0
			For ($Loop_l; 1; Size of array:C274($EngineerPointers_aptr))
				If (Date:C102($DatePointers_aptr{$Loop_l}->)>$Latest_d)
					$Latest_d:=Date:C102($DatePointers_aptr{$Loop_l}->)
					$Position_l:=$Loop_l
				End if 
			End for 
			$UseThisEng_txt:=""
			If ($Position_l=0)  //no dates
				$Latest_d:=!00-00-00!
				Case of 
					: ($SummaryDiscipline1_txt="Hyd@")
						$UseThisEng_txt:=$SummaryEngineer1_txt
					: ($SummaryDiscipline2_txt="Hyd@")
						$UseThisEng_txt:=$SummaryEngineer2_txt
					: ($SummaryDiscipline3_txt="Hyd@")
						$UseThisEng_txt:=$SummaryEngineer3_txt
					Else 
				End case 
			Else 
				$UseThisEng_txt:=$EngineerPointers_aptr{$Position_l}->
			End if 
			If ($UseThisEng_txt#"")  //update hydraulics stuff
				[ScourPOA:132]ScourReviewBy:11:=$UseThisEng_txt
				[ScourPOA:132]ScourReviewDate:12:=$Latest_d
				PushChange(1; ->[ScourPOA:132]ScourReviewDate:12)
				PushChange(1; ->[ScourPOA:132]ScourReviewBy:11)
			End if 
			
			//geo
			ARRAY POINTER:C280($EngineerPointers_aptr; 0)
			ARRAY POINTER:C280($DatePointers_aptr; 0)
			
			If ($PH2Discipline1_txt="geo@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date1_txt)
			End if 
			If ($PH2Discipline2_txt="geo@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH2Engineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH2Date2_txt)
			End if 
			If ($PH3ADiscipline1_txt="geo@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer1_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate1_txt)
			End if 
			If ($PH3ADiscipline2_txt="geo@")
				APPEND TO ARRAY:C911($EngineerPointers_aptr; ->$PH3AEngineer2_txt)
				APPEND TO ARRAY:C911($DatePointers_aptr; ->$PH3ADate2_txt)
			End if 
			$Latest_d:=!00-00-00!
			$Position_l:=0
			For ($Loop_l; 1; Size of array:C274($EngineerPointers_aptr))
				If (Date:C102($DatePointers_aptr{$Loop_l}->)>$Latest_d)
					$Latest_d:=Date:C102($DatePointers_aptr{$Loop_l}->)
					$Position_l:=$Loop_l
				End if 
			End for 
			$UseThisEng_txt:=""
			If ($Position_l=0)  //no dates
				$Latest_d:=!00-00-00!
				Case of 
					: ($SummaryDiscipline1_txt="geo@")
						$UseThisEng_txt:=$SummaryEngineer1_txt
					: ($SummaryDiscipline2_txt="geo@")
						$UseThisEng_txt:=$SummaryEngineer2_txt
					: ($SummaryDiscipline3_txt="geo@")
						$UseThisEng_txt:=$SummaryEngineer3_txt
					Else 
				End case 
			Else 
				$UseThisEng_txt:=$EngineerPointers_aptr{$Position_l}->
			End if 
			If ($UseThisEng_txt#"")  //update structural stuff
				[ScourPOA:132]GeotechAssessBy:16:=$UseThisEng_txt
				[ScourPOA:132]GeotechAssessDate:14:=$Latest_d
				PushChange(1; ->[ScourPOA:132]GeotechAssessBy:16)
				PushChange(1; ->[ScourPOA:132]GeotechAssessDate:14)
			End if 
			
			If (SCPOA_LogChanges_b)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1)
			End if 
			
			SAVE RECORD:C53([ScourPOA:132])
			UNLOAD RECORD:C212([ScourPOA:132])
		End if 
		
	End if 
	
Until (OK=0)
CLOSE DOCUMENT:C267($Doc)

//End ut_ImportFromOldScour