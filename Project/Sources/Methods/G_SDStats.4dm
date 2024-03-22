//%attributes = {"invisible":true}
//G_SDStats
//Calculate statistics for SD Bridges

SET QUERY DESTINATION:C396(Into current selection:K19:1)
ALL RECORDS:C47([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 Owner:208="MHD"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item8 Owner:208="MUN")
C_LONGINT:C283($vlMHDMUNSD; $vlDeckOnly; $vlSuperOnly; $vlSubOnly)
$vlMHDMUNSD:=Records in selection:C76([Bridge MHD NBIS:1])
If (True:C214)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlDeckOnly)
	QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; ((Position:C15([Bridge MHD NBIS:1]Item58:130; "01234")>0) & (Position:C15([Bridge MHD NBIS:1]Item59:131; "01234")=0) & (Position:C15([Bridge MHD NBIS:1]Item60:132; "01234")=0)))
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlSuperOnly)
	QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; ((Position:C15([Bridge MHD NBIS:1]Item58:130; "01234")=0) & (Position:C15([Bridge MHD NBIS:1]Item59:131; "01234")>0) & (Position:C15([Bridge MHD NBIS:1]Item60:132; "01234")=0)))
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlSubOnly)
	QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; ((Position:C15([Bridge MHD NBIS:1]Item58:130; "01234")=0) & (Position:C15([Bridge MHD NBIS:1]Item59:131; "01234")=0) & (Position:C15([Bridge MHD NBIS:1]Item60:132; "01234")>0)))
	
	C_TEXT:C284($msg)
	$msg:="MHD + MUN SD : "+String:C10($vlMHDMUNSD)+<>sCR
	$msg:=$msg+" Deckonly  :"+String:C10($vlDeckOnly)
	$msg:=$msg+" Superonly  :"+String:C10($vlSuperOnly)
	$msg:=$msg+" Subonly  :"+String:C10($vlSubOnly)
	$msg:=$msg+" Combination  :"+String:C10(($vlMHDMUNSD-$vlDeckOnly-$vlSuperOnly-$vlSubOnly))
	
	ALERT:C41($msg)
End if 

SET QUERY DESTINATION:C396(Into variable:K19:4; $vlDeckOnly)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item58:130="0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item58:130="1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item58:130="2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item58:130="3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item58:130="4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"4"; *)

SET QUERY DESTINATION:C396(Into variable:K19:4; $vlSuperOnly)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item59:131="0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item59:131="1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item59:131="2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item59:131="3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item59:131="4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item60:132#"4"; *)

SET QUERY DESTINATION:C396(Into variable:K19:4; $vlSubOnly)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item60:132="0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item60:132="1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item60:132="2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item60:132="3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  | [Bridge MHD NBIS:1]Item60:132="4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item58:130#"4"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"0"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"1"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"2"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"3"; *)
QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item59:131#"4"; *)

$msg:="MHD + MUN SD : "+String:C10($vlMHDMUNSD)+<>sCR
$msg:=$msg+" Deckonly  :"+String:C10($vlDeckOnly)
$msg:=$msg+" Superonly  :"+String:C10($vlSuperOnly)
$msg:=$msg+" Subonly  :"+String:C10($vlSubOnly)
$msg:=$msg+" Combination  :"+String:C10(($vlMHDMUNSD-$vlDeckOnly-$vlSuperOnly-$vlSubOnly))
ALERT:C41($msg)

SET QUERY DESTINATION:C396(Into current selection:K19:1)