//%attributes = {"invisible":true}
//Method: ut_DisplayArray
//Description
//
// Parameters
// $1 : $arr_ptr
// $2 : $title_txt
// $3 : $colTitle_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/18/15, 15:07:39
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
	
	C_POINTER:C301(ut_DisplayArray; $1)
	C_TEXT:C284(ut_DisplayArray; $2)
	C_TEXT:C284(ut_DisplayArray; $3)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284(1_txt)
1_txt:=$3

ARRAY TEXT:C222(LBGeneric_atxt; 0)
Case of 
	: (Type:C295($1->)=String array:K8:15) | (Type:C295($1->)=Text array:K8:16)
		
		COPY ARRAY:C226($1->; LBGeneric_atxt)
	: (Type:C295($1->)=Integer array:K8:18) | (Type:C295($1->)=Real array:K8:17) | (Type:C295($1->)=LongInt array:K8:19) | (Type:C295($1->)=Date array:K8:20)
		ARRAY TEXT:C222(LBGeneric_atxt; Size of array:C274($1->))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
			LBGeneric_atxt{$loop_L}:=String:C10($1->{$loop_L})
		End for 
	: (Type:C295($1->)=Boolean array:K8:21)
		ARRAY TEXT:C222(LBGeneric_atxt; Size of array:C274($1->))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
			LBGeneric_atxt{$loop_L}:=Choose:C955($1->{$loop_L}; "True"; "False")
		End for 
	: (Type:C295($1->)=Picture array:K8:22)
		ARRAY TEXT:C222(LBGeneric_atxt; Size of array:C274($1->))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
			LBGeneric_atxt{$loop_L}:=String:C10(Picture size:C356($1->{$loop_L}); "###,###,###,###,###,###")
		End for 
	Else 
		1_txt:="Cannot Display data type "+fGetDataType(Type:C295($1->))
End case 
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; $2; "ut_CloseCancel")
DIALOG:C40("OneArrayLB")

CLOSE WINDOW:C154

ARRAY TEXT:C222(LBGeneric_atxt; 0)

//End ut_DisplayArray