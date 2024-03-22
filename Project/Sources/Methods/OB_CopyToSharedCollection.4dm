//%attributes = {"invisible":true}
//Method: OB_CopyToSharedCollection
//Description
// copy a collection to a shared collection
// Parameters
// $1:Collection to copy from
// $2:Shared Collection to copy to
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 14, 2023, 10:35:19
	
	// ----------------------------------------------------
	//Method:OB_CopyToSharedCollection
	//$1:Collection to copy from
	//$2:Shared Collection to copy to
	
	// Copied from tech tip https://kb.4d.com/assetid=78197
	// See comments in OB_CopyToSharedObject for use
	
	C_COLLECTION:C1488(OB_CopyToSharedCollection; $1; $2)
End if 
//

C_COLLECTION:C1488($1; $2)
C_LONGINT:C283($counter)

For ($counter; 0; $1.length-1)
	Case of 
		: (Value type:C1509($1[$counter])=Is object:K8:27)
			$2[$counter]:=New shared object:C1526
			Use ($2[$counter])
				//Element type is object, copy with OB_CopyToSharedObject
				OB_CopyToSharedObject($1[$counter]; $2[$counter])
			End use 
		: (Value type:C1509($1[$counter])=Is collection:K8:32)
			//Element type is collection, copy with OB_CopyToSharedCollection 
			$2[$counter]:=New shared collection:C1527
			Use ($2[$counter])
				OB_CopyToSharedCollection($1[$counter]; $2[$counter])
			End use 
		Else 
			// Other supported types can be copied directly.
			$2[$counter]:=$1[$counter]
	End case 
End for 
//End OB_CopyToSharedCollection   