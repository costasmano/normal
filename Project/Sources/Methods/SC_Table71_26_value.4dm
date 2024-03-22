//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:06:33
	// ----------------------------------------------------
	// Method: SC_Table71_26_value
	// Description
	// Get the value from table 71_26
	// 
	// Parameters
	// $1 : $i71_txt
	// $2 : $i26_txt
	
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $i71_txt; $2; $i26_txt; $0; $value)
$i71_txt:=$1
$i26_txt:=$2
$value:=""
C_LONGINT:C283($i71_L; $i26_L)
$i71_L:=Find in array:C230(SC_TBL71vs26_colH_atxt; $i71_txt)
If ($i71_L>0)
	SC_ParseTBLLine(SC_TBL71vs26_Cols_atxt{$i71_L})
	$i26_L:=Find in array:C230(sc_TempIndx_atxt; ("@,"+$i26_txt+",@"))
	If ($i26_L>0)
		$value:=sc_TempVal_atxt{$i26_L}
	End if 
End if 

$0:=$value