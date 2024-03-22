//Method: [Personnel];"Inspectors In".Expand
//Description
// expand all groups
// Parameters
// ----------------------------------------------------

//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_TEXT:C284($myname_txt)
$myname_txt:=OBJECT Get name:C1087(Object current:K67:2)
C_COLLECTION:C1488(ugroups)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		OBJECT SET TITLE:C194(*; $myname_txt; "Expand")
		
	: ($FormEvent_L=On Clicked:K2:4)
		C_TEXT:C284($objTitle_txt)
		$objTitle_txt:=OBJECT Get title:C1068(*; $myname_txt)
		
		Case of 
			: ($objTitle_txt="expand")
				PERS_ShowMemberships("expand")
				OBJECT SET TITLE:C194(*; $myname_txt; "Collapse")
				
			: ($objTitle_txt="Collapse")
				PERS_ShowMemberships("Collapse")
				
				OBJECT SET TITLE:C194(*; $myname_txt; "Expand")
				
		End case 
		
End case 


//End [Personnel];"Inspectors In".Button