//%attributes = {"invisible":true}
//GP AllInOneCS
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_BOOLEAN:C305($SetQuant)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

//The Total Quantity must be in one and only one Condition State. 
//Place the value in the worst, non-zero CS.  For a new record,
//the default will be CS #1.
$SetQuant:=True:C214
For ($i; vNoCSs; 1; -1)
	If (($SetQuant) & ((aCS{$i}>0) | ($i=1)))
		aCS{$i}:=[Cond Units:45]Total Quantity:5
		$SetQuant:=False:C215
	Else   //(Not($SetQuant)) | ((aCS{$i}=0) & ($i>1))
		aCS{$i}:=0
	End if 
End for 