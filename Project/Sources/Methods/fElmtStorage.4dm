//%attributes = {"invisible":true}
If (False:C215)
	//fElmtStorage
	//Function to calculate the storage requirement for 
	//Element Comments of the current Inspection.
	//Created : May 2002
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 13:28:34)
	Mods_2006_CM03
End if 

C_LONGINT:C283($0)
$0:=0
//check if there is a current inspection record
If ([Inspections:27]InspID:2>0)
	//save current selections of elements 
	//COPY NAMED SELECTION([Inspections];"InspsInUse")
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsInUse")
	COPY NAMED SELECTION:C331([Standard Photos:36]; "PicsInUse")
	//get all the related elmts 
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
	C_LONGINT:C283($vElmtsSize; $i; $n)
	QUERY SELECTION BY FORMULA:C207([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)
	
	$n:=Records in selection:C76([ElementsSafety:29])
	$vElmtsSize:=0
	FIRST RECORD:C50([ElementsSafety:29])
	For ($i; 1; $n)
		$vElmtsSize:=$vElmtsSize+BLOB size:C605([ElementsSafety:29]ElmComments:23)
		NEXT RECORD:C51([ElementsSafety:29])
	End for 
	//set result
	$0:=$vElmtsSize
	
	//reset Elements selection
	USE NAMED SELECTION:C332("ElmtsInUse")
	CLEAR NAMED SELECTION:C333("ElmtsInUse")
	USE NAMED SELECTION:C332("PicsInUse")
	CLEAR NAMED SELECTION:C333("PicsInUse")
	//USE NAMED SELECTION("InspsInUse")
	//CLEAR NAMED SELECTION("InspsInUse")
End if 