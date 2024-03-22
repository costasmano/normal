//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_RelateInsp 
	//Retrieve Related records 
	
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(3/5/09 09:08:12)
	Mods_2009_CM_5404
	//Modified parameter declarations to use the 'indirection'
	Mods_2011_06  // CJ Miller`06/14/11, 10:44:29      ` Type all local variables for v11
End if 

C_POINTER:C301(${1})
C_POINTER:C301($vpRelatedFld)
C_LONGINT:C283($CurrInspID; $TableNo; $i)
$CurrInspID:=[Inspections:27]InspID:2

For ($i; 1; Count parameters:C259)
	$vpRelatedFld:=${$i}
	$TableNo:=Table:C252($vpRelatedFld)
	QUERY:C277(Table:C252($TableNo)->; $vpRelatedFld->=$CurrInspID)
	UNLOAD RECORD:C212(Table:C252($TableNo)->)
End for 