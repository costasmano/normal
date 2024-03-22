//%attributes = {"invisible":true}
If (False:C215)
	//fPictStorage
	//Function to calculate the total storage used for all
	//the standard images of the current Inspection.
	//Created : May 2002
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 13:28:34)
	Mods_2006_CM03
End if 

C_LONGINT:C283($0)
$0:=0
//check if there is a current inspection record
If ([Inspections:27]InspID:2>0)
	//save current selections of images
	//COPY NAMED SELECTION([Inspections];"InspsInUse")
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsInUse")
	COPY NAMED SELECTION:C331([Standard Photos:36]; "PicsInUse")
	
	//get all the related elmts and pictures
	G_Insp_RelateInsp(->[Standard Photos:36]InspID:1)
	C_LONGINT:C283($vPicSize; $i; $n)
	//QUERY SELECTION BY FORMULA([Standard Photos];Picture size([Standard Photos]Std Photo)>0)
	$n:=Records in selection:C76([Standard Photos:36])
	$vPicSize:=0
	FIRST RECORD:C50([Standard Photos:36])
	For ($i; 1; $n)
		$vPicSize:=$vPicSize+Picture size:C356([Standard Photos:36]Std Photo:3)
		NEXT RECORD:C51([Standard Photos:36])
	End for 
	//set the result
	$0:=$vPicSize
	
	//reset selections
	USE NAMED SELECTION:C332("ElmtsInUse")
	CLEAR NAMED SELECTION:C333("ElmtsInUse")
	USE NAMED SELECTION:C332("PicsInUse")
	CLEAR NAMED SELECTION:C333("PicsInUse")
	//USE NAMED SELECTION("InspsInUse")
	//CLEAR NAMED SELECTION("InspsInUse")
End if 