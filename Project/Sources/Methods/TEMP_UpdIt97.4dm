//%attributes = {"invisible":true}
//  `GP  TEMP_UpdItm97
//  `purpose: update Item 97 (Construction Year estimate)
//  `will be done for all records in selection.
//
//C_LONGINT($i;$Recs)
//
//$Recs:=Records in selection([Bridge MHD NBIS])
//
//CONFIRM("Update Item 97 of "+String($Recs;"##,##0")+" record(s) to 2000 ?")
//If (OK=1)
//FIRST RECORD([Bridge MHD NBIS])
//For ($i;1;$Recs)
//[Bridge MHD NBIS]Item97:=2000
//SAVE RECORD([Bridge MHD NBIS])
//NEXT RECORD([Bridge MHD NBIS])
//If ($i%10=0)  `Don't slow down things just to display
//GOTO XY(1;1)
//MESSAGE("Record "+String($i)+" of "+String($Recs))
//End if 
//End for 
//ALERT("Updated "+String($Recs)+" total selected records")
//End if 