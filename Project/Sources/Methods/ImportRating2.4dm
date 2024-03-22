//%attributes = {"invisible":true}
//proccedure: ImportRating2

C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($SpanType)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($MemberType)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Description)  // Command Replaced was o_C_STRING length was 40
C_TEXT:C284($SpanLength)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($LocationCM)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($FloorBeamSp)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($InvH20)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($InvType3)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Inv3S2)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($InvHS20)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($OprH20)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($OprType3)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($Opr3S2)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($OprHS20)  // Command Replaced was o_C_STRING length was 4
C_LONGINT:C283($n)  //Command Replaced was o_C_INTEGER
ALL RECORDS:C47([RatingReports:65])
ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY LONGINT:C221($aRatingID; 0)
SELECTION TO ARRAY:C260([RatingReports:65]BIN:1; $aBIN; [RatingReports:65]RatingID:21; $aRatingID)

$dImportFile:=Open document:C264(""; "TEXT")
While (Ok=1)
	//read in a record
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $SpanType; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $MemberType; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Description; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $SpanLength; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $LocationCM; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $FloorBeamSp; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvH20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvType3; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Inv3S2; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $InvHS20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprH20; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprType3; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $Opr3S2; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $OprHS20; <>sCR)
	$n:=Find in array:C230($aBIN; $BIN)
	If ($n>0)
		CREATE RECORD:C68([RatingMember:66])
		[RatingMember:66]RatingID:1:=$aRatingID{$n}
		[RatingMember:66]SpanType:2:=$SpanType
		[RatingMember:66]MemberType:3:=$MemberType
		[RatingMember:66]Description:4:=$Description
		[RatingMember:66]SpanLength:5:=Num:C11($SpanLength)
		[RatingMember:66]LocationCM:6:=Num:C11($LocationCM)
		[RatingMember:66]FloorBeamSp:15:=Num:C11($FloorBeamSp)
		[RatingMember:66]InvH20:7:=Num:C11($InvH20)
		[RatingMember:66]InvType3:8:=Num:C11($InvType3)
		[RatingMember:66]Inv3S2:9:=Num:C11($Inv3S2)
		[RatingMember:66]InvHS2044:10:=Num:C11($InvHS20)
		[RatingMember:66]OprH20:11:=Num:C11($OprH20)
		[RatingMember:66]OprType3:12:=Num:C11($OprType3)
		[RatingMember:66]Opr3S2:13:=Num:C11($Opr3S2)
		[RatingMember:66]OprHS2044:14:=Num:C11($OprHS20)
		SAVE RECORD:C53([RatingMember:66])
	Else 
		CONFIRM:C162("Found orphan record [BIN="+$BIN+"]"+<>sCR+"Do you wish to continue?")
		If (Ok#1)
			ABORT:C156
		End if 
	End if 
End while 
CLOSE DOCUMENT:C267($dImportFile)