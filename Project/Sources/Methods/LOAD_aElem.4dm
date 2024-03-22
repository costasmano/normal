//%attributes = {"invisible":true}
If (False:C215)
	
	//GP LOAD_aElem
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	// Modified by: costasmanousakis-(Designer)-(9/14/05 12:51:57)
	Mods_2005_CM17
End if 

C_BOOLEAN:C305(vLaElem)
C_LONGINT:C283($NoElem; $i)

ALL RECORDS:C47([BMS Elements:47])
SELECTION TO ARRAY:C260([BMS Elements:47]Element ID:1; aElemID; [BMS Elements:47]Element No:2; aElemNo; [BMS Elements:47]Element Name:3; aElemName; [BMS Categories:49]General Cat:2; aGenCat; [BMS Categories:49]Subcategory:3; aSubCat; [BMS Elements:47]Element Type:4; aElemType)
$NoElem:=Size of array:C274(aElemID)
ARRAY TEXT:C222(aElem; $NoElem)  //Command Replaced was o_ARRAY string length was 106
REDUCE SELECTION:C351([BMS Elements:47]; 0)

For ($i; 1; $NoElem)
	//This loop does for all elements what GP LongName does for one element.  
	//     Element Name (never blank)
	//     General Category (rarely blank (1 instance))
	//     Subcategory (sometimes blank)
	//     Element Type (usually blank)
	aElem{$i}:=String:C10(aElemNo{$i})+" - "+aElemName{$i}  //This should never be blank.
	If (aGenCat{$i}#"")
		If (Position:C15("["; aGenCat{$i})>0)
			aGenCat{$i}:=Substring:C12(aGenCat{$i}; 1; (Position:C15("["; aGenCat{$i})-1))
			aGenCat{$i}:=f_TrimStr(aGenCat{$i}; True:C214; True:C214)
		End if 
		aElem{$i}:=aElem{$i}+", "+aGenCat{$i}
	End if 
	If (aSubCat{$i}#"")
		aElem{$i}:=aElem{$i}+", "+aSubCat{$i}
	End if 
	If (aElemType{$i}#"")
		aElem{$i}:=aElem{$i}+", "+aElemType{$i}
	End if 
End for 

SORT ARRAY:C229(aElemNo; aElemID; aElem)

//aElem has been loaded.
//It is not necessary to load it again until there is a change in [BMS Elements].
vLaElem:=False:C215