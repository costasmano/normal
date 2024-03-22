//%attributes = {"invisible":true}
If (False:C215)
	//G_ConfigInspBtn_1
	//Method used by the Configure Inspection button in Insp input forms
	//Simple version.
	Mods_2004_CM12
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 16:59:01)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 16:28:31)
	Mods_2012_12
	//  `use new method Insp_SortElmtSfty
	//  `make sure other tables are RO
End if 

C_TEXT:C284($msg)
READ ONLY:C145([Inspection Type:31])
READ ONLY:C145([ElementDict:30])
If ((([Inspections:27]InspApproved:167=BMS Not Reviewed) & ([Inspections:27]InspReviewed:12=BMS Not Reviewed)) | (Not:C34([Inspections:27]InspComplete:168)))
	// it has not been reviewed yet at any level
	//   or it has been marked as incomplete.
	COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImagesPreview")
	MakeInspection
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
	If (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))
		//Check to see what Items are used - Aug-2002
		//use Query with Array instead of Relate One Selection
		ARRAY INTEGER:C220($aelmtno; 0)
		ARRAY TEXT:C222($aItemCateg; 0)  //Command Replaced was o_ARRAY string length was 3
		SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $aelmtno)
		QUERY WITH ARRAY:C644([ElementDict:30]ElementNo:1; $aelmtno)
		DISTINCT VALUES:C339([ElementDict:30]Category:3; $aItemCateg)
		If (Size of array:C274($aItemCateg)>0)
			Case of 
				: ([Inspections:27]Insp Type:6="RT@")
					If (Find in array:C230($aItemCateg; "N58")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 58:79; False:C215)
						[Inspections:27]Item 58:79:=""
						PushChange(1; ->[Inspections:27]Item 58:79)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 58:79; True:C214)
					End if 
					If (Find in array:C230($aItemCateg; "N59")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 59:80; False:C215)
						[Inspections:27]Item 59:80:=""
						PushChange(1; ->[Inspections:27]Item 59:80)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 59:80; True:C214)
					End if 
					If (Find in array:C230($aItemCateg; "N60")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 60:81; False:C215)
						[Inspections:27]Item 60:81:=""
						PushChange(1; ->[Inspections:27]Item 60:81)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 60:81; True:C214)
					End if 
					If (Find in array:C230($aItemCateg; "N61")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 61:82; False:C215)
						[Inspections:27]Item 61:82:=""
						PushChange(1; ->[Inspections:27]Item 61:82)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 61:82; True:C214)
					End if 
					
				: ([Inspections:27]Insp Type:6="CUL")
					If (Find in array:C230($aItemCateg; "N62")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 62:113; False:C215)
						[Inspections:27]Item 62:113:=""
						PushChange(1; ->[Inspections:27]Item 62:113)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 62:113; True:C214)
					End if 
					If (Find in array:C230($aItemCateg; "N61")=-1)
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 61:82; False:C215)
						[Inspections:27]Item 61:82:=""
						PushChange(1; ->[Inspections:27]Item 61:82)
					Else 
						OBJECT SET ENTERABLE:C238([Inspections:27]Item 61:82; True:C214)
					End if 
					
			End case 
		End if 
		ARRAY INTEGER:C220($aelmtno; 0)
		ARRAY TEXT:C222($aItemCateg; 0)  //Command Replaced was o_ARRAY string length was 3
	End if 
	
	If (CurCat#"ALL")
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=CurCat)
	End if 
	
	Insp_SortElmtSfty
	
	USE NAMED SELECTION:C332("TempImagesPreview")
	CLEAR NAMED SELECTION:C333("TempImagesPreview")
	
	G_Insp_ElmtArray_setup
	
Else 
	RELATE ONE:C42([Inspections:27]Insp Type:6)
	$msg:="Selected "+[Inspection Type:31]Description:2+" Inspection "
	$msg:=$msg+"dated "+String:C10([Inspections:27]Insp Date:78; Internal date short special:K1:4)+<>sCR
	$msg:=$msg+"is in a Review Stage and cannot be Re-Configured!"
	ALERT:C41($msg)
	
End if 