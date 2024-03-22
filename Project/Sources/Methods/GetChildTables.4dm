//%attributes = {"invisible":true}
//Method: GetChildTables
//Description
// retrieve child tables related to a field on a table
// Parameters
// $1 : $params_o : object containing input parameters and output paramaters
// attributes  : 
//  // "parentfield" : pointer to parent field
//  // "childTables" : pointer to array of pointers. filled with pointers to children field
//  // "showprogress" : show progress bar (boolean)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/15/18, 13:57:11
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	
	C_OBJECT:C1216(GetChildTables; $1)
	
End if 
//
C_OBJECT:C1216($1; $params_o)
$params_o:=$1
C_POINTER:C301($ParentFld_ptr; $ChildTables_ptr)
C_BOOLEAN:C305($showProgress_b)

$ParentFld_ptr:=OB Get:C1224($params_o; "parentfield"; Is pointer:K8:14)
$ChildTables_ptr:=OB Get:C1224($params_o; "childTables"; Is pointer:K8:14)
$showProgress_b:=OB Get:C1224($params_o; "showprogress"; Is boolean:K8:9)

C_LONGINT:C283($numTables_L; $numFields_L; $OneTable_L; $oneField_L; $Fields_L; $Tables_L)

C_LONGINT:C283($ParentTable_L; $parentField_L)
$ParentTable_L:=Table:C252($ParentFld_ptr)
$parentField_L:=Field:C253($ParentFld_ptr)

$numTables_L:=Get last table number:C254
If ($showProgress_b)
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Scanning tables"; $numTables_L; False:C215; " table"; 3)
	
End if 

ARRAY POINTER:C280($ChildTables_ptr->; 0)
For ($Tables_L; 1; $numTables_L)
	//update progress
	If ($showProgress_b)
		UpdateProgressNew($progress_o; $Tables_L)
		
	End if 
	
	If (Is table number valid:C999($Tables_L))
		If ($Tables_L#$ParentTable_L)
			$numFields_L:=Get last field number:C255($Tables_L)
			If ($showProgress_b)
				//start the bar
				C_OBJECT:C1216($progressfield_o)
				$progressfield_o:=ProgressNew("Scanning Fields"; $numFields_L; False:C215; " Field"; 3)
				
			End if 
			
			For ($Fields_L; 1; $numFields_L)
				If (Is field number valid:C1000($Tables_L; $Fields_L))
					If ($showProgress_b)
						//update progress
						UpdateProgressNew($progressfield_o; $Fields_L)
						
					End if 
					GET RELATION PROPERTIES:C686($Tables_L; $Fields_L; $OneTable_L; $oneField_L)
					If ($OneTable_L=$ParentTable_L) & ($oneField_L=$parentField_L)
						APPEND TO ARRAY:C911($ChildTables_ptr->; Field:C253($Tables_L; $Fields_L))
					End if 
				End if 
				
			End for 
			If ($showProgress_b)
				//quit progress
				Progress QUIT(OB Get:C1224($progressfield_o; "progress"; Is longint:K8:6))
				
			End if 
			
		End if 
		
	End if 
	
End for 

//quit progress
If ($showProgress_b)
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
End if 

//End GetChildTables