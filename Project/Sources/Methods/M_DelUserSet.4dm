//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_DelUserSet
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Deletes the records highlighted by user.
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($LRecsInSet)
$LRecsInSet:=Records in set:C195("UserSet")
If ($LRecsInSet>0)
	CONFIRM:C162("Delete the "+String:C10($LRecsInSet)+" highlighted records?")
	If (OK=1)  //If user clicked OK in the Confirm dialog box.
		CREATE SET:C116(pFile->; "OriginalSelSet")
		USE SET:C118("UserSet")  //Changes current selection to highlighted recs.
		DELETE SELECTION:C66(pFile->)  //Reduces current selection to none.
		//Restores the original selection less those deleted
		CLEAR SET:C117("OriginalSelSet")
		WindowTitle
	End if 
Else 
	ALERT:C41("You must first Highlight Records to delete!")
End if 
//End of procedure