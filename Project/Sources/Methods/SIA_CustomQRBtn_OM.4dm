//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/07/08, 09:48:46
	// ----------------------------------------------------
	// Method: SIA_CustomQRBtn_OM
	// Description
	//  ` Method for a Quick report button that allows a choise for the
	//  ` Master Table to be used from the NBI Stack info list form
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(7/8/08 09:21:46)
	Mods_2008_CM_5404  // ("OTHERQUICKREPORT")
	// Modified by: costasmanousakis-(Designer)-(10/15/08 13:12:48)
	Mods_2008_CM_5404
	Mods_2009_06  //r002 `06/12/09, 15:55:07    `Merge in changes made by Costas
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//Modified by: Charles Miller (12/13/11 12:12:57)
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//Added NBI Secondary table to the list of related tables
	//modified by Charkes Miller 12/13/11, 14:32:17    
	//  Move code to 2004
	// Modified by: Costas Manousakis-(Designer)-(4/11/16 16:21:11)
	Mods_2016_04_bug
	//  `added Pon_elem_insp, [TunnelInspection]
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (<>CurrentUser_Name="Designer")
			OBJECT SET VISIBLE:C603(CustomQR_btn; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(CustomQR_btn; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($QueryOpt_b)
		C_LONGINT:C283($i; $numList_L)
		$numList_L:=8
		ARRAY TEXT:C222(TablePickList_atxt; 1)
		ARRAY POINTER:C280($TblPtr_aptr; 1)
		ARRAY POINTER:C280($TbllinkFldPtr_aptr; 1)
		ARRAY LONGINT:C221($ParTblLink_aL; 1)
		$i:=1
		$TblPtr_aptr{$i}:=(->[Bridge MHD NBIS:1])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Bridge MHD NBIS:1])
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[NBIS Secondary:3])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[NBIS Secondary:3]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Inspections:27])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Inspections:27]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[BMS Inspections:44])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[BMS Inspections:44]BIN:2)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Bridge Design:75])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Bridge Design:75]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Cons Inspection:64])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Cons Inspection:64]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Conslt Rating:63])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Conslt Rating:63]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[RatingReports:65])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[RatingReports:65]BIN:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[InventoryPhotoInsp:112])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[InventoryPhotoInsp:112]BIN:2)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[ScourPOA:132])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[ScourPOA:132]BIN:2)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[ElementsSafety:29])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[ElementsSafety:29]InspID:4)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[Inspections:27]))  //linked to table 2 in the list
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[PON_ELEM_INSP:179])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[PON_ELEM_INSP:179]INSPID:21)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[Inspections:27]))  //linked to table 2 in the list
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[TunnelInspection:152])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[TunnelInspection:152]InspID:1)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[Inspections:27]))  //linked to table 2 in the list
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Cond Units:45])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Cond Units:45]Inspection ID:2)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[BMS Inspections:44]))  //
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[InventoryPhotos:113])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[InventoryPhotos:113]InvPhotoInsp_ID:2)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[InventoryPhotoInsp:112]))  //
		
		C_LONGINT:C283($picked_L)
		$picked_L:=G_PickFromList(->TablePickList_atxt; "Select Master Table for the Quick Report")
		If (OK=1)
			COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PREQRSELECTION")
			
			If ($picked_L=1)
				$QueryOpt_b:=False:C215
			Else 
				$QueryOpt_b:=True:C214
				If ($ParTblLink_aL{$picked_L}>0)
					RELATE MANY SELECTION:C340($TbllinkFldPtr_aptr{$ParTblLink_aL{$picked_L}}->)
				End if 
				RELATE MANY SELECTION:C340($TbllinkFldPtr_aptr{$picked_L}->)
			End if 
			C_TEXT:C284($Setname_txt)
			C_LONGINT:C283($Size_l; $TableNumber_l)
			$TableNumber_l:=Table:C252($TblPtr_aptr{$picked_L})
			
			$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
			CREATE SET:C116($TblPtr_aptr{$picked_L}->; $Setname_txt)
			
			C_BLOB:C604($Blob_blb)
			SET BLOB SIZE:C606($Blob_blb; 0)
			VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
			VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
			VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
			
			$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
			//QR REPORT($TblPtr_aptr{$picked_L}->;Char(1))
			
			USE NAMED SELECTION:C332("PREQRSELECTION")
			CLEAR NAMED SELECTION:C333("PREQRSELECTION")
		End if 
		
End case 