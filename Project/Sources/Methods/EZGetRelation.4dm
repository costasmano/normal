//%attributes = {"invisible":true}
//GP EZGetRelation
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284($1; $sRelation)
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 2

$sRelation:=$1
Case of 
	: ($sRelation="Equal To")
		$0:="="
	: ($sRelation="Not Equal To")
		$0:="#"
	: ($sRelation="Less Than")
		$0:="<"
	: ($sRelation="Less Than or Equal To")
		$0:="<="
	: ($sRelation="Greater Than")
		$0:=">"
	: ($sRelation="Greater Than or Equal To")
		$0:=">="
	: ($sRelation="Starts With")
		$0:="="  //The calling procedure must supply the @ wildcard to the search text.
		
		//For the next two cases, the calling procedure must supply @ wildcards
		//to the beginning and ending of the search string.
	: ($sRelation="Contains")
		$0:="="
	: ($sRelation="Does Not Contain")
		$0:="#"
End case 