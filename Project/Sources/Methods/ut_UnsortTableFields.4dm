//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/11, 13:58:15
	// ----------------------------------------------------
	// Method: ut_UnsortTableFields
	// Description
	// Show Tables and fileds unsorted!
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 

SET CURSOR:C469(0)
SET CURSOR:C469(4)
C_LONGINT:C283($tsize; $i; $nTables; $j; $k)
$nTables:=Get last table number:C254
ARRAY TEXT:C222($asTableName; 0)  //Command Replaced was o_ARRAY string length was 31
ARRAY INTEGER:C220($aiTableNumber; 0)

For ($i; 1; $nTables)
	$j:=$j+1
	INSERT IN ARRAY:C227($asTableName; $j; 1)
	INSERT IN ARRAY:C227($aiTableNumber; $j; 1)
	
	$asTableName{$j}:=Table name:C256($i)  // Get the name of the table
	$aiTableNumber{$j}:=$i  // Store the actual table number  		
	$tsize:=Get last field number:C255($i)
	C_TEXT:C284($FieldName_s)  // Command Replaced was o_C_STRING length was 40
	//Sort only tables with more than 10 fields
	ARRAY TEXT:C222($asFieldNames; $tsize)  //Command Replaced was o_ARRAY string length was 31
	ARRAY INTEGER:C220($aiFieldNums; $tsize)
	For ($k; 1; $tsize)
		$FieldName_s:=Field name:C257($i; $k)
		$FieldName_s:=Replace string:C233($FieldName_s; "-"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "*"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "?"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "!"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "+"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "&"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "^"; " ")
		$FieldName_s:=Replace string:C233($FieldName_s; "#"; " ")
		
		$asFieldNames{$k}:=Substring:C12($FieldName_s; 1; 31)  // Get the name of the field and make it friendly...
		
		$aiFieldNums{$k}:=$k  // Store the actual field number  
	End for 
	// sort field in ascending order
	SET FIELD TITLES:C602(Table:C252($i)->; $asFieldNames; $aiFieldNums; *)
	
End for 

SET TABLE TITLES:C601($asTableName; $aiTableNumber; *)
ALERT:C41("Done!")
SET CURSOR:C469(0)