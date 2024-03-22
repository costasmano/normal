//%attributes = {"invisible":true}
//proccedure: ImportRating1

C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Report)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($EngJdgment)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($ReportDate)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($Consultant)  // Command Replaced was o_C_STRING length was 25
C_TEXT:C284($InvH20)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($InvType3)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($Inv3S2)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($InvHS20)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($OprH20)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($OprType3)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($Opr3S2)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($OprHS20)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($RecPostH)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($RecPost3)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($RecPost3S2)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item43)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item58)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item59)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($RatingInfo)
C_LONGINT:C283($counter)

$counter:=1
$dImportFile:=Open document:C264(""; "TEXT")
While (Ok=1)
	//read in a record
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Report; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $EngJdgment; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $ReportDate; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Consultant; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvH20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvType3; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Inv3S2; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvHS20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprH20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprType3; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Opr3S2; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprHS20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $RecPostH; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $RecPost3; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $RecPost3S2; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Item43; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Item58; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Item59; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $RatingInfo; <>sCR)
	CREATE RECORD:C68([RatingReports:65])
	[RatingReports:65]BIN:1:=$BIN
	[RatingReports:65]RatingReport:2:=($Report="Y")
	[RatingReports:65]EngrJudgment:3:=($EngJdgment="Y")
	[RatingReports:65]ReportDate:4:=Date:C102($ReportDate)
	[RatingReports:65]Consultant:5:=$Consultant
	[RatingReports:65]InvH20:6:=Num:C11($InvH20)
	[RatingReports:65]InvType3:7:=Num:C11($InvType3)
	[RatingReports:65]Inv3S2:8:=Num:C11($Inv3S2)
	[RatingReports:65]InvHS2044:9:=Num:C11($InvHS20)
	[RatingReports:65]OprH20:10:=Num:C11($OprH20)
	[RatingReports:65]OprType3:11:=Num:C11($OprType3)
	[RatingReports:65]Opr3S2:12:=Num:C11($Opr3S2)
	[RatingReports:65]OprHS2044:13:=Num:C11($OprHS20)
	[RatingReports:65]RecPostingH:14:=Num:C11($RecPostH)
	[RatingReports:65]RecPost3:15:=Num:C11($RecPost3)
	[RatingReports:65]RecPost3S2:16:=Num:C11($RecPost3S2)
	[RatingReports:65]Item43inRating:17:=$Item43
	[RatingReports:65]Item58:18:=$Item58
	[RatingReports:65]Item59:19:=$Item59
	[RatingReports:65]RatingInfo:20:=$RatingInfo
	[RatingReports:65]RatingID:21:=$counter
	SAVE RECORD:C53([RatingReports:65])
	$counter:=$counter+1
End while 
CLOSE DOCUMENT:C267($dImportFile)