clear
import excel "C:\Users\hollappa\Desktop\McCourt School of Public Policy\Data\Mod_Detailed_Data_on_Preferences_of_Govt_School_Teachers_in_Tamil_Nadu.xlsx", sheet("Sheet1") firstrow
ssc install spmap
ssc install shp2dta

cd "C:\Users\hollappa\Desktop\McCourt School of Public Policy\Data\IND_adm"
//Download shape files from "http://www.diva-gis.org/gdata"
shp2dta using IND_adm2, data(india_data) coor(india_coordinates) genid(id)
desc

destring NoofTeacherssendingtheiro H TotalNoofteachersreportedt TotalNoofGovtSchoolTeache, replace
desc

gen sendToPrivateSchools = regexs(0) if regexm(NoofTeacherssendingtheiro, "(^[0-9]+)*" )
gen sendToGovtSchools = regexs(0) if regexm(H, "(^[0-9]+)*" )
//replace test = regexs(1) if regexm(H, "([0-9]+)[*]" )
//replace test = regexs(1) if regexm(H, "([0-9]+)[+]([0-9]+)[*]" )
//gen test = regexs(1) if regexm(NoofTeacherssendingtheiro, "([0-9]+)[+]([0-9]+)[*]" )
drop Remarks
destring sendToPrivateSchools sendToGovtSchools, replace

replace District = "Nagapattinam" if (District == "Nagapattinam ")
collapse (sum) TotalNoofteachersreportedt sendToPrivateSchools sendToGovtSchools , by(District)

gen percentagePvtSchool = (sendToPrivateSchools/TotalNoofteachersreportedt) * 100
