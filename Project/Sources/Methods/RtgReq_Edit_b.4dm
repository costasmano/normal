//%attributes = {"invisible":true}
//Method: RtgReq_Edit_b
//Description
//  ` determine whether rating req is editable
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:37:13
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_BOOLEAN:C305($0; $Edit_b)

$Edit_b:=User in group:C338(<>CurrentUser_Name; "Area Engineers")
$Edit_b:=$Edit_b | User in group:C338(<>CurrentUser_Name; "Bridge Insp Engineer")
$Edit_b:=$Edit_b | User in group:C338(<>CurrentUser_Name; "Bridge Engineer")
$Edit_b:=$Edit_b | User in group:C338(Current user:C182; "Design Access Group")

$0:=$Edit_b

//End RtgReq_Edit_b