//%attributes = {"invisible":true}
If (False:C215)
	//INIT_FIELDS_DES 
	//Global procedure for initializing field english descriptions
	//Interprocess variables can be used by all
	//Initialize at the start 
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	Mods_2004_CM11
	Mods_2004_CM02  //fix
	Mods_2004_CJM03  //added saving to blob stuff
	Mods_2004_CJM02
	
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 08:38:13)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/19/07 10:19:19)
	Mods_2007_CM_5401
	//Added IsPar_b array for element dict
	//Fixed the filling of arrays ◊aInspType,◊aInspCod,◊aCulvertI,◊aCulInspCod.
	// Modified by: costasmanousakis-(Designer)-(4/29/08 10:41:34)
	Mods_2008_CM_5403
	//Again the arrays ◊aInspType,◊aInspCod,◊aCulvertI,◊aCulInspCod; removed the pre-sizing to
	//the table size - the get resized with the Selection to array command.
	// Modified by: costasmanousakis-(Designer)-(9/30/08 16:00:44)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Use method INIT_FIELDS_ARRAYS for consistancy.
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:33:55)
	Mods_2011_01
	//` RR - also removed call to INIT_FIELDS_ARRAYS
	Mods_2013_05  //r001 ` Make them size 0 as we do not use them anyplace
	//◊aCulInspCod;◊aCulvertI
	//Modified by: Charles Miller (5/2/13 15:55:16)
	// Modified by: Costas Manousakis-(Designer)-(5/19/15 11:59:59)
	Mods_2015_05
	//  `sort the inspection responsibilty arrays by description
	// Modified by: Costas Manousakis-(Designer)-(6/8/16 15:37:20)
	Mods_2016_06
	//  `sort by code tables : [FunctionalClass]; [Design Load]; [Posting Code]; [Service Over]; [Service Under]; [Material]; [Design]; [Truck Code]; [Direction]; [Deck Structure]
	//  `  `[Deck Structure]; [Wearing Surface]; [Membrane]; [Deck Protection]; [Type of Work]; [Work Done By]; [Item 20 Tolls]; [Item 33 Median]
	//  `  ` [Item 38]; [Item 100]; [Item 101]; [Item 111]; [Foundation Type]; [Rating Method]
End if 
If (Count parameters:C259=1)
	C_BLOB:C604($0; $Return_blb)
	SET BLOB SIZE:C606($Return_blb; 0)
	C_LONGINT:C283($OffSet_l)
	$OffSet_l:=0
	C_TEXT:C284($1)
End if 
C_LONGINT:C283($fsize; $i)  //Need to know how big the array is from the size of the file

//Initialize the Maint/Owner coding scheme
ALL RECORDS:C47([MaintOwnerCode:4])
ORDER BY:C49([MaintOwnerCode:4]; [MaintOwnerCode:4]Code:1; >)
SELECTION TO ARRAY:C260([MaintOwnerCode:4]Code:1; <>aMaintCod; [MaintOwnerCode:4]Description:2; <>aMaintOwner)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aMaintOwner; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aMaintCod; $Return_blb; *)
End if 

REDUCE SELECTION:C351([MaintOwnerCode:4]; 0)

//Initialize the Functional Class coding scheme
ALL RECORDS:C47([FunctionalClass:5])
ORDER BY:C49([FunctionalClass:5]; [FunctionalClass:5]Code:1; >)
SELECTION TO ARRAY:C260([FunctionalClass:5]Code:1; <>aFC_Cod; [FunctionalClass:5]Description:2; <>aFC)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aFC; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aFC_Cod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([FunctionalClass:5]; 0)

//Initialize the Design load coding scheme
ALL RECORDS:C47([Design Load:6])
ORDER BY:C49([Design Load:6]; [Design Load:6]Code:1; >)
SELECTION TO ARRAY:C260([Design Load:6]Code:1; <>aDesLoadCod; [Design Load:6]Description:2; <>aDesignLoad)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aDesignLoad; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDesLoadCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Design Load:6]; 0)

