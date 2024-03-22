//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_ApplyRev1_Inp 
	//Apply changes for Rev1 of Inspection Input forms.
	
	Mods_2004_CM12
	
End if 

C_LONGINT:C283($vlTopOR; $vlTopGR; $vlBotOR; $vlBotGR; $vlLeft; $vlRight; $vlBottom; $vlMove)

If (f_Insp_Revision1([Inspections:27]Insp Date:78))
	//modifications for inspections after 'DATE_1'        
	OBJECT SET VISIBLE:C603(*; "@_OR"; True:C214)  //make visible Orientation objects
	OBJECT SET VISIBLE:C603(*; "@_DMC"; True:C214)  //make visible Damgage text objects
	//Make sure GenRemarks objects are below splitter.
	OBJECT GET COORDINATES:C663(*; "Splitter_Pg5_OR"; $vlLeft; $vlTopOR; $vlRight; $vlBotOR)
	OBJECT GET COORDINATES:C663(*; "Text9_GR"; $vlLeft; $vlTopGR; $vlRight; $vlBottom)
	$vlMove:=($vlBotOR+4)-$vlTopGR
	If ($vlMove#0)
		OBJECT MOVE:C664(*; "@_GR"; 0; $vlMove)
		OBJECT MOVE:C664(*; "DE General Remarks1_GR"; 0; 0; 0; -($vlMove))
	End if 
	//Make sure Orientation text obj is above splitter
	OBJECT GET COORDINATES:C663(*; "Splitter_Pg5_OR"; $vlLeft; $vlTopOR; $vlRight; $vlBotOR)
	OBJECT GET COORDINATES:C663(*; "DE Orientation Text_OR"; $vlLeft; $vlTopGR; $vlRight; $vlMove)
	If ($vlMove>($vlBotOR-9))
		$vlMove:=($vlBotOR-9)-$vlMove
		OBJECT MOVE:C664(*; "DE Orientation Text_OR"; 0; 0; 0; $vlMove)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "@_DMC"; False:C215)  //Hide Damage text objects
	OBJECT SET VISIBLE:C603(*; "@_OR"; False:C215)  //hide Orientation text objects
	//make sure GenRemarks objects move to top..
	OBJECT GET COORDINATES:C663(*; "Text9_OR"; $vlLeft; $vlTopOR; $vlRight; $vlBottom)
	OBJECT GET COORDINATES:C663(*; "Text9_GR"; $vlLeft; $vlTopGR; $vlRight; $vlBottom)
	$vlMove:=$vlTopOR-$vlTopGR
	If ($vlMove#0)
		OBJECT MOVE:C664(*; "@_GR"; 0; $vlMove)
		OBJECT MOVE:C664(*; "DE General Remarks1_GR"; 0; 0; 0; -($vlMove))
	End if 
End if 