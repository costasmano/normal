//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/27/10, 10:20:38
	// ----------------------------------------------------
	// Method: ut_Read_Write_Tables
	// Description
	// Set tables to Read or Write
	// 
	// Parameters
	// $1 : Optoin ("READ" | "WRITE")
	// ${2} : list of Table pointers
	// ----------------------------------------------------
	
	Mods_2010_08
End if 
C_TEXT:C284($1)
C_POINTER:C301(${2})
C_LONGINT:C283($loop_L; $NumParams_L)
$NumParams_L:=Count parameters:C259
C_POINTER:C301($Tbl_ptr)
For ($loop_L; 2; $NumParams_L)
	$Tbl_ptr:=${$loop_L}
	Case of 
		: ($1="READ")
			READ ONLY:C145($Tbl_ptr->)
		: ($1="WRITE")
			READ WRITE:C146($Tbl_ptr->)
	End case 
	
End for 