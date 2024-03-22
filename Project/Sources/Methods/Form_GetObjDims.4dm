//%attributes = {"invisible":true}
//Method: Form_GetObjDims
//Description
// Get the dimenstions of an object on a form. meant to be called outside of form execution.
// Can be a table or project (no table pointer) form. Can pass a pointer to a form variable or name of an object
// Parameters
// $1 : $InfoObject_o
// Input Attributes : "TablePointer", "FormName", "VarName", "VarPointer"
// Return Attributes : "Name","Width", "Height", "Left", "Top", "Right","Bottom"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/20, 15:57:13
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02_bug
	
	C_OBJECT:C1216(Form_GetObjDims; $1)
	
End if 
//
C_OBJECT:C1216($1)

C_LONGINT:C283($TableNum)
C_TEXT:C284($FormName; $varname)
C_POINTER:C301($TablePtr; $varPtr)

$TablePtr:=OB Get:C1224($1; "TablePointer"; Is pointer:K8:14)
$FormName:=OB Get:C1224($1; "FormName"; Is text:K8:3)
$varname:=OB Get:C1224($1; "VarName"; Is text:K8:3)
$varPtr:=OB Get:C1224($1; "VarPointer"; Is pointer:K8:14)

C_LONGINT:C283($objloop_L; $pw; $Ph; $ObjL; $ObjT; $ObjR; $ObjB)
ARRAY TEXT:C222($Forms_atxt; 0)
C_LONGINT:C283($FormIndx)
If (Not:C34(Is nil pointer:C315($TablePtr)))
	FORM GET NAMES:C1167($TablePtr->; $Forms_atxt)
Else 
	FORM GET NAMES:C1167($Forms_atxt)
End if 

$FormIndx:=Find in array:C230($Forms_atxt; $FormName)

If ($FormIndx>0)
	
	If (Not:C34(Is nil pointer:C315($TablePtr)))
		FORM LOAD:C1103($TablePtr->; $FormName)
	Else 
		FORM LOAD:C1103($FormName)
	End if 
	
	ARRAY TEXT:C222($objects_atxt; 0)
	ARRAY POINTER:C280($vars_aptr; 0)
	FORM GET OBJECTS:C898($objects_atxt; $vars_aptr)
	C_BOOLEAN:C305($FoundIt)
	$FoundIt:=False:C215
	For ($objloop_L; 1; Size of array:C274($objects_atxt))
		
		If ($varname#"")
			//search by name
			$FoundIt:=($objects_atxt{$objloop_L}=$varname)
		Else 
			//search by pointer
			$FoundIt:=($vars_aptr{$objloop_L}=$varPtr)
		End if 
		
		If ($FoundIt)
			OBJECT GET COORDINATES:C663(*; $objects_atxt{$objloop_L}; $ObjL; $ObjT; $ObjR; $ObjB)
			$pw:=$ObjR-$ObjL
			$Ph:=$ObjB-$ObjT
			OB SET:C1220($1; "Width"; $pw; "Height"; $Ph; "Name"; $objects_atxt{$objloop_L}; \
				"Left"; $ObjL; "Top"; $ObjT; "Right"; $ObjR; "Bottom"; $ObjB)
			$objloop_L:=Size of array:C274($objects_atxt)+1  //exit loop
		End if 
		
	End for 
	
	FORM UNLOAD:C1299
	
Else 
	OB SET:C1220($1; "ErrorMessage"; "Requested form "+$FormName+" not found!")
End if 

//End Form_GetObjDims