//%attributes = {"invisible":true}
//Method: ProgressNew
//Description
// Set up a progress bar: returns object with properties "progress" , "StartMS", "msgtempl", "total", "timeopt"
// Parameters
// $0 : $progressObj_o
// $1 : $Title_txt
// $2 : $TotalCount_L
// $3 : $Button_b
// $4 : $msgTempl_txt -used in message ie "x of $TotalCount_L $mestempl_txt"
// $5 : TimeOption - if 0:no time ;1:time elapsed ; 2:time left ; 3:both
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/25/17, 10:41:52
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_OBJECT:C1216(ProgressNew; $0)
	C_TEXT:C284(ProgressNew; $1)
	C_LONGINT:C283(ProgressNew; $2)
	C_BOOLEAN:C305(ProgressNew; $3)
	C_TEXT:C284(ProgressNew; $4)
	C_LONGINT:C283(ProgressNew; $5)
	
End if 
//
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)
C_TEXT:C284($4)
C_OBJECT:C1216($ProgressObj_o)
C_LONGINT:C283($ProgressID_L; $StartMilli_L)
$ProgressID_L:=Progress New
$StartMilli_L:=Milliseconds:C459
Progress SET TITLE($ProgressID_L; $1)
Progress SET BUTTON ENABLED($ProgressID_L; $3)
Progress SET PROGRESS($ProgressID_L; 0)

OB SET:C1220($ProgressObj_o; "progress"; $ProgressID_L; "StartMS"; $StartMilli_L; "msgtempl"; $4; "total"; $2; "timeOpt"; $5)

$0:=$ProgressObj_o

//End ProgressNew