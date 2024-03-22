//%attributes = {"invisible":true}
//Method: INSP_FieldClr_OM
//Description
// object method for the field clearance values. ajusted to account for zero entered in one
// of the measurements
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/09/15, 16:37:09
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11_bug
End if 
//
//calculate the MIN field clearance
C_REAL:C285($r1; $r2)

$r1:=[Inspections:27]NEClrFldFT:50+([Inspections:27]NEClrFldIN:51/12)
$r2:=[Inspections:27]SWClrFldFT:160+([Inspections:27]SWClrFldIN:161/12)

If ((([Inspections:27]NEClrFldFT:50+[Inspections:27]NEClrFldIN:51)=0) | (([Inspections:27]SWClrFldFT:160+[Inspections:27]SWClrFldIN:161)=0))
	[Inspections:27]ClrMinM:164:=MaxNum($r1; $r2)*0.3048
Else 
	[Inspections:27]ClrMinM:164:=MinNum($r1; $r2)*0.3048
End if 

PushChange(1; ->[Inspections:27]ClrMinM:164)
PushChange(1; Self:C308)
//End INSP_FieldClr_OM