//Initialize the Posting code coding scheme
ALL RECORDS:C47([Posting Code:7])
ORDER BY:C49([Posting Code:7]; [Posting Code:7]Code:1; >)
SELECTION TO ARRAY:C260([Posting Code:7]Code:1; <>aPostCode; [Posting Code:7]Description:2; <>aPosting)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aPosting; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aPostCode; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Posting Code:7]; 0)

//Initialize the Service Over coding scheme
ALL RECORDS:C47([Service Over:8])
ORDER BY:C49([Service Over:8]; [Service Over:8]Code:1; >)
SELECTION TO ARRAY:C260([Service Over:8]Code:1; <>aSerOvrCode; [Service Over:8]Description:2; <>aServiceOvr)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aServiceOvr; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aSerOvrCode; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Service Over:8]; 0)

//Initialize the Service Under coding scheme
ALL RECORDS:C47([Service Under:9])
ORDER BY:C49([Service Under:9]; [Service Under:9]Code:1; >)
SELECTION TO ARRAY:C260([Service Under:9]Code:1; <>aSerUndrCod; [Service Under:9]Description:2; <>aServUndr)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aServUndr; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aSerUndrCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Service Under:9]; 0)

//Initialize the Material coding scheme
ALL RECORDS:C47([Material:10])
ORDER BY:C49([Material:10]; [Material:10]Code:1; >)
SELECTION TO ARRAY:C260([Material:10]Code:1; <>aMatCode; [Material:10]Description:2; <>aMaterial)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aMaterial; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aMatCode; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Material:10]; 0)

//Initialize the Design coding scheme
ALL RECORDS:C47([Design:11])
ORDER BY:C49([Design:11]; [Design:11]Code:1; >)
SELECTION TO ARRAY:C260([Design:11]Code:1; <>aDesignCod; [Design:11]Description:2; <>aDesign)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aDesign; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDesignCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Design:11]; 0)

//Initialize the Truck coding scheme
ALL RECORDS:C47([Truck Code:12])
ORDER BY:C49([Truck Code:12]; [Truck Code:12]Code:1; >)
SELECTION TO ARRAY:C260([Truck Code:12]Code:1; <>aTruckCod; [Truck Code:12]Description:2; <>aTruck)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aTruck; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aTruckCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Truck Code:12]; 0)

//Initialize the Direction of traffic coding scheme
ALL RECORDS:C47([Direction:13])
ORDER BY:C49([Direction:13]; [Direction:13]Code:1; >)
SELECTION TO ARRAY:C260([Direction:13]Code:1; <>aDirCode; [Direction:13]Description:2; <>aDirection)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aDirection; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDirCode; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Direction:13]; 0)

//Initialize the Deck structure type coding scheme
ALL RECORDS:C47([Deck Structure:14])
ORDER BY:C49([Deck Structure:14]; [Deck Structure:14]Code:1; >)
SELECTION TO ARRAY:C260([Deck Structure:14]Code:1; <>aDeckCod; [Deck Structure:14]Description:2; <>aDeck)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aDeck; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDeckCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Deck Structure:14]; 0)

//Initialize the Wearing surface coding scheme
ALL RECORDS:C47([Wearing Surface:15])
ORDER BY:C49([Wearing Surface:15]; [Wearing Surface:15]Code:1; >)
SELECTION TO ARRAY:C260([Wearing Surface:15]Code:1; <>aWearCod; [Wearing Surface:15]Description:2; <>aWearing)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aWearing; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aWearCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Wearing Surface:15]; 0)

//Initialize the Membrane coding scheme
ALL RECORDS:C47([Membrane:16])
ORDER BY:C49([Membrane:16]; [Membrane:16]Code:1; >)
SELECTION TO ARRAY:C260([Membrane:16]Code:1; <>aMembCod; [Membrane:16]Description:2; <>aMembrane)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aMembrane; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aMembCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Membrane:16]; 0)

//Initialize the Deck protection coding scheme
ALL RECORDS:C47([Deck Protection:17])
ORDER BY:C49([Deck Protection:17]; [Deck Protection:17]Code:1; >)
SELECTION TO ARRAY:C260([Deck Protection:17]Code:1; <>aDeckPCod; [Deck Protection:17]Description:2; <>aDeckProt)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aDeckProt; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aDeckPCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Deck Protection:17]; 0)

