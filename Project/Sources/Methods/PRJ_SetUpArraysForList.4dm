//%attributes = {"invisible":true,"executedOnServer":true}
//Method: PRJ_SetUpArraysForList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/22/20, 12:59:16
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27) 
End if 
//
//TRACE
C_BLOB:C604($1; $0)
C_LONGINT:C283($offset_L; $loop_L; $Next_L)  //
Compiler_FieldVariables
$offset_L:=0
ARRAY LONGINT:C221($RecordIds_al; 0)
BLOB TO VARIABLE:C533($1; $RecordIds_al; $offset_L)
CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $RecordIds_al)
C_LONGINT:C283($i; $numRecs; $k; $j; $l)
$numRecs:=Records in selection:C76([PRJ_ProjectDetails:115])
ARRAY DATE:C224($RatingDates_aD; 0)
ALL RECORDS:C47([Bridge MHD NBIS:1])
ARRAY TEXT:C222($BridgeBins_atxt; 0)
ARRAY TEXT:C222($BridgeBDEPTs_atxt; 0)
ARRAY TEXT:C222($BridgeItem7_atxt; 0)
ARRAY TEXT:C222($BridgeItem6A_atxt; 0)
ARRAY DATE:C224($RatingDates_aD; 0)
ARRAY TEXT:C222($District_atxt; 0)

SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BridgeBins_atxt; \
[Bridge MHD NBIS:1]BDEPT:1; $BridgeBDEPTs_atxt; \
[Bridge MHD NBIS:1]Item7:65; $BridgeItem7_atxt; \
[Bridge MHD NBIS:1]DateRatReport:205; $RatingDates_aD; \
[Bridge MHD NBIS:1]Item2:60; $District_atxt; \
[Bridge MHD NBIS:1]Item6A:63; $BridgeItem6A_atxt)
ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)

ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(PRJ_DistrNo_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(v_127_005_atxt; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221($v_115_001_aL; 0)
ARRAY TEXT:C222(PRJ_RWYOver_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; $numRecs)

ARRAY TEXT:C222(v_139_059_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_ConsName_atxt; $numRecs)
ARRAY TEXT:C222(PRJ_DistrNo_aS; $numRecs)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221($v_115_001_aL; $numRecs)

ARRAY TEXT:C222(v_127_005_atxt; $numRecs)

ARRAY BOOLEAN:C223(v_115_006_ab; $numRecs)  //used for Rating done
//change form const name to ID and then get name
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; v_115_002_aL; \
[PRJ_ProjectFile:117]PF_Advertised_d:14; v_117_014_ad; \
[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; v_117_005_ad; \
[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34; v_115_034_atxt; \
[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; v_115_005_atxt; \
[PRJ_ConstructionProject:116]CP_Awarded_d:4; v_116_004_ad; \
[PRJ_ProjectDetails:115]PRJ_Completion_d:37; $v_115_037_ad; \
[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $v_115_001_aL)




ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
READ ONLY:C145([Conslt_Name:127])
ALL RECORDS:C47([Conslt_Name:127])
SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)

//Now get all of the included bins earliest insp date
QUERY:C277([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
ALL RECORDS:C47([PRJ_ProjectDetailsIncludedBINS:122])
DISTINCT VALUES:C339([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; v_27_001_atxt)

QUERY SELECTION WITH ARRAY:C1050([Inspections:27]BIN:1; v_27_001_atxt)
SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; v_27_078_ad; [Inspections:27]BIN:1; v_27_001_atxt)
MULTI SORT ARRAY:C718(v_27_001_atxt; >; v_27_078_ad; >)
C_BOOLEAN:C305($Complete_B)
$Complete_B:=False:C215
C_LONGINT:C283($NewPos_L)
C_LONGINT:C283($Pos_l; $Start_l)
$NewPos_L:=1
$loop_l:=0
$Next_L:=0
Repeat 
	$loop_l:=$loop_l+1
	$Next_L:=$loop_l+1
	
	Repeat 
		$Complete_B:=False:C215
		If ($Next_L<=Size of array:C274(v_27_001_atxt))
			If (v_27_001_atxt{$loop_l}=v_27_001_atxt{$Next_L})
				DELETE FROM ARRAY:C228(v_27_001_atxt; $Next_L; 1)
				DELETE FROM ARRAY:C228(v_27_078_ad; $Next_L; 1)
			Else 
				$Complete_B:=True:C214
			End if 
		Else 
			$Complete_B:=True:C214
		End if 
	Until ($Complete_B)
Until ($loop_l=Size of array:C274(v_27_001_atxt))
C_LONGINT:C283($InnerLoop_L)
C_OBJECT:C1216($progressobj_o)
//$progressobj_o:=ProgressNew ("Creating arrays for prj bridge lst ";Size of array($v_115_001_aL);True;"";3)

For ($loop_l; 1; Size of array:C274($v_115_001_aL))
	GOTO RECORD:C242([PRJ_ProjectDetails:115]; $RecordIds_al{$loop_l})
	v_115_006_ab{$loop_l}:=False:C215
	//UpdateProgressNew ($progressobj_o;$loop_l)
	v_115_005_atxt{$i}:=Substring:C12(v_115_005_atxt{$i}; 1; 6)
	ARRAY TEXT:C222($Bins_atxt; 0)
	PRJ_LoadDesignContractForOutput
	PRJ_ConsName_atxt{$loop_l}:=PRJ_ConsultantName_txt
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=$v_115_001_aL{$loop_l})
	SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $Bins_atxt)
	C_DATE:C307($Earliest_d)
	C_LONGINT:C283($ArrayPos_L)
	$Earliest_d:=!9999-12-31!
	For ($InnerLoop_L; 1; Size of array:C274($Bins_atxt))
		$ArrayPos_L:=Find in array:C230(v_27_001_atxt; $Bins_atxt{$InnerLoop_L})
		If ($ArrayPos_L>0)
			If (v_27_078_ad{$ArrayPos_L}<$Earliest_d)
				$Earliest_d:=v_27_078_ad{$ArrayPos_L}
			End if 
			
			
			
		End if 
	End for 
	
	If (v_116_004_ad{$loop_l}#!00-00-00!)
		v_127_005_atxt{$loop_l}:="U"
		If (v_116_004_ad{$loop_l}<$Earliest_d)
			v_127_005_atxt{$loop_l}:="F"
			
		End if 
		
		
	Else 
		v_127_005_atxt{$loop_l}:="N"
	End if 
	
	If (v_115_034_atxt{$loop_L}#"")
		$ArrayPos_L:=Find in array:C230($BridgeBins_atxt; v_115_034_atxt{$loop_L})
		
	Else 
		$ArrayPos_L:=Find in array:C230($BridgeBDEPTs_atxt; v_115_005_atxt{$loop_l})
		
	End if 
	If ($ArrayPos_L>0)
		PRJ_RWYOver_atxt{$loop_L}:=$BridgeItem7_atxt{$ArrayPos_L}
		PRJ_RWYUnder_atxt{$loop_L}:=$BridgeItem6A_atxt{$ArrayPos_L}
		v_139_059_atxt{$loop_L}:=$District_atxt{$ArrayPos_L}
		
		If ($RatingDates_aD{$ArrayPos_L}>v_116_004_ad{$loop_l})
			v_115_006_ab{$loop_L}:=True:C214
		End if 
		//add rating stuff here
	Else 
		PRJ_RWYOver_atxt{$loop_L}:="????"
		PRJ_RWYUnder_atxt{$loop_L}:="????"
		v_139_059_atxt{$loop_L}:="??"
	End if 
	
End for 
C_BLOB:C604($Return_blb)


VARIABLE TO BLOB:C532(v_115_002_aL; $Return_blb; *)  //Records numbers
VARIABLE TO BLOB:C532(v_117_014_ad; $Return_blb; *)  //PF_Advertised_d
VARIABLE TO BLOB:C532(v_117_005_ad; $Return_blb; *)  //PF_ScheduledAdvertising_d
VARIABLE TO BLOB:C532(v_115_034_atxt; $Return_blb; *)  //PRJ_PrimaryBin_s
VARIABLE TO BLOB:C532(v_115_005_atxt; $Return_blb; *)  //PRJ_BridgeNo_s
VARIABLE TO BLOB:C532(PRJ_ConsName_atxt; $Return_blb; *)  //ConsultantName_s
VARIABLE TO BLOB:C532(v_116_004_ad; $Return_blb; *)  //CP_Awarded_d
//VARIABLE TO BLOB($v_115_037_ad;$Return_blb;*)  //PRJ_Completion_d not used
//VARIABLE TO BLOB($v_115_001_aL;$Return_blb;*)  //PRJ_ProjectID_l not used
VARIABLE TO BLOB:C532(v_127_005_atxt; $Return_blb; *)  //Under Constructions
VARIABLE TO BLOB:C532(PRJ_RWYOver_atxt; $Return_blb; *)  //Roadway Over Item 7
VARIABLE TO BLOB:C532(PRJ_RWYUnder_atxt; $Return_blb; *)  //Roadway under Item 6A
VARIABLE TO BLOB:C532(v_139_059_atxt; $Return_blb; *)  //Item 2 district
VARIABLE TO BLOB:C532(v_115_006_ab; $Return_blb; *)  //rating boolean

ARRAY DATE:C224($RatingDates_aD; 0)
ARRAY TEXT:C222($BridgeBins_atxt; 0)
ARRAY TEXT:C222($BridgeBDEPTs_atxt; 0)
ARRAY TEXT:C222($BridgeItem7_atxt; 0)
ARRAY TEXT:C222($BridgeItem6A_atxt; 0)
ARRAY DATE:C224($RatingDates_aD; 0)
ARRAY TEXT:C222($District_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)

ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(PRJ_DistrNo_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(v_127_005_atxt; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221($v_115_001_aL; 0)

//Rating done
$0:=$Return_blb
//ALERT("Duration :"+String($duration))
//End PRJ_SetUpArraysForList