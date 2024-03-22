//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/30/13, 10:59:47
//----------------------------------------------------
//Method: clone_DeleteSelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_POINTER:C301($1)
C_TEXT:C284($TableName_txt)
$TableName_txt:=Table name:C256($1)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)

If (Read only state:C362($1->)=True:C214)
	UNLOAD RECORD:C212($1->)
	READ WRITE:C146($1->)
	LOAD RECORD:C52($1->)
End if 
CLEAR SET:C117("LockedSet")
USE SET:C118("ToBeDeletedSet")
If (Records in selection:C76($1->)=1)
	DELETE RECORD:C58($1->)
	If (Records in set:C195("LockedSet")>0)
		USE SET:C118("LockedSet")
	End if 
Else 
	Repeat 
		DELETE SELECTION:C66($1->)
		
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
		End if 
	Until (Records in set:C195("LockedSet")=0)
End if 
CLEAR SET:C117("ToBeDeletedSet")





//End clone_DeleteSelection