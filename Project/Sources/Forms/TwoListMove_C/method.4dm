//Method: TwoListMove_C
//Description
// copy from twoListMove made to use collections and Form object
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Apr 26, 2023, 16:29:54
	Mods_2023_04
	// ----------------------------------------------------
	
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "cancelbtn"; True:C214)
		
		If (Form:C1466.cancelbtn.label#Null:C1517)
			If (Form:C1466.cancelbtn.label#"")
				OBJECT SET TITLE:C194(*; "cancelbtn"; Form:C1466.cancelbtn.label)
			End if 
			
		End if 
		If (Form:C1466.cancelbtn.visible#Null:C1517)
			If (Form:C1466.cancelbtn.visible=False:C215)
				OBJECT SET VISIBLE:C603(*; "cancelbtn"; False:C215)
			End if 
		End if 
		If (Form:C1466.okbtn.label#Null:C1517)
			If (Form:C1466.okbtn.label#"")
				OBJECT SET TITLE:C194(*; "okbtn"; Form:C1466.okbtn.label)
			End if 
		End if 
		
		If (Form:C1466.useheader#Null:C1517)
			OBJECT SET TITLE:C194(*; "header1"; Form:C1466.useheader)
		End if 
		
		If (Form:C1466.omitheader#Null:C1517)
			OBJECT SET TITLE:C194(*; "Header2"; Form:C1466.omitheader)
		End if 
		
		LISTBOX SET COLUMN FORMULA:C1203(*; "Column1"; "This."+Form:C1466.col1; Is text:K8:3)
		LISTBOX SET COLUMN FORMULA:C1203(*; "Column2"; "This."+Form:C1466.col1; Is text:K8:3)
		
	: (Form event code:C388=On Resize:K2:27)
		C_LONGINT:C283($UL; $UR; $UW; $OL; $OR; $OW; $NW; $WW; $BW; T; $B; $WL; $WT; $WR; $WB)
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
		OBJECT GET COORDINATES:C663(*; "OmitLB"; $OL; $T; $OR; $B)
		OBJECT GET COORDINATES:C663(*; "UseLB"; $UL; $T; $UR; $B)
		$WW:=$WR-$WL
		$BW:=$OL-$UR
		$NW:=($WW-$BW-40)/2
		OBJECT MOVE:C664(*; "UseL@"; 0; 0; ($NW-($UR-$UL)))
		OBJECT MOVE:C664(*; "Move@"; ($NW-($UR-$UL)); 0)
		OBJECT MOVE:C664(*; "OmitL@"; ($NW-($UR-$UL)); 0; ($NW-($UR-$UL)))
		
	: (Form event code:C388=On Validate:K2:3)
		//return updated collections in object defined in return property of Form object
		Form:C1466.return.OmitC:=Form:C1466.OmitC
		Form:C1466.return.UseC:=Form:C1466.UseC
		
End case 

//End TwoListMove_C   