//Initialize Type of Work (Item 75A) coding scheme
ALL RECORDS:C47([Type of Work:18])
ORDER BY:C49([Type of Work:18]; [Type of Work:18]Code:1; >)

SELECTION TO ARRAY:C260([Type of Work:18]Code:1; <>aTypeofWCod; [Type of Work:18]Description:2; <>aTypeofWork)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aTypeofWork; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aTypeofWCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Type of Work:18]; 0)

//Initialize Type of Work (Item 75B) coding scheme
ALL RECORDS:C47([Work Done By:19])
ORDER BY:C49([Work Done By:19]; [Work Done By:19]Code:1; >)
SELECTION TO ARRAY:C260([Work Done By:19]Code:1; <>aWdoneBCod; [Work Done By:19]Description:2; <>aWorkDoneBy)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aWorkDoneBy; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aWdoneBCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Work Done By:19]; 0)

//Initialize Item 20 Toll
ALL RECORDS:C47([Item 20 Tolls:22])
ORDER BY:C49([Item 20 Tolls:22]; [Item 20 Tolls:22]Code:1; >)
SELECTION TO ARRAY:C260([Item 20 Tolls:22]Code:1; <>aItem20; [Item 20 Tolls:22]Description:2; <>aItem20des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem20des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem20; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 20 Tolls:22]; 0)

//Initialize Item 33 Median
ALL RECORDS:C47([Item 33 Median:23])
ORDER BY:C49([Item 33 Median:23]; [Item 33 Median:23]Code:1; >)
SELECTION TO ARRAY:C260([Item 33 Median:23]Code:1; <>aItem33; [Item 33 Median:23]Description:2; <>aItem33des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem33des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem33; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 33 Median:23]; 0)

//Initialize Item 38 Navigation control
ALL RECORDS:C47([Item 38:24])
ORDER BY:C49([Item 38:24]; [Item 38:24]Code:1; >)
SELECTION TO ARRAY:C260([Item 38:24]Code:1; <>aItem38; [Item 38:24]Description:2; <>aItem38des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem38des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem38; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 38:24]; 0)

//Initialize Item 37 Historical Significance
ALL RECORDS:C47([HistSig:25])
SELECTION TO ARRAY:C260([HistSig:25]Code:1; <>aItem37; [HistSig:25]Description:2; <>aItem37des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem37des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem37; $Return_blb; *)
End if 
REDUCE SELECTION:C351([HistSig:25]; 0)

//Initialize Item 100 Defense Highway Designation
ALL RECORDS:C47([Item 100:33])
ORDER BY:C49([Item 100:33]; [Item 100:33]Code:1; >)
SELECTION TO ARRAY:C260([Item 100:33]Code:1; <>aItem100; [Item 100:33]Description:2; <>aItem100des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem100des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem100; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 100:33]; 0)

//Initialize Item 101 Parallel structure designation
ALL RECORDS:C47([Item 101:34])
ORDER BY:C49([Item 101:34]; [Item 101:34]Code:1; >)
SELECTION TO ARRAY:C260([Item 101:34]Code:1; <>aItem101; [Item 101:34]Description:2; <>aItem101des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem101des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem101; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 101:34]; 0)

//Initialize Item 111 Pier protection
ALL RECORDS:C47([Item 111:35])
ORDER BY:C49([Item 111:35]; [Item 111:35]Code:1; >)
SELECTION TO ARRAY:C260([Item 111:35]Code:1; <>aItem111; [Item 111:35]Description:2; <>aItem111des)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aItem111des; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aItem111; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Item 111:35]; 0)

//Initialize Foundation type
ALL RECORDS:C47([Foundation Type:38])
ORDER BY:C49([Foundation Type:38]; [Foundation Type:38]Code:1; >)
SELECTION TO ARRAY:C260([Foundation Type:38]Code:1; <>aFndCode; [Foundation Type:38]Description:2; <>aFndtion)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aFndtion; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aFndCode; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Foundation Type:38]; 0)

