
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/13/11, 14:04:26
//----------------------------------------------------
//Method: Object Method: [PRJ_ProjectDetails].ProjectDetails.o.PRJ_RelatedQRs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	ut_QRProcess  //we launch this one
	// Modified by: costasmanousakis-(Designer)-(4/19/11 14:34:15)
	Mods_2011_04
	//  `Changed button name and type to make it a 3D button with a linked pop-up menu. 
	//  `Added ability to do QRs based on related Included BINs
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//Modified by: Charles Miller (12/13/11 12:12:57)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: ((Form event code:C388=On Long Click:K2:37) | (Form event code:C388=On Alternative Click:K2:36))
		C_TEXT:C284($Setname_txt)
		C_BOOLEAN:C305($QueryOpt_b)
		$QueryOpt_b:=False:C215
		C_LONGINT:C283($Size_l; $TableNumber_l)
		
		C_LONGINT:C283($Choose_L)
		$Choose_L:=Pop up menu:C542("ProjectFile"+Char:C90(13)+"BINS")
		Case of 
			: ($Choose_L=1)
				COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "PRJCURRENTSELECTIONTMP")
				RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
				QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3>0)
				If (Records in selection:C76([PRJ_ProjectFile:117])>0)
					$TableNumber_l:=Table:C252(->[PRJ_ProjectFile:117])
					
					$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
					CREATE SET:C116([PRJ_ProjectFile:117]; $Setname_txt)
					
					C_BLOB:C604($Blob_blb)
					SET BLOB SIZE:C606($Blob_blb; 0)
					VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
					VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
					VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
					
					$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
					
					//QR REPORT([PRJ_ProjectFile];Char(1);True;True;False)
					USE NAMED SELECTION:C332("PRJCURRENTSELECTIONTMP")
				End if 
				CLEAR NAMED SELECTION:C333("PRJCURRENTSELECTIONTMP")
				
			: ($Choose_L=2)
				COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "PRJCURRENTSELECTIONTMP")
				RELATE MANY SELECTION:C340([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1)
				
				If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
					SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
					$TableNumber_l:=Table:C252(->[PRJ_ProjectDetailsIncludedBINS:122])
					
					$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
					CREATE SET:C116([PRJ_ProjectDetailsIncludedBINS:122]; $Setname_txt)
					
					C_BLOB:C604($Blob_blb)
					SET BLOB SIZE:C606($Blob_blb; 0)
					VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
					VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
					VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
					
					$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
					//QR REPORT([PRJ_ProjectDetailsIncludedBINS];Char(1);True;True;True)
					USE NAMED SELECTION:C332("PRJCURRENTSELECTIONTMP")
					SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
					
				End if 
				CLEAR NAMED SELECTION:C333("PRJCURRENTSELECTIONTMP")
				
		End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($Setname_txt)
		C_BOOLEAN:C305($QueryOpt_b)
		$QueryOpt_b:=False:C215
		C_LONGINT:C283($Size_l; $TableNumber_l)
		
		
		COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "PRJCURRENTSELECTIONTMP")
		CONFIRM:C162("ProjFile or BINs"; "ProjFile"; "BINS")
		If (OK=1)
			RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
			QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3>0)
			If (Records in selection:C76([PRJ_ProjectFile:117])>0)
				$TableNumber_l:=Table:C252(->[PRJ_ProjectFile:117])
				
				$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
				CREATE SET:C116([PRJ_ProjectFile:117]; $Setname_txt)
				
				C_BLOB:C604($Blob_blb)
				SET BLOB SIZE:C606($Blob_blb; 0)
				VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
				VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
				VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
				
				$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
				
				//QR REPORT([PRJ_ProjectFile];Char(1);True;True;False)
				USE NAMED SELECTION:C332("PRJCURRENTSELECTIONTMP")
			End if 
			
		Else 
			RELATE MANY SELECTION:C340([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1)
			
			If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				$TableNumber_l:=Table:C252(->[PRJ_ProjectDetailsIncludedBINS:122])
				
				$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
				CREATE SET:C116([PRJ_ProjectDetailsIncludedBINS:122]; $Setname_txt)
				
				C_BLOB:C604($Blob_blb)
				SET BLOB SIZE:C606($Blob_blb; 0)
				VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
				VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
				VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
				
				$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
				
				//QR REPORT([PRJ_ProjectDetailsIncludedBINS];Char(1);True;True;True)
				USE NAMED SELECTION:C332("PRJCURRENTSELECTIONTMP")
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				
			End if 
			
			
		End if 
		
		CLEAR NAMED SELECTION:C333("PRJCURRENTSELECTIONTMP")
		
End case 


//End Object Method: [PRJ_ProjectDetails].ProjectDetails.o.PRJ_RelatedQRs