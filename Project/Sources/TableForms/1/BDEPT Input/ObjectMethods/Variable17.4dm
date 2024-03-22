If (False:C215)
	//Object Method: [Bridge MHD NBIS];"BDEPT Input".bGetRef 
	//Button for getting information from a bridge with the same bdept
	// Modified by: costasmanousakis-(Designer)-(6/3/10 16:59:07)
	Mods_2010_06
	//Added additional fields from the existing records
	// Modified by: costasmanousakis-(Designer)-(8/27/10 15:42:51)
	Mods_2010_08
	//  `Added Item8 Owner
	// Modified by: costasmanousakis-(Designer)-(10/20/10 12:13:28)
	Mods_2010_10
	//  `Added [Bridge MHD NBIS]LegacyOwner
	// Modified by: costasmanousakis-(Designer)-(6/20/11 10:43:47)
	Mods_2011_06
	//  `Added RR info, Agency Bridge no
	// Modified by: costasmanousakis-(Designer)-(12/14/11 09:51:56)
	Mods_2011_12
	//  `Switched from aItem7 to RefBINSelector_atxt
	// Modified by: Costas Manousakis-(Designer)-(8/19/13 15:10:54)
	Mods_2013_08
	//  `Added townLine; 
	//  ` USE SQL Call to get the variables. 
End if 


BIN_txt:=[Bridge MHD NBIS:1]BDEPT:1

If (False:C215)
	C_TEXT:C284($bdept)  // Command Replaced was o_C_STRING length was 6
	$bdept:=[Bridge MHD NBIS:1]BDEPT:1
	PUSH RECORD:C176([Bridge MHD NBIS:1])
	//Look for other bridges with the same BDEPT
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$bdept)
	ARRAY TEXT:C222($RefItem8_atxt; Records in selection:C76([Bridge MHD NBIS:1]))
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Bridge Key:2; abrkey; [Bridge MHD NBIS:1]Item5:59; aItem5; [Bridge MHD NBIS:1]Item6A:63; aItem6; [Bridge MHD NBIS:1]Item8:206; $RefItem8_atxt)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item6B:64; aItem6b; [Bridge MHD NBIS:1]Item7:65; aItem7; [Bridge MHD NBIS:1]Item9:66; aItem9; [Bridge MHD NBIS:1]Item11:67; aItem11)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item16A:68; aItem16a; [Bridge MHD NBIS:1]Item16B:69; aItem16b; [Bridge MHD NBIS:1]Item16C:109; aItem16c)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item17A:70; aItem17a; [Bridge MHD NBIS:1]Item17B:71; aItem17b; [Bridge MHD NBIS:1]Item17C:136; aItem17c)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item98A:72; aItem98a; [Bridge MHD NBIS:1]Item98B:73; aItem98b; [Bridge MHD NBIS:1]Item99:74; aItem99; [Bridge MHD NBIS:1]OnTwnLine:177; aTownLineb)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]InspResp:173; aInspResp; [Bridge MHD NBIS:1]Item8 Owner:208; Item8Owner_as; [Bridge MHD NBIS:1]LegacyOwner:226; Item8LegacyOwner_as)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item42:85; Item42_as; [Bridge MHD NBIS:1]Item29:88; Item29_aL; [Bridge MHD NBIS:1]Item30:89; Item30_ai; [Bridge MHD NBIS:1]Item109:90; Item109_ai; [Bridge MHD NBIS:1]Item19:91; Item19_ai; [Bridge MHD NBIS:1]Item38:113; Item38_as; [Bridge MHD NBIS:1]Item104:119; Item104_ab; [Bridge MHD NBIS:1]Item26:120; Item26_as; [Bridge MHD NBIS:1]Item100:121; Item100_as; [Bridge MHD NBIS:1]Item101:122; Item101_as)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item102:123; Item102_as; [Bridge MHD NBIS:1]Item 105:201; Item105_as; [Bridge MHD NBIS:1]Item110:125; Item110_ab; [Bridge MHD NBIS:1]Item20:126; Item20_as; [Bridge MHD NBIS:1]Item21:127; Item21_as; [Bridge MHD NBIS:1]Item22:128; Item22_as; [Bridge MHD NBIS:1]Bridge Name:29; BridgeName_as; [Bridge MHD NBIS:1]ParallelBIN:27; ParBIN_as)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]RRBranch:210; RRBranch_as; [Bridge MHD NBIS:1]RRBridgeNo:211; RRBridgeNo_ar; [Bridge MHD NBIS:1]AgencyBrNo:209; AgencyBrNo_as)
	C_LONGINT:C283($loop_L)
	ARRAY TEXT:C222(RefBINSelector_atxt; Size of array:C274(aItem7))
	For ($loop_L; 1; Size of array:C274(aItem7))
		RefBINSelector_atxt{$loop_L}:=aItem7{$loop_L}+"- "+$RefItem8_atxt{$loop_L}
	End for 
	
	POP RECORD:C177([Bridge MHD NBIS:1])
	ONE RECORD SELECT:C189([Bridge MHD NBIS:1])
Else 
	C_TEXT:C284(BIN_txt)
	BIN_txt:=[Bridge MHD NBIS:1]BDEPT:1
	
	Begin SQL
		select
		BR.[Bridge Key], BR.[Item5], BR.[Item6A], CONCAT(CONCAT (BR.Item7,' - '), BR.[Item8]), BR.[Item6B],
		BR.Item7, BR.Item9, BR.Item11, BR.Item16A, BR.Item16B, BR.Item16C, BR.Item17A, BR.Item17B, BR.Item17C, BR.Item98A, BR.Item98B, BR.Item99,
		BR.OnTwnLine, BR.InspResp, BR.[Item8 Owner], BR.LegacyOwner, BR.Item42, BR.Item29, BR.Item30, BR.Item109, BR.Item19, BR.Item38, BR.Item104,
		BR.Item26, BR.Item100, BR.[Item101], BR.[Item102], BR.[Item 105], BR.[Item110], BR.[Item20], BR.[Item21], BR.[Item22], BR.[Bridge Name], BR.[ParallelBIN], 
		BR.[RRBranch], BR.[RRBridgeNo], BR.[AgencyBrNo]
		
		FROM [Bridge MHD NBIS] AS BR
		WHERE
		BR.BDEPT = :BIN_txt
		Into
		:abrkey, :aItem5, :aItem6, :RefBINSelector_atxt, :aItem6b,:aItem7, :aItem9, :aItem11, :aItem16a, :aItem16b, :aItem16c, :aItem17a, :aItem17b, :aItem17c, :aItem98a, :aItem98b, :aItem99,
		:aTownLineb, :aInspResp, :Item8Owner_as, :Item8LegacyOwner_as, :Item42_as, :Item29_aL, :Item30_ai, :Item109_ai, :Item19_ai, :Item38_as, :Item104_ab, :Item26_as,
		:Item100_as, :Item101_as, :Item102_as, :Item105_as, :Item110_ab, :Item20_as, :Item21_as, :Item22_as, :BridgeName_as, :ParBIN_as, :RRBranch_as,
		:RRBridgeNo_ar, :AgencyBrNo_as
		;
	End SQL
	
End if 

RefBINSelector_atxt:=0

If (Size of array:C274(RefBINSelector_atxt)>0)
	RefBINSelector_atxt{0}:="Select a Record to copy...."
Else 
	RefBINSelector_atxt{0}:="No reference bridge ...."
End if 