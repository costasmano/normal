//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/11, 09:53:03
	// ----------------------------------------------------
	// Method: ut_UpdateEmployerList
	// Description
	// Uodate and Clean up the Employers list
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
ARRAY TEXT:C222($avTAgency; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($avTEmployer; 0)  //Command Replaced was o_ARRAY string length was 80
C_LONGINT:C283($loop_L; $arraySize_L)
C_BOOLEAN:C305($PersRO_b)

LIST TO ARRAY:C288("Employers"; $avTAgency)
For ($loop_L; 1; Size of array:C274($avTAgency))
	$avTAgency{$loop_L}:=f_TrimStr($avTAgency{$loop_L}; True:C214; True:C214)
	$avTAgency{$loop_L}:=Replace string:C233($avTAgency{$loop_L}; "  "; " ")
End for 

$PersRO_b:=Read only state:C362([Personnel:42])
READ ONLY:C145([Personnel:42])
ALL RECORDS:C47([Personnel:42])
DISTINCT VALUES:C339([Personnel:42]Employer:9; $avTEmployer)
If (Not:C34($PersRO_b))
	READ WRITE:C146([Personnel:42])
End if 
For ($loop_L; 1; Size of array:C274($avTEmployer))
	$avTEmployer{$loop_L}:=f_TrimStr($avTEmployer{$loop_L}; True:C214; True:C214)
	$avTEmployer{$loop_L}:=Replace string:C233($avTEmployer{$loop_L}; "  "; " ")
	If (Length:C16(Replace string:C233($avTEmployer{$loop_L}; " "; ""))>0)
		If (Find in array:C230($avTAgency; $avTEmployer{$loop_L})<0)
			APPEND TO ARRAY:C911($avTAgency; $avTEmployer{$loop_L})
		End if 
	End if 
End for 

SORT ARRAY:C229($avTAgency)
//Clean Duplicates
$arraySize_L:=Size of array:C274($avTAgency)
For ($loop_L; $arraySize_L; 2; -1)
	If ($avTAgency{$loop_L}=$avTAgency{$loop_L-1})
		DELETE FROM ARRAY:C228($avTAgency; $loop_L)
	End if 
End for 

ARRAY TO LIST:C287($avTAgency; "Employers")