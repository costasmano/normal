//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/21/09, 09:12:33
	// ----------------------------------------------------
	// Method: SCPOA_ScourInpButton_OM
	// Description
	// object method for the Scour POA button on the Bridge input form
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/17/09 13:22:32)
	Mods_2009_12
	//  `Use the system parameter SC_Item113Filter to come up with the item 113 filter
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 20:38:24)
	Mods_2012_02
	//  `new form "Input-A"
	// Modified by: Costas Manousakis-(Designer)-(8/13/12 16:24:48)
	Mods_2012_08
	//  `Adjust the hor window size to add 10, and add the controlmenubar(3) and controlmenubar(2)
	// Modified by: Costas Manousakis-(Designer)-(2/28/14 11:55:31)
	Mods_2014_02
	//  `removed controlmenubar(2) at the end.  The  Quiclk Report command re-set the selection
End if 
READ WRITE:C146([ScourPOA:132])
QUERY:C277([ScourPOA:132]; [ScourPOA:132]BIN:2=[Bridge MHD NBIS:1]BIN:3)
FORM SET INPUT:C55([ScourPOA:132]; "Input-A")
C_LONGINT:C283($currWidth_L; $CurrHt_L; $WLeft; $WTop; $Wright; $Wbott; $width_L; $Ht_L)
GET WINDOW RECT:C443($WLeft; $WTop; $Wright; $Wbott)
$currWidth_L:=$Wright-$WLeft
FORM GET PROPERTIES:C674([ScourPOA:132]; "Input-A"; $width_L; $Ht_L)
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "$SCOURPOABRIDGELIST")
CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "$SCOURPOACURRBRIDGE")
ADD TO SET:C119([Bridge MHD NBIS:1]; "$SCOURPOACURRBRIDGE")
SCPOA_Variables("SETUP")
If (Records in selection:C76([ScourPOA:132])>0)
	FIRST RECORD:C50([ScourPOA:132])
	If (ut_LoadRecordInteractive(->[ScourPOA:132]))
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		SET WINDOW RECT:C444($WLeft; $WTop; ($WLeft+$width_L+10); $Wbott)
		ControlMenuBar(3)
		MODIFY RECORD:C57([ScourPOA:132])
		GET WINDOW RECT:C443($WLeft; $WTop; $Wright; $Wbott)
		SET WINDOW RECT:C444($WLeft; $WTop; ($WLeft+$currWidth_L); $Wbott)
		USE NAMED SELECTION:C332("$SCOURPOABRIDGELIST")
		HIGHLIGHT RECORDS:C656([Bridge MHD NBIS:1]; "$SCOURPOACURRBRIDGE")
	End if 
Else 
	C_TEXT:C284($ITEM113Filter_txt; $ITEM113FilterExpl_txt)
	$ITEM113Filter_txt:=ut_GetSysParameter("SC_Item113Filter"; ",0,1,2,3,6,D,U,"; "VALUE")
	$ITEM113FilterExpl_txt:=Substring:C12($ITEM113Filter_txt; 2; (Length:C16($ITEM113Filter_txt)-3))+" or "+Substring:C12($ITEM113Filter_txt; (Length:C16($ITEM113Filter_txt)-1); 1)
	
	//Do POA only if 113=1,2,3,U
	
	If (Position:C15((","+[Bridge MHD NBIS:1]Item113:151+","); $ITEM113Filter_txt)>0)
		CREATE RECORD:C68([ScourPOA:132])
		Inc_Sequence("ScourPOA"; ->[ScourPOA:132]ScourPOAID:1)
		[ScourPOA:132]BIN:2:=[Bridge MHD NBIS:1]BIN:3
		InitChangeStack(1)
		[ScourPOA:132]DateCreated:3:=Current date:C33(*)
		[ScourPOA:132]CreatedBy:22:=<>CurrentUser_Name
		PushChange(1; ->[ScourPOA:132]DateCreated:3)
		PushChange(1; ->[ScourPOA:132]CreatedBy:22)
		SAVE RECORD:C53([ScourPOA:132])
		If (SCPOA_LogChanges_b)
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1; "ScourPOA")
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[ScourPOA:132]BIN:2; ->[ScourPOA:132]ScourPOAID:1; 1)
		End if 
		SET WINDOW RECT:C444($WLeft; $WTop; ($WLeft+$width_L); $Wbott)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		MODIFY RECORD:C57([ScourPOA:132])
		USE NAMED SELECTION:C332("$SCOURPOABRIDGELIST")
		HIGHLIGHT RECORDS:C656([Bridge MHD NBIS:1]; "$SCOURPOACURRBRIDGE")
		GET WINDOW RECT:C443($WLeft; $WTop; $Wright; $Wbott)
		SET WINDOW RECT:C444($WLeft; $WTop; ($WLeft+$currWidth_L); $Wbott)
	Else 
		C_TEXT:C284($Msg)
		$Msg:="To Create a Scour Plan of Action, Item 113 must be "+$ITEM113FilterExpl_txt+"."
		$Msg:=$Msg+" Item 113 for current bridge record is "+[Bridge MHD NBIS:1]Item113:151+"."
		ALERT:C41($Msg)
	End if 
	
End if 
If (Is record loaded:C669([ScourPOA:132]))
	UNLOAD RECORD:C212([ScourPOA:132])
End if 

READ ONLY:C145([ScourPOA:132])
CLEAR NAMED SELECTION:C333("$SCOURPOABRIDGELIST")
If (Read only state:C362([Bridge MHD NBIS:1]))
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 

SCPOA_POABtnCtrl(<>CurrentUser_Name)