//Inspection Responsibility
ALL RECORDS:C47([Insp Resp:20])
ORDER BY:C49([Insp Resp:20]; [Insp Resp:20]Description:2; >)
SELECTION TO ARRAY:C260([Insp Resp:20]Code:1; <>aInspRcod; [Insp Resp:20]Description:2; <>aInspRdes)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aInspRdes; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aInspRcod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Insp Resp:20]; 0)

//Posting status
ALL RECORDS:C47([PostingStatus:61])
SELECTION TO ARRAY:C260([PostingStatus:61]Description:2; <>aPostStat; [PostingStatus:61]Code:1; <>aPostStatC)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aPostStat; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aPostStatC; $Return_blb; *)
End if 
REDUCE SELECTION:C351([PostingStatus:61]; 0)


//Inspection categories for regular bridge safety inspection
QUERY:C277([Element Cat:32]; [Element Cat:32]RegularElement:4=True:C214)
//$fsize:=Records in table([Element Cat])
SELECTION TO ARRAY:C260([Element Cat:32]Code:1; <>aInspCod; [Element Cat:32]Description:2; <>aInspType)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aInspType; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aInspCod; $Return_blb; *)
End if 
//Inspection categories for culvert bridge safety inspection
//QUERY([Element Cat];[Element Cat]CulvertElement=True)
//$fsize:=Records in table([Element Cat])
//SELECTION TO ARRAY([Element Cat]Code;◊aCulInspCod;[Element Cat]Description;◊aCulvertI)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aCulvertI; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aCulInspCod; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Element Cat:32]; 0)
//Rating methods
ALL RECORDS:C47([Rating Method:67])
ORDER BY:C49([Rating Method:67]; [Rating Method:67]Code:1; >)
SELECTION TO ARRAY:C260([Rating Method:67]Code:1; <>aRatingMeth; [Rating Method:67]Description:2; <>aRatMethDes)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aRatingMeth; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aRatMethDes; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Rating Method:67]; 0)

//Integral bridge descriptions
ALL RECORDS:C47([Integral Bridge:71])
SELECTION TO ARRAY:C260([Integral Bridge:71]Code:1; <>aIntegralC; [Integral Bridge:71]Description:2; <>aIntegralD)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>aIntegralC; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aIntegralD; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Integral Bridge:71]; 0)

READ ONLY:C145([ElementDict:30])
ALL RECORDS:C47([ElementDict:30])
SELECTION TO ARRAY:C260([ElementDict:30]ElementNo:1; <>ELMTDICT_ELNum_ai; [ElementDict:30]Category:3; <>ELMTDICT_Cat_as; [ElementDict:30]Parent:4; <>ELMTDICT_Parent_ai)
SELECTION TO ARRAY:C260([ElementDict:30]Prefix:11; <>ELMTDICT_Prefix_as; [ElementDict:30]Part:12; <>ELMTDICT_Part_as; [ElementDict:30]Description:2; <>ELMTDICT_Txt_as; [ElementDict:30]IsParent:5; <>ELMTDICT_IsPar_ab)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>ELMTDICT_ELNum_ai; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_Cat_as; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_Parent_ai; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_Prefix_as; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_Part_as; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_Txt_as; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ELMTDICT_IsPar_ab; $Return_blb; *)
End if 
REDUCE SELECTION:C351([ElementDict:30]; 0)

//All categories for bridge safety inspection
ALL RECORDS:C47([Element Cat:32])
SELECTION TO ARRAY:C260([Element Cat:32]Code:1; <>ALLElmtCatCode_as; [Element Cat:32]Description:2; <>ALLElmtCatDesc_as)
If (Count parameters:C259=1)
	VARIABLE TO BLOB:C532(<>ALLElmtCatDesc_as; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>ALLElmtCatCode_as; $Return_blb; *)
End if 
REDUCE SELECTION:C351([Element Cat:32]; 0)

If (Count parameters:C259=1)
	$0:=$Return_blb
End if 