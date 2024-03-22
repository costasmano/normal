//%attributes = {"invisible":true}
//Method: FORM_HideEnclosedObjs
//Description
// hide - make invisible objects within a rect defined by passed obj name
// either in page of object (for input forms) or all pages (print forms)
// can check if either the top left "TopLeft", or completely in "IN", or crossing ("Cross") of each object
// is within the master obj rectangle
// Parameters
// $1 : $BoundBoxName_txt
// $2 : $Pageopt_L (Constants Form all pages or Form current page
// $3 : $Option (Optional "TopLeft" (default) "IN" "Cross" )
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/03/19, 14:12:06
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
	
	C_TEXT:C284(FORM_HideEnclosedObjs; $1)
	C_LONGINT:C283(FORM_HideEnclosedObjs; $2)
	C_TEXT:C284(FORM_HideEnclosedObjs; $3)
	
End if 
//
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($Option)
$Option:="TopLeft"
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$Option:=$3
	
	Case of 
		: ($Option="TopLeft")
		: ($Option="IN")
		: ($Option="Cross")
		Else 
			//not valid option - default to topleft
			$Option:="TopLeft"
	End case 
	
End if 
ARRAY TEXT:C222($AllObjects_atxt; 0)
ARRAY POINTER:C280($AllObjects_aptr; 0)
ARRAY LONGINT:C221($ObjectPages_aL; 0)

FORM GET OBJECTS:C898($AllObjects_atxt; $AllObjects_aptr; $ObjectPages_aL; Form all pages:K67:7)

C_LONGINT:C283($BoxobjIndx_L)
$BoxobjIndx_L:=Find in array:C230($AllObjects_atxt; $1)
If ($BoxobjIndx_L>0)
	C_LONGINT:C283($BoxPage_L; $BoxL; $BoxT; $BoxR; $BoxB; $BoxPage)
	C_LONGINT:C283($ObjL; $ObjT; $ObjR; $ObjB)
	$BoxPage:=$ObjectPages_aL{$BoxobjIndx_L}
	OBJECT GET COORDINATES:C663(*; $1; $BoxL; $BoxT; $BoxR; $BoxB)
	OBJECT SET VISIBLE:C603(*; $1; False:C215)
	C_LONGINT:C283($obj_L)
	C_LONGINT:C283($loop_L)
	C_BOOLEAN:C305($L_b; $T_b; $R_b; $B_b; $Pass_b)
	For ($obj_L; 1; Size of array:C274($AllObjects_atxt))
		If (($ObjectPages_aL{$obj_L}=$BoxPage) & ($2=Form current page:K67:6)) | ($2=Form all pages:K67:7)
			
			OBJECT GET COORDINATES:C663(*; $AllObjects_atxt{$obj_L}; $ObjL; $ObjT; $ObjR; $ObjB)
			$L_b:=($ObjL>=$BoxL) & ($ObjL<=$BoxR)
			$T_b:=($ObjT>=$BoxT) & ($ObjT<=$BoxB)
			$R_b:=($ObjR>=$BoxL) & ($ObjR<=$BoxR)
			$B_b:=($ObjB>=$BoxT) & ($ObjB<=$BoxB)
			$Pass_b:=False:C215
			Case of 
				: ($Option="TopLeft")
					$Pass_b:=$L_b & $T_b
				: ($Option="IN")
					$Pass_b:=$L_b & $T_b & $R_b & $B_b
				: ($Option="Cross")
					$Pass_b:=($L_b & $T_b) | ($L_b & $B_b) | ($R_b & $T_b) | ($R_b & $B_b)
			End case 
			
			If ($Pass_b)
				OBJECT SET VISIBLE:C603(*; $AllObjects_atxt{$obj_L}; False:C215)
			End if 
			
		End if 
		
	End for 
	
End if 
//End FORM_HideEnclosedObjs