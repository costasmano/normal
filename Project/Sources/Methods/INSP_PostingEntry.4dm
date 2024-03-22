//%attributes = {"invisible":true}
//Method: INSP_PostingEntry
//Description
// Called from on data change event of obj method of [Inspections]ActualPostxxx objects
// handle clearing single posting when H,3,3s2 are non-zero, and vice versa
// replaces the call to PushChange in the object methods

// Parameters
// $1 $changestack
// $2 $currobj_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Bridge Section
	//User (4D) : Designer
	//Date and time: 10/26/18, 14:15:33
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	
	C_LONGINT:C283(INSP_PostingEntry; $1)
	C_POINTER:C301(INSP_PostingEntry; $2)
	
End if 
//

C_POINTER:C301($2)
C_LONGINT:C283($1)

C_POINTER:C301($currobj_ptr; $TypeH_ptr; $Type3_ptr; $Type3S2_ptr; $Single_ptr)
C_LONGINT:C283($changestack)
$currobj_ptr:=$2
$changestack:=$1

If (Form event code:C388=On Data Change:K2:15)
	
	PushChange($changestack; $currobj_ptr)
	
	If (WP_H_s="H")  //this indicates that we are doing H,3,3S2 and Single postings
		
		//this only applies when the postings are  H,3,3S2 and Single
		Case of 
			: (($currobj_ptr=(->[Inspections:27]ActualPostH:26)) | \
				($currobj_ptr=(->[Inspections:27]ActualPost3:27)) | \
				($currobj_ptr=(->[Inspections:27]ActualPost3S2:28)) | \
				($currobj_ptr=(->[Inspections:27]ActualPostSgl:29)))
				$TypeH_ptr:=->[Inspections:27]ActualPostH:26
				$Type3_ptr:=->[Inspections:27]ActualPost3:27
				$Type3S2_ptr:=->[Inspections:27]ActualPost3S2:28
				$Single_ptr:=->[Inspections:27]ActualPostSgl:29
				
			: (($currobj_ptr=(->[Inspections:27]RecomPosting3:32)) | \
				($currobj_ptr=(->[Inspections:27]RecomPosting3S2:33)) | \
				($currobj_ptr=(->[Inspections:27]RecomPostingH:31)) | \
				($currobj_ptr=(->[Inspections:27]RecomPostingSgl:34)))
				$Type3_ptr:=->[Inspections:27]RecomPosting3:32
				$Type3S2_ptr:=->[Inspections:27]RecomPosting3S2:33
				$TypeH_ptr:=->[Inspections:27]RecomPostingH:31
				$Single_ptr:=->[Inspections:27]RecomPostingSgl:34
				
		End case 
		
		If ($currobj_ptr=$Single_ptr)
			//change made in the Single posting box
			If (($currobj_ptr->)>0)
				//zero out the other fields
				$TypeH_ptr->:=0
				$Type3_ptr->:=0
				$Type3S2_ptr->:=0
				PushChange($changestack; $TypeH_ptr)
				PushChange($changestack; $Type3_ptr)
				PushChange($changestack; $Type3S2_ptr)
				
			End if 
			
		Else 
			//change made in other posting boxes
			If (($currobj_ptr->)>0)
				//zero out the single posting
				$Single_ptr->:=0
				PushChange($changestack; $Single_ptr)
				
			End if 
		End if 
		
	End if 
	
End if 


//End INSP_PostingEntry