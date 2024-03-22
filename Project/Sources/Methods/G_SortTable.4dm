//%attributes = {"invisible":true}
// G_SortTable
// Sort a tables field names in alphabetical order

// $1 : table name (string)
If (False:C215)
	Mods_2012_12  //r001 ` Add code to allow for deleted fields 
	//Reversed for loop so we can delete from arrays
	//Modified by: Charles Miller (12/20/12 15:05:08)
End if 
C_TEXT:C284($tname)  // Command Replaced was o_C_STRING length was 60

$tname:=$1

C_LONGINT:C283($tsize; $i; $tnum)
// find table number of [Bridge MHD NBIS]
$tnum:=0
$tsize:=Get last table number:C254
ARRAY TEXT:C222($asTableName; $tsize)  //Command Replaced was o_ARRAY string length was 31
ARRAY INTEGER:C220($aiTableNumber; $tsize)
For ($i; 1; $tsize)
	$asTableName{$i}:=Table name:C256($i)  // Get the name of the table
	$aiTableNumber{$i}:=$i  // Store the actual table number  
	If (Table name:C256($i)=$tname)
		$tnum:=$i
		// exit loop
		//$i:=$tsize+1
	End if 
End for 

If ($tnum=0)
	ALERT:C41("Could not find table : "+$tname)
Else 
	$tsize:=Get last field number:C255($tnum)
	ARRAY TEXT:C222($asFieldNames; $tsize)  //Command Replaced was o_ARRAY string length was 31
	ARRAY INTEGER:C220($aiFieldNums; $tsize)
	For ($i; $tsize; 1; -1)  //reverse so we can delete unuse elements
		If (Is field number valid:C1000($tnum; $i))
			$asFieldNames{$i}:=sFriendlyName(Field name:C257($tnum; $i))  // Get the name of the field and make it friendly...
			$aiFieldNums{$i}:=$i  // Store the actual field number  
		Else 
			DELETE FROM ARRAY:C228($asFieldNames; $i)
			DELETE FROM ARRAY:C228($aiFieldNums; $i)
		End if 
		// sort field in ascending order
		SORT ARRAY:C229($asFieldNames; $aiFieldNums; >)
		SET FIELD TITLES:C602(Table:C252($tnum)->; $asFieldNames; $aiFieldNums)
	End for 
	
	SORT ARRAY:C229($asTableName; $aiTableNumber; >)
	SET TABLE TITLES:C601($asTableName; $aiTableNumber)
End if 