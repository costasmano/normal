//Method: [NTI_TunnelRatings];"TunnelRating_LB"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/11/19, 11:57:24
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04_bug
	//Added label with title to be based on L1 from TunnelInfo in form method;
	//hide Rating girder/slab columns ; resized LB and buttons; change dates to internal date short
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($LabelTitle_txt)
		OBJECT SET TITLE:C194(*; "RatingLabel"; "")  //Clear out the title
		If ([NTI_TunnelInfo:181]NTI_L1_s:59="N")
			$LabelTitle_txt:="Attenntion!!\nCurrent Load Rating Method (L.1) = \n\"N\" : Load Rating not Required."
			OBJECT SET TITLE:C194(*; "RatingLabel"; $LabelTitle_txt)
			C_LONGINT:C283($L; $T; $R; $B; $LabelBot_L; $moveV_L)
			OBJECT GET COORDINATES:C663(*; "RatingLabel"; $L; $T; $R; $LabelBot_L)
			OBJECT GET COORDINATES:C663(*; "TunnelRating_LB"; $L; $T; $R; $B)
			$moveV_L:=$LabelBot_L-$T+5  //vert margin of 5 pixels between the label and listbox
			If ($moveV_L>0)
				//object move(*;"TunnelRating_LB";0;$moveV_L;0;0)
				// need to move the other objects
				C_LONGINT:C283($FormObject_L)
				ARRAY TEXT:C222($objectNames_atxt; 0)
				FORM GET OBJECTS:C898($objectNames_atxt)
				
				For ($FormObject_L; 1; Size of array:C274($objectNames_atxt))
					If ($objectNames_atxt{$FormObject_L}#"RatingLabel")
						OBJECT MOVE:C664(*; $objectNames_atxt{$FormObject_L}; 0; $moveV_L; 0; 0)
					End if 
					
				End for 
				
				//and resize the window
				RESIZE FORM WINDOW:C890(0; $moveV_L)
			End if 
		End if 
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End [NTI_TunnelRatings].TunnelRating_LB