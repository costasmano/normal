//%attributes = {"invisible":true}
If (False:C215)
	//procedure: MHD_SIAFldHdr
	//by: Albert Leung
	//created: 12/11/97
	//purpose: header file for the variables used by SIA
End if 

ARRAY TEXT:C222(a_sBDEPT; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222(a_sBrKey; 0)  //Command Replaced was o_ARRAY string length was 12
ARRAY TEXT:C222(a_sBIN; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY BOOLEAN:C223(a_bFHWASel; 0)
ARRAY REAL:C219(a_rAASHTO; 0)
ARRAY DATE:C224(a_dPostD; 0)
ARRAY TEXT:C222(a_sPostSt; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY INTEGER:C220(a_iPost2ax; 0)
ARRAY INTEGER:C220(a_iPost3ax; 0)
ARRAY INTEGER:C220(a_iPost5ax; 0)
ARRAY INTEGER:C220(a_iOprH20; 0)
ARRAY INTEGER:C220(a_iOprType3; 0)
ARRAY INTEGER:C220(a_iOpr3S2; 0)
ARRAY INTEGER:C220(a_iOprHs; 0)
ARRAY INTEGER:C220(a_iInvH20; 0)
ARRAY INTEGER:C220(a_iInvType3; 0)
ARRAY INTEGER:C220(a_iInv3S2; 0)
ARRAY INTEGER:C220(a_iInvHS; 0)
ARRAY BOOLEAN:C223(a_bAntiMiss; 0)
ARRAY BOOLEAN:C223(a_bAcrow; 0)
ARRAY TEXT:C222(a_sBrName; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY BOOLEAN:C223(a_bBucket; 0)
ARRAY BOOLEAN:C223(a_bLadder; 0)
ARRAY BOOLEAN:C223(a_bBoat; 0)
ARRAY BOOLEAN:C223(a_bWader; 0)
ARRAY BOOLEAN:C223(a_bInsp50; 0)
ARRAY BOOLEAN:C223(a_bRigging; 0)
ARRAY BOOLEAN:C223(a_bStaging; 0)
ARRAY BOOLEAN:C223(a_bTraffic; 0)
ARRAY BOOLEAN:C223(a_bRRFlag; 0)
ARRAY BOOLEAN:C223(a_bPolice; 0)
ARRAY INTEGER:C220(a_iInspHRS; 0)
ARRAY DATE:C224(a_dCritDate; 0)
ARRAY BOOLEAN:C223(a_bCritInsp; 0)
ARRAY INTEGER:C220(a_iCritFreq; 0)
ARRAY DATE:C224(a_dClseDate; 0)
ARRAY BOOLEAN:C223(a_bClseInsp; 0)
ARRAY INTEGER:C220(a_iClseFreq; 0)
ARRAY DATE:C224(a_dDamage; 0)
ARRAY TEXT:C222(a_sItem5; 0)  //Command Replaced was o_ARRAY string length was 9
ARRAY TEXT:C222(a_sItem2; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem3; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(a_sItem4; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(a_sItem6A; 0)  //Command Replaced was o_ARRAY string length was 24
ARRAY TEXT:C222(a_sItem7; 0)  //Command Replaced was o_ARRAY string length was 18
ARRAY TEXT:C222(a_sItem9; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY REAL:C219(a_rItem11; 0)
ARRAY INTEGER:C220(a_iItem16A; 0)
ARRAY INTEGER:C220(a_iItem16B; 0)
ARRAY REAL:C219(a_rItem16C; 0)
ARRAY INTEGER:C220(a_iItem17A; 0)
ARRAY INTEGER:C220(a_iItem17B; 0)
ARRAY REAL:C219(a_rItem17C; 0)
ARRAY TEXT:C222(a_sItem98A; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(a_sItem98B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem99; 0)  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222(a_sItem43; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(a_sItem44; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY INTEGER:C220(a_iItem45; 0)
ARRAY INTEGER:C220(a_iItem46; 0)
ARRAY TEXT:C222(a_sItem107; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem108A; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem108B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem108C; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220(a_iItem27; 0)
ARRAY INTEGER:C220(a_iItem106; 0)
ARRAY TEXT:C222(a_sItem42; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220(a_iItem28A; 0)
ARRAY INTEGER:C220(a_iItem28B; 0)
ARRAY LONGINT:C221(a_LItem29; 0)
ARRAY INTEGER:C220(a_iItem30; 0)
ARRAY INTEGER:C220(a_iItem109; 0)
ARRAY INTEGER:C220(a_iItem19; 0)
ARRAY REAL:C219(a_rItem48; 0)
ARRAY REAL:C219(a_rItem49; 0)
ARRAY REAL:C219(a_rItem50A; 0)
ARRAY REAL:C219(a_rItem50B; 0)
ARRAY REAL:C219(a_rItem51; 0)
ARRAY REAL:C219(a_rItem52; 0)
ARRAY REAL:C219(a_rItem32; 0)
ARRAY TEXT:C222(a_sItem33; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220(a_iItem34; 0)
ARRAY BOOLEAN:C223(a_bItem35; 0)
ARRAY REAL:C219(a_rItem10; 0)
ARRAY REAL:C219(a_rItem47; 0)
ARRAY REAL:C219(a_rItem53; 0)
ARRAY TEXT:C222(a_sItem54A; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY REAL:C219(a_rItem54B; 0)
ARRAY TEXT:C222(a_sItem55A; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY REAL:C219(a_rItem55B; 0)
ARRAY REAL:C219(a_rItem56; 0)
ARRAY TEXT:C222(a_sItem38; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem111; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY REAL:C219(a_rItem39; 0)
ARRAY REAL:C219(a_rItem116; 0)
ARRAY REAL:C219(a_rItem40; 0)
ARRAY BOOLEAN:C223(a_bItem112; 0)
ARRAY BOOLEAN:C223(a_bItem104; 0)
ARRAY TEXT:C222(a_sItem26; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem100; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem101; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem102; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY BOOLEAN:C223(a_bItem103; 0)
ARRAY BOOLEAN:C223(a_bItem110; 0)
ARRAY TEXT:C222(a_sItem20; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem21; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem22; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem37; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem58; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem59; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem60; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem61; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem62; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem31; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY REAL:C219(a_rItem64; 0)
ARRAY REAL:C219(a_rItem66; 0)
ARRAY TEXT:C222(a_sItem70; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem41; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem67; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem68; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem69; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem71; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem72; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem36A; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem36B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem36C; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem36D; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem113; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem75A; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem75B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY REAL:C219(a_rItem76; 0)
ARRAY LONGINT:C221(a_LItem94; 0)
ARRAY LONGINT:C221(a_LItem95; 0)
ARRAY LONGINT:C221(a_LItem96; 0)
ARRAY INTEGER:C220(a_iItem97; 0)
ARRAY LONGINT:C221(a_LItem114; 0)
ARRAY INTEGER:C220(a_iItem115; 0)
ARRAY DATE:C224(a_dItem90; 0)
ARRAY INTEGER:C220(a_iItem91; 0)
ARRAY BOOLEAN:C223(a_bItem92AA; 0)
ARRAY INTEGER:C220(a_iItem92AB; 0)
ARRAY BOOLEAN:C223(a_bItem92BA; 0)
ARRAY INTEGER:C220(a_iItem92BB; 0)
ARRAY BOOLEAN:C223(a_bItem92CA; 0)
ARRAY INTEGER:C220(a_iItem92CB; 0)
ARRAY DATE:C224(a_dItem93A; 0)
ARRAY DATE:C224(a_dItem93B; 0)
ARRAY DATE:C224(a_dItem93C; 0)
ARRAY TEXT:C222(a_sTownName; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY BOOLEAN:C223(a_bItem12; 0)
ARRAY TEXT:C222(a_sItem13A; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(a_sItem13B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem63; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem65; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sItem105; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(a_sJntless; 0)  //Command Replaced was o_ARRAY string length was 2