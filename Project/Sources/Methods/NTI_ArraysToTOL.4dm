//%attributes = {"invisible":true}
C_TEXT:C284($Path_txt)
//****
// Use utl_ImportTOLRecords  to load the results
//

ARRAY TEXT:C222(NTI_i8_s_atxt; 5)
NTI_i8_s_atxt{1}:="0 - Two route directions"
NTI_i8_s_atxt{2}:="1 - North"
NTI_i8_s_atxt{3}:="2 - East"
NTI_i8_s_atxt{4}:="3 - South"
NTI_i8_s_atxt{5}:="4 - West"

utl_ExportTOLFromArrays(->NTI_i8_s_atxt; "NTI_i8_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_i9_L_atxt; 8)
NTI_i9_L_atxt{1}:="1 - Interstate Highway"
NTI_i9_L_atxt{2}:="2 - U.S. Numbered Highway"
NTI_i9_L_atxt{3}:="3 - State Highway"
NTI_i9_L_atxt{4}:="4 - County Highway"
NTI_i9_L_atxt{5}:="5 - City Street"
NTI_i9_L_atxt{6}:="6 - Federal Lands Road"
NTI_i9_L_atxt{7}:="7 - State Lands Road"
NTI_i9_L_atxt{8}:="8 - Other (includes toll roads not otherwise indicated above"
utl_ExportTOLFromArrays(->NTI_i9_L_atxt; "NTI_i9_L"; ->$Path_txt)

ARRAY TEXT:C222(NTI_i18_s_atxt; 3)
NTI_i18_s_atxt{1}:="0 - No responsibility"
NTI_i18_s_atxt{2}:="1 - Shared responsibility with bordering State or country"
NTI_i18_s_atxt{3}:="2 - Full responsibility"
utl_ExportTOLFromArrays(->NTI_i18_s_atxt; "NTI_i18_s"; ->$Path_txt)


ARRAY TEXT:C222(NTI_A8_L_atxt; 5)
NTI_A8_L_atxt{1}:="1 - Highway"
NTI_A8_L_atxt{2}:="2 - Highway and Railroad"
NTI_A8_L_atxt{3}:="3 - Highway and Pedestrian"
NTI_A8_L_atxt{4}:="4 - Highway, Railroad and Pedestrian"
NTI_A8_L_atxt{5}:="5 - Other"
utl_ExportTOLFromArrays(->NTI_A8_L_atxt; "NTI_A8_L"; ->$Path_txt)

ARRAY TEXT:C222(NTI_C1_s_atxt; 34)

NTI_C1_s_atxt{1}:="01 - State Highway Agency"
NTI_C1_s_atxt{2}:="02 - County Highway Agency"
NTI_C1_s_atxt{3}:="03 - Town or Township Highway Agency"
NTI_C1_s_atxt{4}:="04 - City or Municipal Highway Agency"
NTI_C1_s_atxt{5}:="11 - State Park, Forest, or Reservation Agency"
NTI_C1_s_atxt{6}:="12 - Local Park, Forest, or Reservation Agency"
NTI_C1_s_atxt{7}:="21 - Other State Agencies "
NTI_C1_s_atxt{8}:="25 - Other Local Agencies"
NTI_C1_s_atxt{9}:="26 - Private (other than railroad)"
NTI_C1_s_atxt{10}:="27 -Railroad"
NTI_C1_s_atxt{11}:="31 - State Toll Authority"
NTI_C1_s_atxt{12}:="32 - Local Toll Authority"
NTI_C1_s_atxt{13}:="57 - General Services Administration (GSA)"
NTI_C1_s_atxt{14}:="58 - Smithsonian – National Zoo"
NTI_C1_s_atxt{15}:="59 - National Security Agency (NSA)"
NTI_C1_s_atxt{16}:="60 - Other Federal Agencies (not listed)"
NTI_C1_s_atxt{17}:="61 - Indian Tribal Government"
NTI_C1_s_atxt{18}:="62 - Bureau of Indian Affairs (BIA)"
NTI_C1_s_atxt{19}:="63 - Bureau of Fish and Wildlife (FWS)"
NTI_C1_s_atxt{20}:="64 - U.S. Forest Service (USFS)"
NTI_C1_s_atxt{21}:="66 - National Park Service (NPS)"
NTI_C1_s_atxt{22}:="67 - Tennessee Valley Authority (TVA)"
NTI_C1_s_atxt{23}:="68 - Bureau of Land Management (BLM)"
NTI_C1_s_atxt{24}:="69 - Bureau of Reclamation (USBR)"
NTI_C1_s_atxt{25}:="70 - U.S. Army Corps of Engineers"
NTI_C1_s_atxt{26}:="72 - Air Force"
NTI_C1_s_atxt{27}:="73 - Navy/Marines"
NTI_C1_s_atxt{28}:="74 - Army"
NTI_C1_s_atxt{29}:="75 - National Aeronautics and Space Administration (NASA)"
NTI_C1_s_atxt{30}:="76 - Metropolitan Washington Airports Service"
NTI_C1_s_atxt{31}:="77 - Pentagon"
NTI_C1_s_atxt{32}:="78 - Agriculture Research Service (ARS)"
NTI_C1_s_atxt{33}:="79 - Department of Energy (DOE)"
NTI_C1_s_atxt{34}:="80 - Other"
utl_ExportTOLFromArrays(->NTI_C1_s_atxt; "NTI_C1_s"; ->$Path_txt)


ARRAY TEXT:C222(NTI_C3_s_atxt; 5)

NTI_C3_s_atxt{1}:="0 - Highway traffic not carried"
NTI_C3_s_atxt{2}:="1 - 1-way traffic"
NTI_C3_s_atxt{3}:="2 - 2-way traffic"
NTI_C3_s_atxt{4}:="3 - Variable traffic"
NTI_C3_s_atxt{5}:="4 - One lane 2-way traffic"

utl_ExportTOLFromArrays(->NTI_C3_s_atxt; "NTI_C3_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_C4_s_atxt; 3)
NTI_C4_s_atxt{1}:="0 - No tolls"
NTI_C4_s_atxt{2}:="1 - Toll tunnel"
NTI_C4_s_atxt{3}:="2 - On toll route"
utl_ExportTOLFromArrays(->NTI_C4_s_atxt; "NTI_C4_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_C7_L_atxt; 7)
NTI_C7_L_atxt{1}:="1 - Interstate"
NTI_C7_L_atxt{2}:="2 -  Principal Arterial – Other Freeways and Expressways"
NTI_C7_L_atxt{3}:="3 - Principal Arterial-Other"
NTI_C7_L_atxt{4}:="4 - Minor Arterial"
NTI_C7_L_atxt{5}:="5 - Major Collector"
NTI_C7_L_atxt{6}:="6 -  Minor  Collector"
NTI_C7_L_atxt{7}:="7 - Local"
utl_ExportTOLFromArrays(->NTI_C7_L_atxt; "NTI_C7_L"; ->$Path_txt)



ARRAY TEXT:C222(NTI_L1_s_atxt; 8)
NTI_L1_s_atxt{1}:="0 - Field evaluation and documented engineering judgment"
NTI_L1_s_atxt{2}:="1 - Load Factor(LF)"
NTI_L1_s_atxt{3}:="2 - Allowable Stress(AS)"
NTI_L1_s_atxt{4}:="3 - Load and Resistance Factor(LRFR)"
NTI_L1_s_atxt{5}:="4 - Load Testing"
NTI_L1_s_atxt{6}:="5 - No rating analysis or evaluation performed"
NTI_L1_s_atxt{7}:="A - Assigned rating"
NTI_L1_s_atxt{8}:="N - Load rating is not required"
utl_ExportTOLFromArrays(->NTI_L1_s_atxt; "NTI_L1_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_L4_s_atxt; 8)
NTI_L4_s_atxt{1}:="A - No restriction"
NTI_L4_s_atxt{2}:="B - Posting or posting reduction recommended, but not implemented"
NTI_L4_s_atxt{3}:="D - Would be posted or closed, but temporary shoring or similar allows for unrestricted traffic"
NTI_L4_s_atxt{4}:="E - Temporary structure in place to carry legal loads while tunnel is closed and awaiting replacement or rehabilitation"
NTI_L4_s_atxt{5}:="G - New tunnel not opened  to traffic"
NTI_L4_s_atxt{6}:="K - Tunnel closed to all traffic"
NTI_L4_s_atxt{7}:="P - Posted with weight limit sign(s)"
NTI_L4_s_atxt{8}:="R - Posted with  other load  restriction sign(s)"
utl_ExportTOLFromArrays(->NTI_L4_s_atxt; "NTI_L4_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_S2_L_atxt; 4)
NTI_S2_L_atxt{1}:="1 - Oval"
NTI_S2_L_atxt{2}:="2 - Horseshoe"
NTI_S2_L_atxt{3}:="3 - Retangular"
NTI_S2_L_atxt{4}:="4 - Circular"
utl_ExportTOLFromArrays(->NTI_S2_L_atxt; "NTI_S2_L"; ->$Path_txt)

ARRAY TEXT:C222(NTI_S3_L_atxt; 5)
NTI_S3_L_atxt{1}:="1 - Oval"
NTI_S3_L_atxt{2}:="2 - Horseshoe"
NTI_S3_L_atxt{3}:="3 - Retangular"
NTI_S3_L_atxt{4}:="4 - Circular"
NTI_S3_L_atxt{5}:="5 - Other"
utl_ExportTOLFromArrays(->NTI_S3_L_atxt; "NTI_S3_L"; ->$Path_txt)

ARRAY TEXT:C222(NTI_S4_L_atxt; 3)
NTI_S4_L_atxt{1}:="1 - Soil"
NTI_S4_L_atxt{2}:="2 - Rock"
NTI_S4_L_atxt{3}:="3 - Mixed Face"

utl_ExportTOLFromArrays(->NTI_S4_L_atxt; "NTI_S4_L"; ->$Path_txt)

ARRAY TEXT:C222(NTI_N3_s_atxt; 5)
NTI_N3_s_atxt{1}:="0 - Navigation protection not required or not under navigable waterway"
NTI_N3_s_atxt{2}:="1 - In place and functioning"
NTI_N3_s_atxt{3}:="2 - In place but in a deteriorated condition"
NTI_N3_s_atxt{4}:="3 - In place but reevaluation of design suggested"
NTI_N3_s_atxt{5}:="4 - None present but reevaluation suggested"
utl_ExportTOLFromArrays(->NTI_N3_s_atxt; "NTI_N3_s"; ->$Path_txt)


ARRAY TEXT:C222(NTI_C8_s_atxt; 11)
NTI_C8_s_atxt{1}:="05167 - Barnstable Town, MA"
NTI_C8_s_atxt{2}:="09271 - Boston, MA-NH-RI"
NTI_C8_s_atxt{3}:="49096 - Leominster-Fitchburg, MA"
NTI_C8_s_atxt{4}:="61165 - Nashua, NH-MA"
NTI_C8_s_atxt{5}:="61786 - New Bedford, MA"
NTI_C8_s_atxt{6}:="69778 -Pittsfield, MA "
NTI_C8_s_atxt{7}:="72505 - Providence, RI-MA"
NTI_C8_s_atxt{8}:="83926 - Springfield, MA-CT"
NTI_C8_s_atxt{9}:="97291 - Worcester, MA-CT"
NTI_C8_s_atxt{10}:="99999 - Urtban area Population < 5,000 "
NTI_C8_s_atxt{11}:="99998 - Urtban area Population 5,000 to 49,000"
C_TEXT:C284($Path_txt)

utl_ExportTOLFromArrays(->NTI_C8_s_atxt; "NTI_C8_s"; ->$Path_txt)


ARRAY TEXT:C222(NTI_TunnelID_atxt; 0)

APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "90E")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "90W")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "93N")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "93S")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "ARR")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "CAE")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "CAL")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "CAS")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "CNS")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "PRE")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "PRW")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "RPD")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "RPL")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "SUM")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "TWE")
APPEND TO ARRAY:C911(NTI_TunnelID_atxt; "TWW")
utl_ExportTOLFromArrays(->NTI_TunnelID_atxt; "NTI_TunnelID_s"; ->$Path_txt)


ARRAY TEXT:C222(NTI_VentID_atxt; 0)
APPEND TO ARRAY:C911(NTI_VentID_atxt; "AIS")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "CNS")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "D01")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "EB1")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "EB2")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "EB3")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "HO1")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "NB1")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "NB2")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "NB3")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "NB4")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "SB1")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "SB2")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "SB3")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V24")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V25")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V26")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V27")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V28")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V29")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "V30")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "WB1")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "WB2")
APPEND TO ARRAY:C911(NTI_VentID_atxt; "WB3")
utl_ExportTOLFromArrays(->NTI_VentID_atxt; "NTI_VentID_s"; ->$Path_txt)

ARRAY TEXT:C222(NTI_Owner_atxt; 0)
APPEND TO ARRAY:C911(NTI_Owner_atxt; "DOT")
APPEND TO ARRAY:C911(NTI_Owner_atxt; "MPA")
utl_ExportTOLFromArrays(->NTI_Owner_atxt; "NTI_Owner_s"; ->$Path_txt)

ALERT:C41("Arrays to TOL complete!")