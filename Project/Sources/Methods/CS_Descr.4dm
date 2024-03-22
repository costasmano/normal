//%attributes = {"invisible":true}
//GP CS_Descr
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Returns a string joining the Condition State Descriptions
//and the Condition State Notes.

C_TEXT:C284($Descr; $0)
C_LONGINT:C283($NoRecs; $i)  //Command Replaced was o_C_INTEGER

ORDER BY:C49([Cond States:51]; [Cond States:51]Cond State No:3)
ORDER BY:C49([CS Notes:53]; [CS Notes:53]CS Note ID:1)

$Descr:=""

For ($i; 1; Records in selection:C76([Cond States:51]))
	$Descr:=$Descr+[Cond States:51]Cond State No:3+"     "
	$Descr:=$Descr+[Cond States:51]Cond State Desc:4+Char:C90(13)+Char:C90(13)
	NEXT RECORD:C51([Cond States:51])
End for 

$NoRecs:=Records in selection:C76([CS Notes:53])
If ($NoRecs>0)
	$Descr:=$Descr+Char:C90(13)+"NOTES:"+Char:C90(13)+Char:C90(13)
	
	For ($i; 1; $NoRecs)
		$Descr:=$Descr+"•     "+[CS Notes:53]CS Note:2+Char:C90(13)+Char:C90(13)
		NEXT RECORD:C51([CS Notes:53])
	End for 
End if 

$0:=$Descr