//%attributes = {"invisible":true}
//Method: PON_VerifyElementForExport
//Description
// verify an element if it is ok to export for FHWA submission. 
// Parameters
// $1 : $ParamObject_o
// object attributes (-> : input, <- : output)
//  // -> <- "elemkey" : element key to check - on return it will be updated with the correct key 
//  // -> <- "parentkey" : parent key to check - on return it will be updated with the correct key 
//  // <- "error" 0:no error; 1:element not found; 
//  //  // 2:elemrollup not found; 3:parentnotfound; 4:parentrollup not found 
//  //  // 5:elem not reportable ; 6: parent not reportable
//  //  // 7:elem not allowed as a prot sys for parent
//  // <- "errortxt" explanation of error 
//  // <- "reported" true or false
//  // -> "Keylist" : pointer to array of keys from element defs
//  // -> "rollupkeys" : pointer to array of roll up keys from element defs
//  // -> "reportables" : pointer to array of reported_txt = Y or N
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/09/18, 14:43:40
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	
	C_OBJECT:C1216(PON_VerifyElementForExport; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(3/2/21 18:44:04)
	Mods_2021_03
	//  `added check to verify that protective system is allowed for the parent.
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
End if 
//
C_OBJECT:C1216($1; $ParamObject_o)
$ParamObject_o:=$1

C_LONGINT:C283($Elemkey_L; $ParentKey_L)
C_BOOLEAN:C305($reported_b)
C_LONGINT:C283($ElemKeyFinal_L; $ParentKeyFinal_L)

$Elemkey_L:=OB Get:C1224($ParamObject_o; "elemkey"; Is longint:K8:6)
$ParentKey_L:=OB Get:C1224($ParamObject_o; "parentkey"; Is longint:K8:6)

C_POINTER:C301($ElemKeysArr_ptr; $ElemReportedArr_ptr; $ElemSubsetArr_ptr)

$ElemKeysArr_ptr:=OB Get:C1224($ParamObject_o; "Keylist"; Is pointer:K8:14)
$ElemSubsetArr_ptr:=OB Get:C1224($ParamObject_o; "rollupkeys"; Is pointer:K8:14)
$ElemReportedArr_ptr:=OB Get:C1224($ParamObject_o; "reportables"; Is pointer:K8:14)

$ElemKeyFinal_L:=$Elemkey_L
$ParentKeyFinal_L:=$ParentKey_L

OB SET:C1220($ParamObject_o; "error"; 0)

C_LONGINT:C283($elemIndx_L; $parentIndx_L)
//check element first
$elemIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $Elemkey_L)
If ($elemIndx_L<0)
	//Element not found
	OB SET:C1220($ParamObject_o; "error"; 1)
	OB SET:C1220($ParamObject_o; "errortxt"; "Key "+String:C10($Elemkey_L)+" not found in definitions!")
	
Else 
	$ElemKeyFinal_L:=$Elemkey_L
	
	//does element have rollup?
	If ($ElemSubsetArr_ptr->{$elemIndx_L}>0)
		
		$ElemKeyFinal_L:=$ElemSubsetArr_ptr->{$elemIndx_L}
		//check if it exists
		C_LONGINT:C283($rollupIndx_L)
		$rollupIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $ElemSubsetArr_ptr->{$elemIndx_L})
		
		If ($rollupIndx_L<0)
			OB SET:C1220($ParamObject_o; "error"; 2)
			OB SET:C1220($ParamObject_o; "errortxt"; "Key "+String:C10($Elemkey_L)+" is a subset of key "+\
				String:C10($ElemSubsetArr_ptr->{$elemIndx_L})+" which not found in definitions!")
			
		End if 
		
	End if 
	
	If (OB Get:C1224($ParamObject_o; "error"; Is longint:K8:6)=0)
		//no errors - check parent
		If ($ParentKey_L>0)
			
			//check if parent exists
			$parentIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $ParentKey_L)
			
			If ($parentIndx_L<0)
				OB SET:C1220($ParamObject_o; "error"; 3)
				OB SET:C1220($ParamObject_o; "errortxt"; "Parent Key "+String:C10($ParentKey_L)+" not found in definitions!")
				
			Else 
				$ParentKeyFinal_L:=$ParentKey_L
				//is there a rollup for the parent?
				If ($ElemSubsetArr_ptr->{$parentIndx_L}>0)
					$ParentKeyFinal_L:=$ElemSubsetArr_ptr->{$parentIndx_L}
					$rollupIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $ElemSubsetArr_ptr->{$parentIndx_L})
					
					If ($rollupIndx_L<0)
						//roll up not found
						OB SET:C1220($ParamObject_o; "error"; 4)
						OB SET:C1220($ParamObject_o; "errortxt"; "Parent Key "+String:C10($ParentKey_L)+" is a subset of key "+\
							String:C10($ElemSubsetArr_ptr->{$parentIndx_L})+" which not found in definitions!")
					End if 
					
				End if 
				
			End if 
			
			//check if current element is a valid child of parent
			ARRAY LONGINT:C221($allowedProtsys_aL; 0)
			PON_FindAllowedProtSys($ParentKeyFinal_L; ->$allowedProtsys_aL)
			
			If (Find in array:C230($allowedProtsys_aL; $ElemKeyFinal_L)>0)
				//ok
			Else 
				//prot sys not in allowed list
				OB SET:C1220($ParamObject_o; "error"; 7)
				OB SET:C1220($ParamObject_o; "errortxt"; "Allowed protective systems for Parent Key "+String:C10($ParentKey_L)+" does not include "+\
					String:C10($ElemKeyFinal_L)+" !")
				
			End if 
			
		End if 
		
		If (OB Get:C1224($ParamObject_o; "error"; Is longint:K8:6)=0)
			//no errors - find if both final element key and final parent key are reportable
			$elemIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $ElemKeyFinal_L)
			$reported_b:=(($ElemReportedArr_ptr->{$elemIndx_L})="Y")
			
			If (Not:C34($reported_b))
				OB SET:C1220($ParamObject_o; "error"; 5)
				
				If ($ElemKeyFinal_L=$Elemkey_L)
					OB SET:C1220($ParamObject_o; "errortxt"; " Key "+String:C10($Elemkey_L)+" is not reportable!")
					
				Else 
					OB SET:C1220($ParamObject_o; "errortxt"; " Key "+String:C10($Elemkey_L)+" rolls up to Key "+\
						String:C10($ElemKeyFinal_L)+" which is not reportable!")
					
				End if 
				
			Else 
				
				If ($ParentKeyFinal_L>0)
					$parentIndx_L:=Find in array:C230($ElemKeysArr_ptr->; $ParentKeyFinal_L)
					//both must be reportable
					$reported_b:=$reported_b & (($ElemReportedArr_ptr->{$parentIndx_L})="Y")
					If (Not:C34($reported_b))
						OB SET:C1220($ParamObject_o; "error"; 6)
						
						If ($ParentKeyFinal_L=$ParentKey_L)
							OB SET:C1220($ParamObject_o; "errortxt"; "Parent Key "+String:C10($ParentKey_L)+" is not reportable!")
							
						Else 
							OB SET:C1220($ParamObject_o; "errortxt"; "Parent Key "+String:C10($ParentKey_L)+" rolls up to Key "+\
								String:C10($ParentKeyFinal_L)+" which is not reportable!")
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 

OB SET:C1220($ParamObject_o; "elemkey"; $ElemKeyFinal_L; "parentkey"; $ParentKeyFinal_L; "reported"; $reported_b)

//End PON_VerifyElementForExport