If (False:C215)
	Mods_2005_CM06
	Mods_2005_CM11
	Mods_2011_06  // CJ Miller`06/20/11, 11:33:22      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET ENTERABLE:C238([Combined Inspections:90]NBISInspID:2; False:C215)
		OBJECT SET ENTERABLE:C238([Combined Inspections:90]BMSInspID:3; False:C215)
		OBJECT SET ENABLED:C1123(aNBI_descr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(aBMS_descr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "Delete@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(SetToNoBMS; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Current user:C182="Designer")
			
			If (vSetEnterable=1)
				OBJECT SET ENABLED:C1123(aNBI_descr; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(aBMS_descr; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENTERABLE:C238([Combined Inspections:90]NBISInspID:2; True:C214)
				OBJECT SET ENTERABLE:C238([Combined Inspections:90]BMSInspID:3; True:C214)
				OBJECT SET ENABLED:C1123(*; "Delete@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(SetToNoBMS; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				C_LONGINT:C283($i; $K)
				ARRAY LONGINT:C221(aNBI_IDs; 0)
				ARRAY INTEGER:C220($aNBILDR_IDs; 0)
				ARRAY TEXT:C222($aNBI_Type; 0)  //Command Replaced was o_ARRAY string length was 3
				ARRAY DATE:C224($aNBI_Date; 0)
				ARRAY LONGINT:C221(aBMS_IDs; 0)
				ARRAY INTEGER:C220($aBMSLDR_IDs; 0)
				ARRAY DATE:C224($aBMS_Date; 0)
				ARRAY TEXT:C222($aNBI_descr; 0)  //Command Replaced was o_ARRAY string length was 80
				ARRAY TEXT:C222($aBMS_descr; 0)  //Command Replaced was o_ARRAY string length was 80
				QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Combined Inspections:90]BIN:1)
				QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=[Combined Inspections:90]BIN:1)
				SELECTION TO ARRAY:C260([Inspections:27]InspID:2; aNBI_IDs; [Inspections:27]Insp Type:6; $aNBI_Type; [Inspections:27]Insp Date:78; $aNBI_Date; [Inspections:27]TeamLeader:4; $aNBILDR_IDs)
				SELECTION TO ARRAY:C260([BMS Inspections:44]Inspection ID:1; aBMS_IDs; [BMS Inspections:44]Insp Date:4; $aBMS_Date; [BMS Inspections:44]TeamLeader:6; $aBMSLDR_IDs)
				ARRAY TEXT:C222(aNBI_descr; (Size of array:C274(aNBI_IDs)+1))  //Command Replaced was o_ARRAY string length was 80
				ARRAY TEXT:C222(aBMS_descr; (Size of array:C274(aBMS_IDs)+1))  //Command Replaced was o_ARRAY string length was 80
				For ($i; 1; Size of array:C274(aNBI_IDs))
					aNBI_descr{$i}:=String:C10(aNBI_IDs{$i})+" - "+String:C10($aNBI_Date{$i})+" - "+$aNBI_Type{$i}
					$k:=Find in array:C230(aPeople_ID; $aNBILDR_IDs{$i})
					If ($k>0)
						aNBI_descr{$i}:=aNBI_descr{$i}+" - "+Substring:C12(aPeople{$k}; 1; 1)+"."+Substring:C12(aPeople{$k}; Position:C15(" "; aPeople{$k}))
					End if 
					
				End for 
				aNBI_descr{Size of array:C274(aNBI_descr)}:=""
				For ($i; 1; Size of array:C274(aBMS_IDs))
					aBMS_descr{$i}:=String:C10(aBMS_IDs{$i})+" - "+String:C10($aBMS_Date{$i})
					$k:=Find in array:C230(aPeople_ID; $aBMSLDR_IDs{$i})
					If ($k>0)
						aBMS_descr{$i}:=aBMS_descr{$i}+" - "+Substring:C12(aPeople{$k}; 1; 1)+"."+Substring:C12(aPeople{$k}; Position:C15(" "; aPeople{$k}))
					End if 
					
				End for 
				aBMS_descr{Size of array:C274(aBMS_descr)}:=""
				
				$k:=Find in array:C230(aNBI_IDs; [Combined Inspections:90]NBISInspID:2)
				If ($k>0)
					aNBI_descr:=$k
				Else 
					aNBI_descr:=Size of array:C274(aNBI_descr)
				End if 
				
				$k:=Find in array:C230(aBMS_IDs; [Combined Inspections:90]BMSInspID:3)
				If ($k>0)
					aBMS_descr:=$k
				Else 
					aBMS_descr:=Size of array:C274(aBMS_descr)
				End if 
				
			Else 
				OBJECT SET ENABLED:C1123(aNBI_descr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(aBMS_descr; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENTERABLE:C238([Combined Inspections:90]NBISInspID:2; True:C214)
				OBJECT SET ENTERABLE:C238([Combined Inspections:90]BMSInspID:3; True:C214)
				OBJECT SET ENABLED:C1123(*; "Delete@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				
				ARRAY LONGINT:C221($aNBI_IDs; 0)
				ARRAY INTEGER:C220($aNBILDR_IDs; 0)
				ARRAY TEXT:C222($aNBI_Type; 0)  //Command Replaced was o_ARRAY string length was 3
				ARRAY DATE:C224($aNBI_Date; 0)
				ARRAY TEXT:C222($aNBI_descr; 0)  //Command Replaced was o_ARRAY string length was 80
				ARRAY LONGINT:C221($aBMS_IDs; 0)
				ARRAY INTEGER:C220($aBMSLDR_IDs; 0)
				ARRAY TEXT:C222($aBMS_Type; 0)  //Command Replaced was o_ARRAY string length was 3
				ARRAY DATE:C224($aBMS_Date; 0)
				ARRAY TEXT:C222($aBMS_descr; 0)  //Command Replaced was o_ARRAY string length was 80
			End if 
			
		End if   //IF DESIGNER
End case 