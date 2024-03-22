//%attributes = {"invisible":true}
If (False:C215)
	//fInspSize
	//Function to calculate the total size of the current Inspection.
	//Will add up size of Blobs and pictures associated with it.
	//Created : May 2002
End if 

C_LONGINT:C283($0)
$0:=0
C_LONGINT:C283($vElmtsSize; $vPicSize; $vCmtsSize)
$vElmtsSize:=fElmtStorage
$vPicSize:=fPictStorage
$vCmtsSize:=BLOB size:C605([Inspections:27]InspComments:171)

$0:=$vCmtsSize+$vPicSize+$vElmtsSize