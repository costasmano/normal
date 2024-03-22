If (False:C215)
	//LO: [RatingMember];"RatMemberIn"
	// Modified by: Costas Manousakis-(Designer)-(1/16/14 16:56:03)
	Mods_2014_01
	//  `modified form to add display of Bin, bdept, rating date, consultant; increased HT of descr; added vert scroll bars
	//  `on the on validate event clean out the text in the descr  to avoid multiple extra lines
	// Modified by: Costas Manousakis-(Designer)-(2/24/14 13:30:54)
	Mods_2014_02_bug
	//  `Removed  the "Default" value from the Rating Date. - it was resetting the date to the current date for an unsaved RtgReport record.
	// Modified by: Costas Manousakis-(Designer)-(9/26/16 15:04:47)
	Mods_2016_09
	//  `modified  display format of ratings to show "N/A" for negative values
	//  `added button "N/A" to enter -1 in all inv ratings 
	// Modified by: Costas Manousakis-(Designer)-(4/23/18 12:48:37)
	Mods_2018_04
	//  `added button "N/A" to enter -1 in all operating ratings 
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(3)
		If ([RatingMember:66]RatingID:1=0)  //If this is a new record
			[RatingMember:66]RatingID:1:=[RatingReports:65]RatingID:21
			SAVE RECORD:C53([RatingMember:66])
		End if 
	: (Form event code:C388=On Validate:K2:3)
		
		C_LONGINT:C283($pos_L; $DescLen_L)
		$DescLen_L:=Length:C16([RatingMember:66]Description:4)
		C_TEXT:C284($CleanDesc_txt; $orig_txt)
		$orig_txt:=[RatingMember:66]Description:4
		$CleanDesc_txt:=""
		//[RatingMember]Description
		For ($pos_L; 1; ($DescLen_L-1))
			
			If ($orig_txt[[$pos_L]]=Char:C90(Carriage return:K15:38))
				
				If ($orig_txt[[$pos_L+1]]=Char:C90(Carriage return:K15:38))
					
				Else 
					$CleanDesc_txt:=$CleanDesc_txt+$orig_txt[[$pos_L]]
				End if 
			Else 
				$CleanDesc_txt:=$CleanDesc_txt+$orig_txt[[$pos_L]]
			End if 
		End for 
		$CleanDesc_txt:=$CleanDesc_txt+$orig_txt[[$DescLen_L]]
		
		[RatingMember:66]Description:4:=f_TrimStr($CleanDesc_txt; True:C214; True:C214)
		// FlushChanges (3;->[RatingReports]RatingID;->[RatingMember]RatingID;
		//-> •[RatingMember]MemberID• ;2)
End case 