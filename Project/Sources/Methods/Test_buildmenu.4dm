//%attributes = {"invisible":true}
//Method: Test_buildmenu
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/09/17, 13:30:01
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//
ARRAY TEXT:C222($MenuLines_atxt; 0)
ARRAY TEXT:C222($MenuAttributes_atxt; 0)
C_TEXT:C284($Line_txt)

C_POINTER:C301($MenuLines_ptr; $MenuAttributes_ptr)
$MenuLines_ptr:=->$MenuLines_atxt
$MenuAttributes_ptr:=->$MenuAttributes_atxt

$Line_txt:="File1.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Branch1\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)


$Line_txt:="Other\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Branch1\\Other\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Branch2\\Other3\\"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Branch2\\Other3\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Branch2\\Other1\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Branch1\\Other\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Branch1.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Other\\Branch2\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Other\\Branch2\\File3.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Branch6.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)
$Line_txt:="Other.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Other\\Branch2\\Branch3\\Branch4\\File2.x"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Ather\\Branch2\\Branch3\\Branch5\\test.pdf"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Ather\\Branch2\\Branch3\\Branch4\\"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Ather\\Branch2\\Branch3\\Branch4\\AddedFile.pdf"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Ather\\Branch2\\Branch3\\Branch6\\"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

$Line_txt:="Files\\OtherFile.pdf"
APPEND TO ARRAY:C911($MenuLines_ptr->; $Line_txt)
APPEND TO ARRAY:C911($MenuAttributes_ptr->; $Line_txt)

SORT ARRAY:C229($MenuLines_ptr->; $MenuAttributes_ptr->)

C_TEXT:C284($mainmenu_txt)
$mainmenu_txt:=MENU_BuildMenuFromArrays(->$MenuLines_atxt; ->$MenuAttributes_atxt; "\\")

//now test this
C_TEXT:C284($choise_txt)
$choise_txt:=Dynamic pop up menu:C1006($mainmenu_txt)

ALERT:C41("Picked : ["+$choise_txt+"]")

RELEASE MENU:C978($mainmenu_txt)

//End Test_buildmenu