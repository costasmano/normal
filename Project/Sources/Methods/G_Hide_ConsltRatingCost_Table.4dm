//%attributes = {"invisible":true}
If (False:C215)
	//G_Hide_ConsltRatingCost
	//If the current user belongs to authorized group, display Conslt Rating Cost tabl
	//If not, do not display the table 
End if 

C_BOOLEAN:C305($authUser)
$authUser:=(User in group:C338(Current user:C182; "Conslt Rating - ReadOnly") | User in group:C338(Current user:C182; "Conslt Rating - ReadWrite"))

C_LONGINT:C283($i; $nTables; $j)

$nTables:=Get last table number:C254
ARRAY TEXT:C222($asTableName; 0)  //Command Replaced was o_ARRAY string length was 31
ARRAY INTEGER:C220($aiTableNumber; 0)

$j:=0
For ($i; 1; $nTables)
	If (Not:C34((Table name:C256($i)="Conslt Rating Cost") & Not:C34($authUser)))
		//show the table    
		$j:=$j+1
		INSERT IN ARRAY:C227($asTableName; $j; 1)
		INSERT IN ARRAY:C227($aiTableNumber; $j; 1)
		
		$asTableName{$j}:=Table name:C256($i)  // Get the name of the table
		$aiTableNumber{$j}:=$i  // Store the actual table number  		
	End if 
End for 

SORT ARRAY:C229($asTableName; $aiTableNumber; >)
SET TABLE TITLES:C601($asTableName; $aiTableNumber)




