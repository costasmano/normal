//%attributes = {"invisible":true}
//PM: ut_RetrieveBlobDocument 
//Description
//This method will be placed in startup instead of INIT_FIELDS_DES 
//If we are running client and the document named InitVariables.txt
//exists and the blob expands correctly, we will create arrays from the blob
//otherwise we will create arrays using the old method INIT_FIELDS_DES

If (False:C215)
	Mods_2004_CJM03
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(2/3/2006 10:13:38)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/19/07 10:19:19)
	Mods_2007_CM_5401
	//Added IsPar_b array for element dict
	// Modified by: costasmanousakis-(Designer)-(9/30/08 16:00:44)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Use method INIT_FIELDS_ARRAYS for consistancy.
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:30:56)
	Mods_2011_01
	//` RR -- also moved call to INIT_FIELDS_ARRAYS at the start since it was removed from INIT_FIELDS_DES
	
End if 
C_BOOLEAN:C305($UseFile_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

INIT_FIELDS_ARRAYS

$UseFile_b:=False:C215
$Filename:="InitVariables.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)

If ($UseFile_b=True:C214)
	
	C_LONGINT:C283($BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMaintOwner; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMaintCod; $BlobOffSet_l)
	
	//Initialize the Functional Class coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aFC; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aFC_Cod; $BlobOffSet_l)
	
	//Initialize the Design load coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDesignLoad; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDesLoadCod; $BlobOffSet_l)
	
	//Initialize the Posting code coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aPosting; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aPostCode; $BlobOffSet_l)
	
	//Initialize the Service Over coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aServiceOvr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aSerOvrCode; $BlobOffSet_l)
	
	//Initialize the Service Under coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aServUndr; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aSerUndrCod; $BlobOffSet_l)
	
	//Initialize the Material coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMaterial; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMatCode; $BlobOffSet_l)
	
	//Initialize the Design coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDesign; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDesignCod; $BlobOffSet_l)
	
	//Initialize the Truck coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTruck; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTruckCod; $BlobOffSet_l)
	
	//Initialize the Direction of traffic coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDirection; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDirCode; $BlobOffSet_l)
	
	//Initialize the Deck structure type coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDeck; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDeckCod; $BlobOffSet_l)
	
	//Initialize the Wearing surface coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aWearing; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aWearCod; $BlobOffSet_l)
	
	//Initialize the Membrane coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMembrane; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aMembCod; $BlobOffSet_l)
	
	//Initialize the Deck protection coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDeckProt; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aDeckPCod; $BlobOffSet_l)
	
	//Initialize Type of Work (Item 75A) coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTypeofWork; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aTypeofWCod; $BlobOffSet_l)
	
	//Initialize Type of Work (Item 75B) coding scheme
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aWorkDoneBy; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aWdoneBCod; $BlobOffSet_l)
	
	//Initialize Item 20 Toll
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem20des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem20; $BlobOffSet_l)
	
	//Initialize Item 33 Median
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem33des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem33; $BlobOffSet_l)
	
	//Initialize Item 38 Navigation control
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem38des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem38; $BlobOffSet_l)
	
	//Initialize Item 37 Historical Significance
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem37des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem37; $BlobOffSet_l)
	
	//Initialize Item 100 Defense Highway Designation
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem100des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem100; $BlobOffSet_l)
	
	//Initialize Item 101 Parallel structure designation
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem101des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem101; $BlobOffSet_l)
	
	//Initialize Item 111 Pier protection
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem111des; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aItem111; $BlobOffSet_l)
	
	//Initialize Foundation type
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aFndtion; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aFndCode; $BlobOffSet_l)
	
	//Inspection Responsibility
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aInspRdes; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aInspRcod; $BlobOffSet_l)
	
	//Posting status
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aPostStat; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aPostStatC; $BlobOffSet_l)
	
	//Inspection categories for regular bridge safety inspection
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aInspType; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aInspCod; $BlobOffSet_l)
	
	//Inspection categories for culvert bridge safety inspection
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aCulvertI; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aCulInspCod; $BlobOffSet_l)
	
	//Rating methods
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRatingMeth; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aRatMethDes; $BlobOffSet_l)
	
	//Integral bridge descriptions
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aIntegralC; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>aIntegralD; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_ELNum_ai; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_Cat_as; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_Parent_ai; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_Prefix_as; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_Part_as; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_Txt_as; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ELMTDICT_IsPar_ab; $BlobOffSet_l)
	
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ALLElmtCatDesc_as; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBLobDocArrays; <>ALLElmtCatCode_as; $BlobOffSet_l)
	
Else 
	INIT_FIELDS_DES
End if 
SET BLOB SIZE:C606(vBlobDocArrays; 0)