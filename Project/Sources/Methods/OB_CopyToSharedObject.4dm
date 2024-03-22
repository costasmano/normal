//%attributes = {"invisible":true}
//Method: OB_CopyToSharedObject
//Description
// copy an object to a shared object
// Parameters
// $1: Object to copy from
// $2: Shared Object to copy to
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 14, 2023, 10:33:37
	
	// ----------------------------------------------------
	//
	//Method: OB_CopyToSharedObject
	//$1: Object to copy from
	//$2: Shared Object to copy to
	
	// Copied from tech tip https://kb.4d.com/assetid=78197
	// example :
	// $DatafromParameters:=json parse($mysystemParameter_txt)
	// Use (Storage)
	//  Storage.ParameterA:=New shared object
	//   Use (Storage.ParameterA)
	//   OB_CopyToSharedObject ($DatafromParameters;Storage.ParameterA)
	//  End use 
	// End use
	
	C_OBJECT:C1216(OB_CopyToSharedObject; $1; $2)
	
End if 

C_OBJECT:C1216($1; $2)
C_LONGINT:C283($counter)

ARRAY TEXT:C222($arrNames; 0)
OB GET PROPERTY NAMES:C1232($1; $arrNames; $arrTypes)
For ($counter; 1; Size of array:C274($arrNames))
	Case of 
			//Attribute type is object, copy with OB_CopyToSharedObject again
		: ($arrTypes{$counter}=Is object:K8:27)
			$2[$arrNames{$counter}]:=New shared object:C1526
			Use ($2[$arrNames{$counter}])
				OB_CopyToSharedObject($1[$arrNames{$counter}]; $2[$arrNames{$counter}])
			End use 
			//Attribute type is collection, copy with OB_CopyToSharedCollection
		: ($arrTypes{$counter}=Is collection:K8:32)
			$2[$arrNames{$counter}]:=New shared collection:C1527
			Use ($2[$arrNames{$counter}])
				OB_CopyToSharedCollection($1[$arrNames{$counter}]; $2[$arrNames{$counter}])
			End use 
		Else 
			// The rest supported types can be copied directly.
			$2[$arrNames{$counter}]:=$1[$arrNames{$counter}]
	End case 
End for 
//End OB_CopyToSharedObject   