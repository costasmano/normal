//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ResetSecondaryNBISItem8
// User name (OS): charlesmiller
// Date and time: 03/04/10, 12:00:39
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_03  //r002 CJ Miller`03/04/10, 12:00:41      `
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
START TRANSACTION:C239
READ WRITE:C146([NBIS Secondary:3])

ALL RECORDS:C47([NBIS Secondary:3])
READ ONLY:C145([Bridge MHD NBIS:1])

ARRAY TEXT:C222($Report_atxt; 0)
ARRAY TEXT:C222($Report_atxt; 1)
$Records_l:=Records in selection:C76([NBIS Secondary:3])
C_LONGINT:C283($Loop_l; $Records_l; $Size_l)
$Size_l:=1
For ($Loop_l; 1; $Records_l)
	If (Length:C16($Report_atxt{$Size_l})>30000)
		APPEND TO ARRAY:C911($Report_atxt; "")
		$Size_l:=$Size_l+1
	End if 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[NBIS Secondary:3]BIN:1)
	If (Records in selection:C76([Bridge MHD NBIS:1])=1)
		
		If (ut_LoadRecordInteractive(->[NBIS Secondary:3]))
			If ([NBIS Secondary:3]Item8:38=[Bridge MHD NBIS:1]Item8:206)
				$Report_atxt{$Size_l}:=$Report_atxt{$Size_l}+"No change in  item 8 "+[NBIS Secondary:3]Item8:38+" to "+[Bridge MHD NBIS:1]Item8:206+" for "+[NBIS Secondary:3]BIN:1+Char:C90(Carriage return:K15:38)
			Else 
				$Report_atxt{$Size_l}:=$Report_atxt{$Size_l}+"Changing item 8 from "+[NBIS Secondary:3]Item8:38+" to "+[Bridge MHD NBIS:1]Item8:206+" for "+[NBIS Secondary:3]BIN:1+Char:C90(Carriage return:K15:38)
				[NBIS Secondary:3]Item8:38:=[Bridge MHD NBIS:1]Item8:206
				
			End if 
			
		End if 
	Else 
		
		$Report_atxt{$Size_l}:=$Report_atxt{$Size_l}+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" [Bridge MHD NBIS] records for bin "+[NBIS Secondary:3]BIN:1+Char:C90(Carriage return:K15:38)
	End if 
	If (Modified record:C314([NBIS Secondary:3]))
		SAVE RECORD:C53([NBIS Secondary:3])
	End if 
	NEXT RECORD:C51([NBIS Secondary:3])
End for 
UNLOAD RECORD:C212([NBIS Secondary:3])
C_TIME:C306($doc)
$doc:=Create document:C266("")

For ($Loop_l; 1; $Size_l)
	SEND PACKET:C103($doc; $Report_atxt{$Loop_l})
End for 

CLOSE DOCUMENT:C267($doc)
//End ut_ResetSecondaryNBISItem8