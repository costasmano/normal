SCPOA_Descr2_txt:=SCPOA_CopyScourNotes
C_BOOLEAN:C305(SCPOA_Desc2Chg_b)
SCPOA_Desc2Chg_b:=True:C214
VARIABLE TO BLOB:C532(SCPOA_Descr2_txt; [ScourPOA:132]ScourHistory:7)
COMPRESS BLOB:C534([ScourPOA:132]ScourHistory:7)
PushChange(1; ->[ScourPOA:132]ScourHistory:7)