//%attributes = {"invisible":true}
//Method: P_LoadBINSelection
//Description
//  ` Start process with a BIN selection saved as a temp saved set file
// Parameters
// $1 : $BINSetPath_txt : path to a set file of BINs
// $2 : $WindowTitle_txt
// $3 : $Flag_txt : if not passed launch a process to run
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/17/16, 12:33:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_06
	C_TEXT:C284(P_LoadBINSelection; $1)
	C_TEXT:C284(P_LoadBINSelection; $2)
	C_TEXT:C284(P_LoadBINSelection; $3)
	Mods_2020_07_bug  // Fix bug where modify selection still being used. It should have been dialog
	//Also changed to use ut_OpenNewWindow so we can add a close box
	//Modified by: CJ (7/6/20 15:54:47)
	
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)

If ((Count parameters:C259>1) & (Count parameters:C259<3))
	
	C_LONGINT:C283($Lpid)
	$Lpid:=LSpawnProcess("P_LoadBINSelection"; <>LStackSize; $2; True:C214; False:C215; $1; $2; "Go")
	
Else 
	
	C_TEXT:C284($3)
	InitProcessVar
	MainTitle:=$2
	CurInsp:=""
	C_TEXT:C284($path; $extension)
	
	LOAD SET:C185([Bridge MHD NBIS:1]; "Temp"; $1)
	If (Ok=1)
		USE SET:C118("Temp")
		CLEAR SET:C117("Temp")
		FORM SET INPUT:C55([Bridge MHD NBIS:1]; DefInLay)
		FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; DefOutLay)
		C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
		$RecSel:=String:C10(Records in selection:C76([Bridge MHD NBIS:1]))
		ControlMenuBar(2)
		COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "UserRegionA")
		C_LONGINT:C283($win_L; $Width_l; $Height_L)
		FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $Width_l; $Height_L)
		
		$win_L:=ut_OpenNewWindow($Width_l+10; 500; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
		//NewWindow (830;456;1;8)  //Window for this process
		UpdatWindArray(""; Current process:C322)
		//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
		
		DIALOG:C40([Bridge MHD NBIS:1]; DefOutLay)
		
		//MODIFY SELECTION([Bridge MHD NBIS];Multiple selection;False;*)
		
		UpdatWindArray(""; Current process:C322)
		CLEAR NAMED SELECTION:C333("UserRegionA")
		CLOSE WINDOW:C154
		ControlMenuBar(1)
	Else 
		ALERT:C41("Could not load requested BIN set :"+$1)
	End if 
End if 

//End P_LoadBINSelection