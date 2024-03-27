	-- =============================================
-- Author: VEGHER EMMANUEL
-- Modified date: 06/08/2021
-- Description: Query to select HTS_TST Line Listing
-- =============================================
SET @startdate = '2023-01-01';
SET @enddate = '2023-03-31';
SET @row_number = 0;SET @row_number1 = 0;SET @row_number2 = 0;SET @row_number3 = 0;SET @row_number4 = 0;SET @row_number5 = 0;SET @row_number6 = 0;

-- =====================================================
-- Create function for concept_id
-- ===============================================
DELIMITER $$


DROP FUNCTION IF EXISTS `get_concept_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_concept_name`(conceptid INT) RETURNS TEXT CHARSET latin1 
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT NAME FROM  concept_name  WHERE concept_id = conceptid AND locale = 'en' AND locale_preferred = 1 LIMIT 1);
	
	
    END$$
    
DELIMITER ;

-- =========================================
-- Table for LGA Latitude and Longitude
-- =========================================

DROP TABLE IF EXISTS Latitude_Temp;
CREATE TABLE Latitude_Temp (state VARCHAR(50),LGA VARCHAR(250),Latitude VARCHAR(250),Longitude VARCHAR(250));
INSERT  INTO Latitude_Temp(`State`,`LGA`,Latitude,Longitude) VALUES

("Abia","ABA NORTH","5.1268","7.3679"),	("Abia","ABA SOUTH","5.0703","7.3409"),	("Abia","AROCHUKWU","5.3894","7.9123"),	("Abia","BENDE","5.5587","7.6336"),	("Abia","IKWUANO","5.4093","7.5897"),	("Abia","ISIALA NGWA NORTH","5.4063","7.5682"),	("Abia","ISIALA NGWA SOUTH","5.2868","7.4165"),	("Abia","ISUIKWUATO","5.807","7.4814"),	("abia","OBINGWA","5.1443","7.465"),	("Abia","OHAFIA","5.6223","7.8571"),	("Abia","OSISIOMA","5.1598","7.3223"),	("Abia","UGWUNAGBO","4.9981","7.3301"),	("Abia","UKWA EAST","4.9146","7.4165"),	("Abia","UKWA WEST","4.9165","7.2437"),	("Abia","UMUAHIA NORTH","5.5333","7.4833"),	("Abia","UMUAHIA SOUTH","5.4947","7.4165"),	("Abia","UMUNNEOCHI","5.9545","7.4165"),
("Adamawa","Demsa","9.4557","12.1525"),	("Adamawa","Fufore","9.2217","12.6497"),("Adamawa","Ganye","8.435","12.0511"),	("Adamawa","Girei","9.3653","12.5462"),	("Adamawa","Gombi","10.1676","12.7368"),	("Adamawa","Guyuk","9.9066","11.9275"),	("Adamawa","Hong","10.233","12.9281"),	("Adamawa","Jada","8.7568","12.1554"),	("Adamawa","Lamurde","9.6082","11.7932"),	("Adamawa","Madagali","10.8909","13.6276"),	("Adamawa","Maiha","9.9967","13.2167"),	("Adamawa","Mayo-Belwa","9.0542","12.0579"),	("Adamawa","Michika","10.6204","13.3893"),	("Adamawa","Mubi North","10.3845","13.3125"),	("Adamawa","Mubi South","10.186","13.3356"),	("Adamawa","Numan","9.4669","12.0328"),	("Adamawa","Shelleng","9.8965","12.0057"),	("Adamawa","Song","9.8267","12.6238"),	("Adamawa","Toungo","8.1173","12.0461"),	("Adamawa","Yola North","9.1737","12.4151"),	("Adamawa","Yola South","9.2606","12.4151"),
("Akwa Ibom","Abak","4.9824","7.7892"),	("Akwa Ibom","Eastern Obolo","4.5116","7.6657"),("Akwa Ibom","Eket","4.6423","7.9244"),	("Akwa Ibom","Esit Eket","4.6607","8.0683"),	("Akwa Ibom","Essien Udim","5.1185","7.6331"),	("Akwa Ibom","Etim Ekpo","4.9946","7.6331"),("Akwa Ibom","Etinan","4.8426","7.8525"),("Akwa Ibom","Ibeno","4.5778","8.1557"),	("Akwa Ibom","Ibesikpo Asutan","4.9188","7.9484"),	("Akwa Ibom","IBIONO IBOM","5.1981","7.8939"),	("Akwa Ibom","Ika","5.0061","7.5356"),	("Akwa Ibom","Ikono","5.1992","7.8069"),	("Akwa Ibom","Ikot Abasi","4.5704","7.56"),	("Akwa Ibom","IKOT EKPENE","5.1819","7.7148"),	("Akwa Ibom","Ini","5.3866","7.7417"),	("Akwa Ibom","ITU","5.464","7.3308"),	("Akwa Ibom","MBO","4.6483","8.2541"),	("Akwa Ibom","MKPAT ENIN","4.7348","7.749"),	("Akwa Ibom","Nsit Atai","4.8253","8.0247"),	("Akwa Ibom","NSIT IBOM","4.8987","7.9048"),	("Akwa Ibom","Nsit Ubium","4.7442","7.9375"),	("Akwa Ibom","Obot Akara","5.2433","7.5897"),	("Akwa Ibom","Okobo","4.8243","8.1120"),	("Akwa Ibom","Onna","4.5812","7.8504"),	("Akwa Ibom","ORON","4.8217","8.235"),	("Akwa Ibom","ORUK ANAM","4.7882","7.6765"),	("Akwa Ibom","UDUNG UKO","4.7507","8.2541"),	("Akwa Ibom","Ukanafun","4.9127","7.5897"),	("Akwa Ibom","URUAN","5.0307","8.0683"),	("Akwa Ibom","Urue Offong Oruko","4.7006","8.1557"),	("Akwa Ibom","Uyo","5.008","7.85"),
("Anambra","AGUATA","6.0163","7.0878"),	("Anambra","AKWA NORTH","6.2636","7.1252"),	("Anambra","AKWA SOUTH","6.2116","7.0714"),	("Anambra","ANAMBRA EAST","6.3093","6.8673"),	("Anambra","ANAMBRA WEST","6.4902","6.7922"),	("Anambra","Anaocha","6.0964","7.0176"),	("Anambra","Ayamelum","6.4878","6.9639"),	("Anambra","DUNUKOFIA","6.2010","6.9786"),	("Anambra","EKWUSIGO","6.0302","6.8512"),	("Anambra","IDEMILI NORTH","6.1237","6.9478"),	("Anambra","IDEMILI SOUTH","6.0773","6.8673"),	("Anambra","IHIALA","5.8548","6.8594"),	("Anambra","NJIKOKA","6.1784","6.9880"),	("Anambra","NNEWI NORTH","6.0137","6.9102"),	("Anambra","NNEWI SOUTH","5.9602","6.9853"),	("Anambra","OGBARU","5.9213","6.7280"),	("Anambra","ONITSHA","6.1329","6.7924"),	("Anambra","ONITSHA NORTH","6.1624","6.8029"),	("Anambra","ONITSHA SOUTH","6.1364","6.7762"),	("Anambra","ORUMBA NORTH","6.0543","7.2194"),	("Anambra","ORUMBA SOUTH","5.9994","7.2006"),	("Anambra","OYI","6.2246","6.8887"),
("Bauchi","ALKALERI","10.2669","10.3324"),	("Bauchi","BAUCHI","10.3158","9.8442"),	("Bauchi","BOGORO","9.669","9.6053"),	("Bauchi","BRASS","4.3078","6.2456"),	("Bauchi","DAMBAM","11.6789","10.7079"),	("Bauchi","DARAZO","10.9992","10.4106"),	("Bauchi","DASS","10.0007","9.516"),	("Bauchi","EKEREMOR","5.0581","5.7805"),	("Bauchi","GAMAWA","12.1338","10.5379"),	("Bauchi","GANJUWA","10.7290","9.9912"),	("Bauchi","GIADE","11.3908","10.1999"),	("Bauchi","ITAS GADAW","11.9343","10.1255"),	("Bauchi","JAMAARE","11.6697","9.9283"),	("Bauchi","KATAGUM","12.2851","10.3503"),	("Bauchi","KIRFI","10.4056","10.4045"),	("Bauchi","KOLOKUMA/OPOKUMA","5.0920","6.2588"),	("Bauchi","MISAU","11.3137","10.4666"),	("Bauchi","NEMBE","4.5367","6.4033"),	("Bauchi","NINGI","11.0784","9.5689"),	("Bauchi","OGBIA","4.6884","6.3153"),	("Bauchi","SAGBAMA","5.1591","6.1967"),	("Bauchi","SHIRA","13.7451","76.8980"),	("Bauchi","TAFAWA BALEWA","9.7602","9.5517"),	("Bauchi","TORO","10.0589","9.0691"),	("Bauchi","WARJI","11.1776","9.7524"),	("Bauchi","ZAKI","10.3010","9.8237"),
("Bayelsa","SOUTHERN IJAW","4.6198","5.9833"),	("Bayelsa","YENAGOA","4.9267","6.2676"),
("Benue","ADO","7.7821","7.6206"),	("Benue","AGATU","7.8412","7.9157"),	("Benue","APA","7.6296","7.8711"),	("Benue","BURUKU","7.4596","9.2045"),	("Benue","GBOKO","7.3228","9.0011"),	("Benue","GUMA","7.96667","8.76667"),	("Benue","GWER","7.6639","8.1776"),	("Benue","GWER WEST","7.6639","8.1776"),	("Benue","KATSINA - ALA","7.1658","9.2841"),	("Benue","KONSHISHA","7.0997","8.5721"),	("Benue","KWANDE","6.9126","9.4562"),	("Benue","LOGO","7.5987","9.2786"),	("Benue","MAKURDI","7.73","8.53"),	("Benue","OBI","8.3692","8.7738"),	("Benue","OBI","8.3692","8.7738"),	("Benue","OGBADIBO","6.9876","7.6548"),	("Benue","OHIMINI","7.2396","7.9157"),	("Benue","OJU","6.8453","8.4191"),	("Benue","OKPOKWU","7.0701","7.8286"),	("Benue","OTUKPO","7.1904","8.13"),	("Benue","TARKA","7.6299","8.8142"),	("Benue","UKUM","7.5909","9.6341"),	("Benue","USHONGO","7.1348","8.9687"),	("Benue","VANDEIKYA","6.7848","9.068"),
("Borno","ABADAM","13.6182","13.2649"),	("Borno","ASKIRA/UBA","10.6563","13.1279"),	("Borno","BAMA","11.5204","13.69"),	("Borno","BAYO","10.2729","11.6613"),	("Borno","BIU","10.6204","12.19"),	("Borno","CHIBOK","10.8695","12.8466"),	("Borno","DAMBOA","11.1553","12.7564"),	("Borno","DIKWA","12.0361","13.9182"),	("Borno","GUBIO","12.4975","12.7809"),	("Borno","GUZAMALA","12.8817","13.2202"),	("Borno","GWOZA","11.0831","13.6959"),	("Borno","HAWUL","10.4676","12.3464"),	("Borno","JERE","11.89912","13.29155"),	("Borno","KAGA","11.80919","12.49151"),	("Borno","KALA/BALGE","12.04639","14.48093"),	("Borno","KONDUGA","11.6533","13.4179"),	("Borno","KUKAWA","12.9248","13.5662"),	("Borno","KWAYA","10.5008","11.8407"),	("Borno","MAFA","11.9242","13.6007"),	("Borno","MAGUMERI","12.1145","12.8262"),	("Borno","MAIDUGURI","11.8333","13.15"),	("Borno","MARTE","12.365","13.8302"),	("Borno","MOBBAR","13.1330","12.7135"),	("Borno","MONGUNO","12.6706","13.6122"),	("Borno","NGALA","12.3421","14.1858"),	("Borno","NGANZAI","12.5736","13.0818"),	("Borno","SHANI","10.2182","12.0606"),
("Cross River","ABI","5.89147","8.02187"),	("Cross River","AKAMKPA","5.3125","8.3552"),	("Cross River","AKPABUYO","4.8808","8.5282"),	("Cross River","BAKASSI","4.6135","8.5941"),	("Cross River","BEKWARA","6.6900","8.9025"),	("Cross River","BIASE","5.5483","8.0902"),	("Cross River","BOKI","6.2467","8.9245"),	("Cross River","Calabar Municipal","5.0166","8.3636"),	("Cross River","CALABAR SOUTH","4.8627","8.3307"),	("Cross River","ETUNG","5.8717","8.7922"),	("Cross River","IKOM","5.9624","8.7082"),	("Cross River","Obanliku","6.5344","9.3229"),	("Cross River","OBUBRA","6.0767","8.3324"),	("Cross River","OBUDU","6.6682","9.1645"),	("Cross River","ODUKPANI","5.1337","8.3381"),	("Cross River","OGOJA","6.6584","8.7992"),	("Cross River","YAKURR","5.7973","8.1776"),	("Cross River","YALA","6.6316","8.6161"),
("Delta","ANIOCHA NORTH","6.3461","6.4717"),	("Delta","ANIOCHA SOUTH","6.1562","6.4503"),	("Delta","BOMADI","5.1607","5.9237"),	("Delta","BURUTU","5.3533","5.5083"),	("Delta","Ethiope East","5.6782","5.9621"),	("Delta","Ethiope West","5.9323","5.7510"),	("Delta","Ika North East","6.2213","6.3013"),	("Delta","IKA SOUTH","6.2651","6.1739"),	("Delta","Isoko North","5.8702","8.5988"),	("Delta","ISOKO SOUTH","5.4043","6.1951"),	("Delta","NDOKWA EAST","5.6511","6.5356"),	("Delta","NDOKWA WEST","5.6511","6.5356"),	("Delta","OKPE","6.5525","9.0934"),	("Delta","OSHIMILI","6.0698","6.6211"),	("Delta","OSHIMILI NORTH","6.4077","6.6211"),	("Delta","PATANI","5.2288","6.1914"),	("Delta","SEPELE","5.8751","5.6931"),	("Delta","UDU","5.4704","5.8354"),	("Delta","UGHELLI NORTH","5.8702","8.5988"),	("Delta","Ughelli South","5.5002","5.9938"),	("Delta","UKWUANI","5.8225","6.1951"),	("Delta","UVWIE","5.5650","5.7827"),	("Delta","WARRI NORTH","5.9593","5.1432"),	("Delta","WARRI SOUTH","5.6609","5.6037"),	("Delta","Warri South West","5.5787","5.4359"),
("Ebonyi","ABAKALIKI","6.3249","8.1137"),	("Ebonyi","AFIKPO NORTH","5.9054","7.9375"),	("Ebonyi","AFIKPO SOUTH","5.8654","7.8069"),	("Ebonyi","EBONYI","6.2649","8.0137"),	("Ebonyi","EZZA NORTH","6.2829","7.9811"),	("Ebonyi","EZZA SOUTH","6.1139","8.0247"),	("Ebonyi","IKWO","6.0693","8.1994"),	("Ebonyi","ISHIELU","6.3907","7.8286"),	("Ebonyi","IVO","5.9097","7.6331"),	("Ebonyi","IZZI","6.5529","8.2651"),	("Ebonyi","OHAOZARA","5.9917","7.7634"),	("Ebonyi","OHAUKWU","6.4725","8.0029"),
("Edo","AKOKO EDO","7.3533","6.1103"),	("Edo","Egor","6.3671","5.5722"),	("Edo","Esan Central","6.6888","6.2164"),	("Edo","ESAN NORTH EAST","6.7297","6.3439"),	("Edo","Esan South East","6.6214","6.4930"),	("Edo","Esan West","6.6899","6.1315"),	("Edo","Etsako Central","7.0057","6.4503"),	("Edo","Etsako East","7.2627","6.4503"),	("Edo","Etsako West","7.0080","6.2801"),	("Edo","Igueben","6.6018","6.2428"),	("Edo","IKPOBA OKHA","6.1649","5.6879"),	("Edo","Oredo","6.2298","5.5407"),	("edo","ORHIONMWON","6.1194","5.9833"),	("Edo","Ovia North East","6.5047","5.6037"),	("EDO","Ovia South West","6.4653","5.3103"),	("Edo","Owan East","7.0969","6.0256"),	("Edo","Owan West","6.9279","5.8565"),	("Edo","Uhunmwonde","6.4579","5.9833"),
("Ekiti","ADO-EKITI","7.6167","5.2167"),	("Ekiti","Efon","7.6919","4.9143"),	("Ekiti","EKITI EAST","7.7259","5.6668"),	("Ekiti","EKITI SOUTH WEST","7.5176","5.0391"),	("Ekiti","EKITI WEST","7.6905","5.0391"),	("Ekiti","EMURE","7.4317","5.4621"),	("Ekiti","GBONYIN","7.5984","5.4988"),	("Ekiti","IDO-OSI","7.8618","5.2058"),	("Ekiti","IJERO","7.8120","5.0677"),	("Ekiti","IKERE","7.4991","5.2319"),	("Ekiti","IKOLE","7.7983","5.5145"),	("Ekiti","ILEJEMEJE","7.9591","5.2371"),	("Ekiti","IREPODUN","7.7313","5.2476"),	("Ekiti","IREPODUN","7.7313","5.2476"),	("Ekiti","IREPODUN/IFELODUN","7.7313","5.2476"),	("Ekiti","ISE ORUN","7.4269","5.4149"),	("Ekiti","MOBA","7.9931","5.1224"),	("Ekiti","OYE","7.7979","5.3286"),
("Enugu","Aninri","6.0362","7.5897"),	("Enugu","Awgu","6.0728","7.4774"),	("Enugu","Enugu East","6.4584","7.5464"),	("Enugu","Enugu North","6.4584","7.5464"),	("Enugu","Enugu South","6.3849","7.5139"),	("Enugu","Ezeagu","6.3996","7.2221"),	("Enugu","Igboetiti","6.6722","7.4165"),	("Enugu","Igboeze North","6.9904","7.4814"),	("Enugu","Igboeze South","6.9386","7.3841"),	("Enugu","Isiuzo","6.7309","7.7417"),	("Enugu","Nkanu East","6.3089","7.6548"),	("Enugu","Nkanu West","6.4584","7.5464"),	("Enugu","Nsukka","6.8567","7.3958"),	("Enugu","Oji-River","6.2537","7.2734"),	("Enugu","Udenu","6.8828","7.5464"),	("Enugu","Udi","6.3159","7.4209"),	("Enugu","Uzouwani","6.7401","7.1359"),
("FCT","Abaji","8.4737","6.9445"),	("FCT","AMAC","9.0618","7.4221"),	("FCT","Bwari","9.2799","7.3804"),	("FCT","Gwagwalada","8.9434","7.0816"),	("FCT","Kuje","8.8795","7.2276"),	("FCT","Kwali","8.8835","7.0186"),
("Gombe","AKKO","10.2791","11.1731"),	("Gombe","BALANGA","9.8329","11.6613"),	("Gombe","BILLIRI","9.8902","11.2179"),	("Gombe","DUKKU","10.8238","10.7722"),	("Gombe","FUNAKAYE","10.7252","11.3885"),	("Gombe","GOMBE","10.2904","11.17"),	("Gombe","KALTUNGO","9.82","11.3087"),	("gombe","NAFADA","11.096","11.3326"),	("Gombe","SHOMGOM","9.6698","11.2977"),	("Gombe","YAMALTU/DEBA","10.2794","11.4793"),
("Imo","Aboh Mbaise","5.4501","7.2334"),	("Imo","Ahiazu Mbaise","5.5385","7.2437"),	("imo","Ehime Mbano","5.6655","7.3058"),	("Imo","Ezinihitte Mbaise","5.4854","7.3193"),	("Imo","IDEATO NORTH","5.8849","7.1252"),	("Imo","IDEATO SOUTH","5.8011","7.1252"),	("Imo","ihitte uboma","5.6154","7.3463"),	("Imo","IKEDURU","5.5812","7.1575"),	("Imo","ISIALA MBANO","5.7084","7.1783"),	("Imo","ISU","6.15","7.8013"),	("Imo","MBAITOLI","5.5828","7.0283"),	("imo","Ngor Okpala","5.3109","7.1359"),	("Imo","NJABA","5.6981","6.9961"),	("Imo","NKWERRE","5.7592","7.1038"),	("Imo","NWANGELE","5.7174","7.1252"),	("Imo","OBOWO","5.6027","7.3220"),	("Imo","OGUTA","5.7104","6.8094"),	("imo","Ohaji Egbema","5.3138","6.8780"),	("Imo","OKIGWE","5.8292","7.3506"),	("imo","ONUIMO","5.7788","7.2329"),	("Imo","ORLU","5.7837","7.0333"),	("Imo","ORSU","5.8449","6.9746"),	("Imo","ORU EAST","5.6673","6.9424"),	("Imo","ORU WEST","5.7409","6.9102"),	("Imo","Owerri Municipal","5.4682","7.0176"),	("Imo","OWERRI NORTH","5.4567","7.1144"),	("Imo","OWERRI WEST","5.4166","6.9853"),
("Jigawa","AUYO","12.3334","9.9389"),	("Jigawa","BABURA","12.7726","9.0153"),	("Jigawa","BIRNIN KUDU","11.4521","9.4786"),	("Jigawa","BIRNIWA","12.7907","10.2361"),	("Jigawa","BUJI","11.6766","9.7679"),	("Jigawa","DUTSE","11.7992","9.3503"),	("Jigawa","GAGARAWA","12.4085","9.5288"),	("Jigawa","GARKI","12.4346","9.1903"),	("Jigawa","GUMEL","12.6269","9.3881"),	("Jigawa","GURI","12.7281","10.4199"),	("Jigawa","GWARAM","11.2773","9.8838"),	("Jigawa","GWIWA","12.7817","8.3372"),	("Jigawa","HADEJIA","12.45","10.04"),	("Jigawa","JAHUN","12.0763","9.6276"),	("Jigawa","KAFIN HAUSA","12.2393","9.9111"),	("Jigawa","KAUGAMA","12.4743","9.7367"),	("Jigawa","KAZAURE","12.6485","8.4118"),	("Jigawa","Kiri Kasama","12.6933","10.2567"),	("Jigawa","KIYAWA","11.7844","9.6069"),	("Jigawa","MAIGATARI","12.8078","9.4452"),	("Jigawa","MALAM MADORI","12.5647","9.8808"),	("Jigawa","MIGA","12.2388","9.7136"),	("Jigawa","RINGIM","12.1514","9.1622"),	("Jigawa","RONI","12.6586","8.265"),	("Jigawa","SULE TANKARKAR","12.6669","9.2283"),	("Jigawa","TAURA","12.2271","9.2831"),	("Jigawa","YANKWASHI","12.7831","8.5062"),
("Kaduna","BIRNIN GWARI","10.6637","6.54"),	("Kaduna","CHIKUN","10.5105","7.4165"),	("Kaduna","GIWA","11.3157","7.4496"),	("Kaduna","IGABI","10.5105","7.4165"),	("Kaduna","IKARA","11.1751","8.2247"),	("Kaduna","JABA","9.4754","8.0247"),	("Kaduna","JEMAA","9.4599","8.3896"),	("Kaduna","KACHIA","9.8734","7.9541"),	("Kaduna","KADUNA NORTH","10.5432","7.4490"),	("Kaduna","KADUNA SOUTH","10.4549","7.4057"),	("Kaduna","KAGARKO","9.4911","7.6977"),	("Kaduna","Kajuru","10.3228","7.6846"),	("Kaduna","KAURA","9.6681","8.4583"),	("Kaduna","KAURU","10.576","8.151"),	("Kaduna","Kubau","10.7724","8.1229"),	("Kaduna","KUDAN","11.2643","7.7634"),	("Kaduna","LERE","10.4146","8.5721"),	("Kaduna","MAKARFI","11.3773","7.881"),	("Kaduna","Sabon-Gari","11.1766","7.6765"),	("Kaduna","SANGA","9.2216","8.5282"),	("Kaduna","SOBA","10.9841","8.0602"),	("Kaduna","TUDUN","10.5188","7.4192"),	("Kaduna","Zango Kataf","9.8906","8.2213"),	("Kaduna","ZARIA","11.0667","7.7"),
("Kano","AJINGI","11.9683","9.0368"),	("Kano","ALBASU","11.674","9.1406"),	("Kano","BAGWAI","12.1577","8.1358"),	("Kano","BEBEJI","11.6677","8.262"),	("Kano","BICHI","12.2339","8.2406"),	("Kano","BUNKURE","11.6992","8.5413"),	("Kano","DALA","12.0053","8.5007"),	("Kano","DAMBATTA","12.435","8.5153"),	("Kano","DAWAKIN KUDU","11.8373","8.597"),	("Kano","DAWAKIN TOFA","12.1045","8.33"),	("Kano","DOGUWA","10.8125","8.7041"),	("Kano","FAGGE","12.0156","8.5337"),	("Kano","GABASAWA","12.1806","8.9121"),	("Kano","GARKO","11.6497","8.8033"),	("Kano","GARUN MALLAM","11.6842","8.3718"),	("Kano","GAYA","11.8606","9.0027"),	("Kano","GEZAWA","12.1016","8.7503"),	("Kano","GWALE","11.9849","8.5199"),	("Kano","GWARZO","11.916","7.9337"),	("Kano","KABO","11.8561","8.1702"),	("Kano","KANO MUNICIPAL","11.9600","8.5007"),	("Kano","KARAYE","11.7836","8.015"),	("Kano","KIBIYA","11.528","8.6611"),	("Kano","KIRU","11.7021","8.1348"),	("Kano","KUMBOTSO","11.89","8.503"),	("Kano","KUNCHI","12.5026","8.2709"),	("Kano","KURA","11.7723","8.4263"),	("Kano","MADOBI","11.7772","8.288"),	("Kano","MAKODA","12.4199","8.4308"),	("kano","MINIJIBIR","12.1924","8.6284"),	("Kano","NASARAWA","8.5389","7.7082"),	("Kano","RANO","11.5568","8.5806"),	("Kano","RIMIN GADO","11.9672","8.2476"),	("Kano","ROGO","11.5524","7.8225"),	("Kano","SHANONO","12.0515","7.992"),	("Kano","SUMAILA","11.5301","8.9559"),	("kano","TAKAI","11.5757","9.1088"),	("Kano","TARAUNI","11.9768","8.5542"),	("Kano","TOFA","12.0579","8.2731"),	("Kano","TSANYAWA","12.2956","7.9865"),	("Kano","UNGOGO","12.0917","8.4953"),	("Kano","WARAWA","11.8662","8.7015"),	("Kano","WUDIL","11.8094","8.8442"),
("Katsina","BAKORI","11.5556","7.4242"),	("Katsina","BATAGARAWA","12.9061","7.6059"),	("Katsina","BATSARI","12.7555","7.2481"),	("Katsina","BAURE","12.7833","8.7667"),	("Katsina","BINDAWA","12.6699","7.8087"),	("Katsina","CHARANCHI","12.6715","7.7293"),	("Katsina","DAN-MUSA","12.2627","7.3328"),	("Katsina","DANDUME","11.4588","7.126"),	("Katsina","DANJA","11.3771","7.561"),	("Katsina","DAURA","13.033","8.3235"),	("Katsina","DUTSI","12.8286","8.1398"),	("Katsina","DUTSIN MA","12.4545","7.4977"),	("Katsina","FASKARI","11.7211","7.0299"),	("Katsina","FUNTUA","11.5204","7.32"),	("Katsina","INGAWA","12.6414","8.0516"),	("Katsina","JIBIA","13.0938","7.2262"),	("Katsina","KAFUR","11.6459","7.6907"),	("Katsina","KAITA","13.0835","7.7409"),	("Katsina","KANKARA","11.9311","7.4111"),	("Katsina","KANKIA","12.5464","7.8225"),	("Katsina","KATSINA","12.9908","7.6017"),	("Katsina","KURFI","12.6663","7.4848"),	("Katsina","KUSADA","12.4656","7.9785"),	("Katsina","MAI'ADUA","13.1468","8.2261"),	("Katsina","MALUMFASHI","11.7893","7.6206"),	("Katsina","MANI","12.8543","7.8753"),	("Katsina","MASHI","12.9804","7.947"),	("Katsina","MATAZU","12.2355","7.6743"),	("Katsina","MUSAWA","12.1295","7.6702"),	("Katsina","RIMI","12.8503","7.7097"),	("Katsina","SABUWA","11.1737","7.1211"),	("Katsina","SAFANA","12.4108","7.4146"),	("Katsina","SANDAMU","12.9616","8.3602"),	("Katsina","ZANGO","12.9333","8.5333"),
("Kebbi","ALIERO","12.2884","4.4714"),	("Kebbi","AREWA DANDI","12.6857","4.0815"),	("Kebbi","ARGUNGU","12.7448","4.5251"),	("Kebbi","AUGIE","12.8903","4.5996"),	("Kebbi","BAGUDO","11.4035","4.2257"),	("Kebbi","BIRNIN KEBBI","12.4504","4.1999"),	("Kebbi","BUNZA","12.0882","4.0152"),	("Kebbi","DANDI","11.4942","4.2333"),	("Kebbi","GWANDU","12.502","4.6429"),	("Kebbi","JEGA","12.2234","4.3797"),	("Kebbi","KALGO","12.3267","4.2004"),	("Kebbi","KOKO/BESSE","11.4458","4.4388"),	("Kebbi","KWANI","12.466078","4.199524"),	("Kebbi","MAIYAMA","12.0822","4.3691"),	("Kebbi","NGASKI","10.3583","4.8521"),	("Kebbi","SAKABA","11.0651","5.5961"),	("Kebbi","SHANGA","11.2137","4.5794"),	("Kebbi","SURU","11.9253","4.1834"),	("Kebbi","WASAGU/DANKO","11.3799","5.6458"),	("Kebbi","YAURI","10.9925","4.5212"),	("Kebbi","ZURU","11.4352","5.2349"),
("Kogi","ADAVI","7.6720","6.4290"),	("Kogi","AJAOKUTA","7.5394","6.6424"),	("Kogi","ANKPA","7.4025","7.632"),	("Kogi","BASSA","9.9425","8.7404"),	("Kogi","BASSA","9.9425","8.7404"),	("Kogi","DEKINA","7.6897","7.0438"),	("Kogi","IBAJI","6.8302","6.7922"),	("Kogi","IDAH","7.1104","6.7399"),	("Kogi","Igalamella","7.0825","7.0498"),	("Kogi","IJUMU","7.8737","5.9410"),	("Kogi","KABBA/BUNU","8.2175","6.1951"),	("Kogi","Kogi","8.1195","6.8780"),	("Kogi","LOKOJA","7.8004","6.7399"),	("Kogi","Mopamuro","8.1355","5.8565"),	("Kogi","OFU","7.3396","7.0498"),	("Kogi","Ogori Magogo","7.4710","6.1633"),	("Kogi","OKEHI","5.139","7.1392"),	("Kogi","OKENE","7.55","6.2333"),	("Kogi","Olamaboro","7.1599","7.5681"),	("Kogi","OMALA","7.8052","7.5247"),	("Kogi","YAGBA EAST","8.1378","5.6879"),	("Kogi","YAGBA WEST","8.3145","5.5197"),
("Kwara","ASA","8.4154","4.4388"),	("Kwara","BARUTEN","9.3493","3.5813"),	("Kwara","EDU","8.8892","5.1432"),	("Kwara","EKITI","7.7190","5.3110"),	("Kwara","IFELODUN","8.5381","5.1432"),	("Kwara","IFELODUN","8.5381","5.1432"),	("Kwara","ILORIN-EAST","8.6083","4.7899"),	("Kwara","ILORIN-SOUTH","8.4347","4.6657"),	("Kwara","ILORIN-WEST","8.4912","4.5109"),	("Kwara","KAIAMA","5.1197","6.301"),	("Kwara","MORO","8.8957","4.6450"),	("Kwara","OFFA","8.1491","4.7207"),	("Kwara","OKE ERO","8.2295","5.3521"),	("Kwara","OYUN","8.2167","4.6244"),	("Kwara","PATEGI","8.7211","5.7563"),
("Lagos","AGEGE","6.6156","3.3334"),	("Lagos","AJEROMI/IFELODUN","6.4555","3.3339"),	("Lagos","ALIMOSHO","6.5744","3.2570"),	("Lagos","AMUWO-ODOFIN","6.4293","3.2684"),	("Lagos","APAPA","6.4489","3.3589"),	("Lagos","BADAGRY","6.415","2.8813"),	("Lagos","EPE","6.5833","4"),	("Lagos","ETI-OSA","6.4590","3.6015"),	("Lagos","IBEJU/LEKKI","6.5001","3.8045"),	("Lagos","IFAKO/IJAIYE","6.6850","3.2885"),	("Lagos","IKEJA","6.5965","3.3421"),	("Lagos","IKORODU","6.6153","3.5069"),	("Lagos","KOSOFE","6.5691","3.3793"),	("Lagos","LAGOS ISLAND","6.4549","3.4246"),	("Lagos","LAGOS MAINLAND","6.5059","3.3781"),	("Lagos","MUSHIN","6.528","3.3541"),	("Lagos","OJO","6.4612","3.1647"),	("Lagos","OSHODI/ISOLO","6.5355","3.3087"),	("Lagos","PAKAL","6.465422","3.406448"),	("Lagos","SHOMOLU","6.5392","3.3842"),	("Lagos","SURULERE","6.5015","3.3581"),	("Lagos","SURULERE","6.5015","3.3581"),
("Nasarawa","AKWANGA","8.9108","8.4066"),	("Nasarawa","AWE","8.1045","9.1401"),	("Nasarawa","DOMA","8.3931","8.3554"),	("Nasarawa","KARU","9.0094","7.6615"),	("Nasarawa","KEANA","8.1472","8.796"),	("Nasarawa","KEFFI","8.849","7.8736"),	("Nasarawa","KOKONA","8.7739","7.9811"),	("Nasarawa","LAFIA","8.4904","8.52"),	("Nasarawa","NASSARAWA","8.5390","7.7082"),	("Nasarawa","NASSARAWA-EGGON","8.7425","8.5419"),	("Nasarawa","TOTO","8.3876","7.0775"),	("Nasarawa","WAMBA","8.9415","8.6032"),
("Niger","AGAIE","9.0085","6.3182"),	("Niger","AGWARA","10.7061","4.5813"),	("Niger","Bida","9.0804","6.01"),	("Niger","BORGU","10.3232","4.1514"),	("Niger","BOSSO","9.6522","6.5261"),	("Niger","CHANCHAGA","9.6278","6.5463"),	("Niger","EDATI","9.0362","5.6248"),	("Niger","GBAKO","9.2723","6.0256"),	("Niger","GURARA","9.3418","7.0498"),	("Niger","KATCHA","8.7608","6.312"),	("Niger","KONTAGORA","10.4004","5.4699"),	("Niger","LAPAI","9.0444","6.5709"),	("Niger","LAVUN","9.4111","5.6458"),	("Niger","MARIGA","10.1349","6.0229"),	("Niger","MASHEGU","9.9721","5.7789"),	("niger","MGAMA","10.3116","4.9767"),	("Niger","MOKWA","9.2948","5.0541"),	("Niger","MUYA","9.9181","7.0068"),	("Niger","PAIKORO","9.4351","6.7922"),	("Niger","RAFI","10.1130","6.1527"),	("Niger","RIJAU","11.1039","5.2556"),	("Niger","SHIRORO","9.9822","6.8093"),	("Niger","SULEJA","9.1806","7.1794"),	("Niger","TAFA","9.2448","7.2882"),	("Niger","WUSHISHI","9.7304","6.073"),
("Ogun","Abeokuta North","7.2114","3.1378"),	("Ogun","Abeokuta South","7.1561","3.3490"),	("Ogun","Ado Odo/Ota","6.6117","3.0576"),	("Ogun","EWEKORO","6.9530","3.2181"),	("Ogun","IFO","6.8149","3.1952"),	("Ogun","IJEBU EAST","6.8159","4.3154"),	("Ogun","IJEBU NORTH","7.0333","3.9470"),	("Ogun","Ijebu North East","6.8827","4.0083"),	("Ogun","Ijebu Ode","6.8300","3.9165"),	("Ogun","IKENNE","6.8658","3.7152"),	("Ogun","IMEKO AFON","7.4477","2.8380"),	("Ogun","IPOKIA","6.5333","2.85"),	("ogun","Obafemi Owode","6.9483","3.5079"),	("Ogun","ODEDA","7.2313","3.5246"),	("Ogun","ODOGBOLU","6.8404","3.7629"),	("Ogun","OGUN WATERSIDE","6.5169","4.3565"),	("Ogun","Remo North","7.0137","3.7232"),	("Ogun","Sagamu","6.8322","3.6319"),	("Ogun","Yewa North","7.1702","2.8577"),	("Ogun","Yewa South","6.7832","2.9776"),
("Ondo","AKOKO NORTH EAST","7.5503","5.8776"),	("Ondo","AKOKO NORTH WEST","7.6165","5.7721"),	("Ondo","Akoko South East","7.4204","5.9198"),	("Ondo","Akoko South West","7.3807","5.6668"),	("Ondo","AKURE NORTH","7.2779","5.2684"),	("Ondo","Akure South","7.2146","5.1641"),	("Ondo","Ese Odo","6.2570","4.9351"),	("Ondo","IDANRE","7.0914","5.1484"),	("Ondo","IFEDORE","7.3877","5.0807"),	("Ondo","ILAJE","6.2585","4.7692"),	("Ondo","Ile Oluji","7.2017","4.8676"),	("Ondo","IRELE","6.4883","4.8702"),	("Ondo","ODIGBO","6.7947","4.8676"),	("Ondo","OKITIPUPA","6.5055","4.7796"),	("Ondo","ONDO EAST","7.0881","4.9559"),	("Ondo","Ondo West","7.0257","4.7692"),	("Ondo","OSE","7.0155","5.6879"),	("Ondo","OWO","7.2004","5.59"),
("Osun","Atakumosa East","7.4772","4.7899"),	("Osun","Atakumosa West","7.5217","4.6657"),	("Osun","Ayedaade","7.2023","4.2744"),	("Osun","Ayedire","6.9149","5.1478"),	("Osun","BOLUWADURO","7.9426","4.8002"),	("Osun","BORIPE","7.8357","4.6554"),	("Osun","EDE NORTH","7.7292","4.4697"),	("Osun","Ede South","7.6536","4.4594"),	("Osun","EGBEDORE","7.7840","4.4182"),	("Osun","EJIGBO","7.9029","4.3142"),	("Osun","IFE CENTRAL","7.5555","4.5315"),	("Osun","IFE EAST","7.4358","4.6244"),	("Osun","IFE NORTH","7.4592","4.4388"),	("Osun","IFE SOUTH","7.1991","4.6037"),	("Osun","IFEDAYO","7.9946","4.9974"),	("Osun","ILA","8.0121","4.8988"),	("osun","Ilesa East","7.5963","4.7588"),	("Osun","ILESA WEST","7.6400","4.7174"),	("Osun","IREWOLE","7.3967","4.2128"),	("Osun","ISOKAN","7.3108","4.1719"),	("Osun","IWO","7.63","4.18"),	("Osun","OBOKUN","7.8019","4.7692"),	("osun","Odootin","7.9985","4.6657"),	("Osun","Olaoluwa","7.7427","4.2128"),	("Osun","OLORUNDA","7.8583","4.5728"),	("Osun","ORIADE","7.5194","4.8728"),	("Osun","OROLU","7.9028","4.4697"),	("OSUN","OSIN","7.5000","4.5000"),	("Osun","Osogbo","7.7667","4.5667"),
("Oyo","AFIJIO","7.7243","3.8655"),	("Oyo","AKINYELE","7.5503","3.9470"),	("Oyo","ATIBA","8.2465","3.8655"),	("Oyo","ATISBO","8.3824","3.3389"),	("Oyo","EGBEDA","7.3772","4.0498"),	("Oyo","IBADAN NORTH","7.4102","3.9165"),	("Oyo","IBADAN NORTH EAST","7.3615","3.9317"),	("Oyo","IBADAN NORTH WEST","7.3889","3.8757"),	("Oyo","IBADAN SOUTH EAST","7.3293","3.9114"),	("Oyo","IBADAN SOUTH WEST","7.3458","3.8757"),	("Oyo","Ibarapa Central","7.4048","3.2383"),	("Oyo","IBARAPA EAST","7.6410","3.4599"),	("Oyo","IBARAPA NORTH","7.6865","3.1780"),	("Oyo","IDO","7.471","3.7574"),	("Oyo","IREPO","9.0368","3.8655"),	("Oyo","ISEYIN","7.9667","3.6"),	("Oyo","ITESIWAJU","8.1622","3.5408"),	("Oyo","IWAJOWA","8.0355","3.0176"),	("Oyo","KAJOLA","7.9892","3.3792"),	("Oyo","LAGELU","7.4846","4.0491"),	("Oyo","OGBOMOSO NORTH","8.1335","4.2538"),	("Oyo","OGBOMOSO SOUTH","8.0794","4.2231"),	("Oyo","Ogo Oluwa","7.9598","4.2128"),	("Oyo","OLORUNSOGO","7.3696","3.9343"),	("Oyo","OLUYOLE","7.3622","3.8503"),	("Oyo","Ona Ora","7.43383","3.28788"),	("Oyo","Oorelope","8.8613","3.7842"),	("Oyo","ORIRE","8.3748","4.1514"),	("Oyo","OYO EAST","7.8745","4.0491"),	("Oyo","OYO WEST","7.8987","3.7842"),	("Oyo","SAKI EAST","8.6870","3.6218"),	("Oyo","SAKI WEST","8.6033","3.1378"),
("Plateau","BARKIN LADI","9.5381","8.8927"),	("Plateau","BOKKOS","9.2992","8.9947"),	("Plateau","JOS EAST","9.8679","9.1013"),	("Plateau","JOS NORTH","9.9181","8.8804"),	("Plateau","JOS SOUTH","9.7651","8.8142"),	("Plateau","KANAM","9.5604","9.9517"),	("Plateau","KANKE","9.3702","9.5896"),	("Plateau","LANGTANG NORTH","9.1002","9.8571"),	("Plateau","LANGTANG SOUTH","8.6221","9.8125"),	("Plateau","MANGU","9.5206","9.0977"),	("Plateau","MIKANG","9.0199","9.5896"),	("Plateau","PANKSHIN","9.3254","9.4352"),	("Plateau","QUAANPAN","8.6397","9.1013"),	("Plateau","RIYOM","9.6368","8.7569"),	("Plateau","SHENDAM","8.8787","9.5346"),	("Plateau","WASE","9.0942","9.9561"),
("Rivers","Abua/Odual","4.8207","6.5356"),	("Rivers","Ahoada East","5.0468","6.6424"),	("Rivers","Ahoada West","5.0685","6.5356"),	("Rivers","Akuku Toru","4.6138","6.6638"),	("Rivers","Andoni","4.5044","7.3733"),	("Rivers","Asari Toru","4.7456","6.8458"),	("Rivers","Bonny","4.4516","7.1707"),	("Rivers","Degema","4.7481","6.7662"),	("Rivers","Eleme","4.7994","7.1198"),	("Rivers","Emohua","4.8843","6.8726"),	("Rivers","Etche","5.0632","7.0498"),	("Rivers","Gokana","4.6692","7.2869"),	("Rivers","Ikwerre","5.1478","6.8780"),	("Rivers","Khana","4.6476","7.3949"),	("Rivers","Obio/Akpor","4.8776","7.0283"),	("Rivers","Ogba/Egbema/Ndoni","5.3998","6.6211"),	("Rivers","Ogu/Bolo","4.7231","7.1999"),	("Rivers","Okrika","4.7422","7.0837"),	("Rivers","Omuma","5.1231","7.2437"),	("Rivers","Opobo/Nkoro","4.5132","7.5139"),	("Rivers","Oyigbo","4.8869","7.1252"),	("Rivers","Port Harcourt","4.75","7"),	("Rivers","Tai","4.7518","7.2437"),
("Sokoto","BINJI","13.2229","4.9089"),	("Sokoto","BODINGA","12.8441","5.15"),	("Sokoto","DANGE","12.8531","5.3457"),	("Sokoto","GADA","13.7543","5.6572"),	("Sokoto","GORONYO","13.4423","5.6723"),	("Sokoto","GUDU","13.4116","4.4800"),	("Sokoto","GWADABAWA","13.3582","5.2381"),	("Sokoto","ILLELA","13.7306","5.2978"),	("Sokoto","ISA","13.2007","6.4049"),	("Sokoto","KEBBE","12.1286","4.7343"),	("Sokoto","KWARE","13.2197","5.266"),	("Sokoto","RABAH","13.1226","5.5076"),	("Sokoto","SABON-BIRNI","13.5128","6.2814"),	("Sokoto","SHAGARI","12.6273","4.9929"),	("Sokoto","SILAME","13.0392","4.8459"),	("SOKOTO","SOKOTO","13.0622","5.2339"),	("Sokoto","SOKOTO SOUTH","13.0176","5.2371"),	("Sokoto","TAMBAWAL","12.3492","4.8521"),	("Sokoto","TANGAZA","13.4023","4.9767"),	("Sokoto","TURETA","12.5937","5.5439"),	("Sokoto","WAMAKKO","13.0367","5.0945"),	("Sokoto","WURNO","13.2905","5.4237"),	("Sokoto","YABO","12.7222","5.0133"),
("Taraba","ARDO KOLA","8.7557","11.2524"),	("Taraba","BALI","7.8553","10.9678"),	("Taraba","DONGA","7.7217","10.0453"),	("Taraba","GASHAKA","7.3667","11.4868"),	("Taraba","GASSOL","8.5866","10.3617"),	("Taraba","IBI","8.1812","9.7443"),	("Taraba","JALINGO","8.9004","11.36"),	("Taraba","KARIM-LAMIDO","9.3204","11.1929"),	("Taraba","KURMI","8.6851","10.0855"),	("Taraba","LAU","9.2083","11.2754"),	("Taraba","PANTI-SAWA","8.9450","11.5118"),	("Taraba","SARDAUNA","6.8734","11.2524"),	("Taraba","TAKUM","7.2553","9.9855"),	("Taraba","USSA","7.1128","10.0360"),	("Taraba","WUKARI","7.8704","9.78"),	("Taraba","ZING","8.9906","11.7476"),
("Yobe","BADE","12.86749653","11.041166502"),	("Yobe","BURSARI","12.6499","11.4339"),	("Yobe","DAMATURU","11.75","11.9667"),	("Yobe","FIKA","11.2867","11.3077"),	("Yobe","FUNE","11.6561","11.5248"),	("Yobe","GEIDAM","12.8944","11.9265"),	("Yobe","GUJBA","11.4998","11.9337"),	("Yobe","GULANI","10.7263","11.6895"),	("Yobe","JAKUSKO","12.3709","10.7737"),	("Yobe","KARASUWA","12.9088","10.6647"),	("Yobe","MACHINA","13.1364","10.0492"),	("Yobe","NANGERE","11.8663","11.0698"),	("yobe","NGURU","12.8804","10.45"),	("Yobe","POTISKUM","11.7104","11.08"),	("Yobe","TARMUA","12.0933","11.7980"),	("Yobe","YUNUSARI","13.1854","11.6158"),	("Yobe","YUSUFARI","13.0661","11.1735"),
("Zamfara","ANKA","12.1135","5.9268"),	("Zamfara","BAKURA","12.7114","5.8737"),	("Zamfara","birnin magaji","12.5592","6.8946"),	("Zamfara","BUKKUYUM","12.1372","5.4682"),	("Zamfara","BUNGUDU","12.2685","6.5529"),	("Zamfara","GUMMI","12.1448","5.1178"),	("Zamfara","GUSAU","12.1704","6.66"),	("Zamfara","KAURA-NAMODA","12.5952","6.5863"),	("Zamfara","MARADUN","12.567","6.2441"),	("Zamfara","MARU","12.3336","6.4037"),	("Zamfara","SHINKAFI","13.073","6.5057"),	("Zamfara","TALATA-MAFARA","12.5618","6.0653"),	("Zamfara","TSAFE","11.9577","6.9208"),	("Zamfara","ZURMI","12.7767","6.784");



-- =================
-- HTS LINE LISTING
-- =======================
SELECT DISTINCT "CIHP" AS "IP",
   (SELECT `state_province`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) AS State,
   (SELECT `city_village`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) LGA,
      (SELECT `address2`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) City,
   (SELECT property_value FROM global_property WHERE property = 'facility_datim_code' LIMIT 1) Datim_Code,
   (SELECT `name`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) FacilityName,
   HTS_ClientCode.identifier AS HTS_ClientCode,PEPFAR_Number.identifier AS PEPFAR_Number_IfOnART,ClientCode.patient_id AS person_id,BioInfo.birthdate,BioInfo.gender AS Sex,BioInfo.CurrentAge,BioInfo.given_name,BioInfo.family_name,
PhoneNo.PhoneNumber,Address.Address,Latitude.LGA,Latitude.LGA_Latitude,Latitude.LGA_Longitude,DATE_FORMAT(ClientCode.encounter_datetime,'%Y-%m-%d') AS VisitDate,
CASE WHEN HIVScreeningTestDate.HIVScreeningTestDate=ClientCode.encounter_datetime THEN 'Test Date Validated'
WHEN HIVScreeningTestDate.HIVScreeningTestDate!=ClientCode.encounter_datetime THEN 'Visit & Test Date Mismatch'
WHEN HIVScreeningTestDate.HIVScreeningTestDate IS NULL THEN 'Test Date Not Specified'
ELSE 'What Happened?'
END AS 'Test_VisitDate_Validation',

CASE WHEN KindOfHTS.KindOfHTS ='Provider-initiated HIV testing and counseling' THEN 'PITC'
WHEN KindOfHTS.KindOfHTS ='Voluntary counseling and testing center' THEN 'VCT' 
WHEN KindOfHTS.KindOfHTS IS NULL THEN 'Kind of HTS not Specified' ELSE KindOfHTS.KindOfHTS END AS KindOfHTS,

CASE WHEN setting.setting ='Observation ward' THEN 'Ward'
WHEN setting.setting ='Outpatient department' THEN 'OPD' 
WHEN setting.setting ='Voluntary counseling and testing program' THEN 'VCT'
WHEN setting.setting ='Tuberculosis Visit' THEN 'TB'
WHEN setting.setting ='Sexually transmitted infection program/clinic' THEN 'STI'
WHEN setting.setting ='FAMILY PLANNING' THEN 'FP'
WHEN setting.setting ='PMTCT Setting' THEN 'PMTC'
WHEN setting.setting IS NULL THEN 'Setting not Specified' ELSE setting.setting END AS setting,KP.KP
 AS 'KP?',
FirstTimeVisit.FirstTimeVisit,
CASE WHEN TypeOfSession.TypeOfSession ='Individual' THEN TypeOfSession.TypeOfSession
WHEN TypeOfSession.TypeOfSession ='Previously self tested' THEN TypeOfSession.TypeOfSession
WHEN TypeOfSession.TypeOfSession ='Couple testing' THEN TypeOfSession.TypeOfSession
ELSE 'Type_Of_Session_Not_Specified' END AS TypeOfSession,
ReferredFrom.ReferredFrom,MaritalStatus.MaritalStatus,FromIndex.FromIndex,
CASE WHEN FromIndex.FromIndex='Yes' AND IndexClientID.IndexClientID IS NULL THEN
'Specify Index ClientID' WHEN (FromIndex.FromIndex IS NULL OR FromIndex.FromIndex ='No') AND IndexClientID.IndexClientID IS NOT NULL THEN
'Find out if Client is not from specified Index ID'
WHEN FromIndex.FromIndex='Yes' AND (IndexClientID.IndexClientID IS NOT NULL OR IndexClientID.IndexClientID!='') AND (IndexClientID.IndexClientName IS NOT NULL OR IndexClientID.IndexClientName!='')  THEN
'IndexClientID_Matches_UniqueID_ON_NMRS'
WHEN FromIndex.FromIndex='Yes' AND (IndexClientID.IndexClientID IS NOT NULL OR IndexClientID.IndexClientID!='') AND (IndexClientID.IndexClientName IS NULL OR IndexClientID.IndexClientName ='')  THEN
'IndexClientID_Does_Not_Match_UniqueID_ON_NMRS'
 WHEN FromIndex.FromIndex='No' AND (IndexClientID.IndexClientID IS NULL OR IndexClientID.IndexClientID='') THEN
'Validated' ELSE FromIndex.FromIndex END AS 'IndexClientID_Validation',
IndexClientID.IndexClientID,IndexType.IndexType,IndexClientID.IndexClientName,ReTest.ReTest AS 'Is client retesting for result verification?',
HIVScreeningTest.HIVScreeningTest,DATE_FORMAT(HIVScreeningTestDate.HIVScreeningTestDate,'%Y-%m-%d') AS HIVScreeningTestDate,HIV_FinalResult.HIV_FinalResult,
Opt_Out_of_RTRI.Opt_Out_of_RTRI AS 'Opt_Out_of_RTRI?',
CASE WHEN (Opt_Out_of_RTRI.Opt_Out_of_RTRI IS NULL OR Opt_Out_of_RTRI.Opt_Out_of_RTRI = '') AND (HIVRecencyTestName.HIVRecencyTestName IS NOT NULL OR HIVRecencyTestName.HIVRecencyTestName <> '') THEN 'Specify_Consent_For_RecencyTest'
WHEN (Opt_Out_of_RTRI.Opt_Out_of_RTRI IS NOT NULL OR Opt_Out_of_RTRI.Opt_Out_of_RTRI <> '') AND (HIVRecencyTestName.HIVRecencyTestName IS NOT NULL OR HIVRecencyTestName.HIVRecencyTestName <> '') THEN 'Validated' ELSE NULL END AS 'Opt_Out_of_RTRI_Validation',
HIVRecencyTestName.HIVRecencyTestName,
VerifyRecencyNumber.VerifyRecencyNumber,ControlLine.ControlLine,VerificationLine.VerificationLine,LongTermLine.LongTermLine,DATE_FORMAT(HIVRecencyTestDate.HIVRecencyTestDate ,'%Y-%m-%d') AS HIVRecencyTestDate,RecencyInterpretation.RecencyInterpretation,ViralLoadRequest.ViralLoadRequest,DATE_FORMAT(VLSampleCollectionDate.VLSampleCollectionDate,'%Y-%m-%d') AS VLSampleCollectionDate,
PCR_LabNo.PCR_LabNo,SampleType.SampleType,PCR_Laboratory.PCR_Laboratory,HIV_ViralLoad.HIV_ViralLoad,FinalHIVRecencyResult.FinalHIVRecencyResult,NoOfPatnerElicited.NoOfPatnerElicited,
PartnerFullName_1.PartnerFullName_1,IndexRelation_Gender_1.IndexRelation_Gender_1,IndexType_Partner1.IndexType_Partner1,
PartnerFullName_2.PartnerFullName_2,IndexRelation_Gender_2.IndexRelation_Gender_2,IndexType_Partner2.IndexType_Partner2,
PartnerFullName_3.PartnerFullName_3,IndexRelation_Gender_3.IndexRelation_Gender_3,IndexType_Partner3.IndexType_Partner3,
PartnerFullName_4.PartnerFullName_4,IndexRelation_Gender_4.IndexRelation_Gender_4,IndexType_Partner4.IndexType_Partner4,
PartnerFullName_5.PartnerFullName_5,IndexRelation_Gender_5.IndexRelation_Gender_5,IndexType_Partner5.IndexType_Partner5,
PartnerFullName_6.PartnerFullName_6,IndexRelation_Gender_6.IndexRelation_Gender_6,IndexType_Partner6.IndexType_Partner6
FROM

(SELECT  @row_number :=CASE WHEN @patient_id = patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := patient_id AS patient_id,
encounter_datetime,encounter_id ,voided FROM encounter WHERE (encounter_type = 2 OR encounter_type = 20) AND encounter_datetime BETWEEN DATE_FORMAT(@startdate,'%Y-%m-%d 00:00:00') AND DATE_FORMAT(@enddate,'%Y-%m-%d 23:59:59') AND voided = 0
ORDER BY patient_id ASC, encounter_datetime DESC ) AS ClientCode
 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 166136 THEN get_concept_name(value_coded) END  AS KindOfHTS
FROM obs WHERE concept_id = 166136 AND voided = 0) AS KindOfHTS
ON ClientCode.patient_id = KindOfHTS.person_id AND ClientCode.encounter_id = KindOfHTS.encounter_id AND ClientCode.num = 1

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165839 THEN get_concept_name(value_coded) END  AS setting
FROM obs WHERE concept_id = 165839 AND voided = 0) AS setting
ON ClientCode.patient_id = setting.person_id AND ClientCode.encounter_id = setting.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165766 AND value_coded = 1 THEN 'Yes' WHEN concept_id = 165766 AND value_coded = 2 THEN 'No' ELSE NULL END AS KP
FROM obs WHERE concept_id = 165766 AND voided = 0) AS KP
ON ClientCode.patient_id = KP.person_id AND ClientCode.encounter_id = KP.encounter_id AND ClientCode.num = 1


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165790 THEN get_concept_name(value_coded) END AS FirstTimeVisit
FROM obs WHERE concept_id = 165790 AND voided = 0) AS FirstTimeVisit
ON ClientCode.patient_id = FirstTimeVisit.person_id AND ClientCode.encounter_id = FirstTimeVisit.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165793 THEN get_concept_name(value_coded) END AS TypeOfSession
FROM obs WHERE concept_id = 165793 AND voided = 0) AS TypeOfSession
ON ClientCode.patient_id = TypeOfSession.person_id AND ClientCode.encounter_id = TypeOfSession.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165480 THEN get_concept_name(value_coded) END AS ReferredFrom
FROM obs WHERE concept_id = 165480 AND voided = 0 ) AS ReferredFrom
ON ClientCode.patient_id = ReferredFrom.person_id AND ClientCode.encounter_id = ReferredFrom.encounter_id AND ClientCode.num = 1

LEFT JOIN
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 1054 THEN get_concept_name(value_coded) END AS MaritalStatus
FROM obs WHERE concept_id = 1054 AND voided = 0) AS MaritalStatus
ON ClientCode.patient_id = MaritalStatus.person_id AND ClientCode.encounter_id = MaritalStatus.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165794 THEN get_concept_name(value_coded) END AS FromIndex
FROM obs WHERE concept_id = 165794 AND voided = 0 ) AS FromIndex
ON ClientCode.patient_id = FromIndex.person_id AND ClientCode.encounter_id = FromIndex.encounter_id AND ClientCode.num = 1
LEFT JOIN

 (
SELECT IndexClientName.person_id,IndexClientName.obs_datetime,IndexClientName.encounter_id, IndexClientName.IndexClientID,identifier.IndexClientName
 FROM
(SELECT person_id,obs_datetime,encounter_id, value_text  AS IndexClientID
FROM obs WHERE concept_id = 165859 AND voided = 0) AS IndexClientName
INNER JOIN
(SELECT A.patient_id, A.identifier,CONCAT(B.given_name,' ', B.family_name) AS IndexClientName FROM  patient_identifier AS A, person_name AS B
WHERE  A.patient_id = B.`person_id` AND a.identifier_type = 4 AND a.voided = 0 AND b.voided = 0) AS identifier
ON IndexClientName.IndexClientID = identifier.identifier) AS IndexClientID
ON ClientCode.patient_id = IndexClientID.person_id AND ClientCode.encounter_id = IndexClientID.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType
FROM obs WHERE concept_id = 165798 AND voided = 0) AS IndexType
ON ClientCode.patient_id = IndexType.person_id AND ClientCode.encounter_id = IndexType.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165976 AND value_coded = 1065 THEN 'Yes' WHEN concept_id = 165976 AND value_coded = 1066 THEN 'No' ELSE NULL END AS ReTest
FROM obs WHERE concept_id = 165976 AND voided = 0 ) AS ReTest
ON ClientCode.patient_id = ReTest.person_id AND ClientCode.encounter_id = ReTest.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165840 THEN get_concept_name(value_coded) END AS HIVScreeningTest
FROM obs WHERE concept_id = 165840 AND voided = 0) AS HIVScreeningTest
ON ClientCode.patient_id = HIVScreeningTest.person_id AND ClientCode.encounter_id = HIVScreeningTest.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  HIVScreeningTestDate
FROM obs WHERE concept_id = 165844 AND voided = 0) AS HIVScreeningTestDate
ON ClientCode.patient_id = HIVScreeningTestDate.person_id AND ClientCode.encounter_id = HIVScreeningTestDate.encounter_id AND ClientCode.num = 1


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165843 THEN get_concept_name(value_coded) END AS HIV_FinalResult
FROM obs WHERE concept_id = 165843 AND voided = 0) AS HIV_FinalResult
ON ClientCode.patient_id = HIV_FinalResult.person_id AND ClientCode.encounter_id = HIV_FinalResult.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165805 THEN get_concept_name(value_coded) END AS 'Opt_Out_of_RTRI'
FROM obs WHERE concept_id = 165805 AND voided = 0) AS Opt_Out_of_RTRI
ON ClientCode.patient_id = Opt_Out_of_RTRI.person_id AND ClientCode.encounter_id = Opt_Out_of_RTRI.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166216 THEN get_concept_name(value_coded) WHEN concept_id = 165849 THEN value_text ELSE NULL  END AS  HIVRecencyTestName
FROM obs WHERE concept_id IN (166216 ,165849)AND voided = 0) AS HIVRecencyTestName
ON ClientCode.patient_id = HIVRecencyTestName.person_id AND ClientCode.encounter_id = HIVRecencyTestName.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_text AS  VerifyRecencyNumber
FROM obs WHERE concept_id = 166210 AND voided = 0) AS VerifyRecencyNumber
ON ClientCode.patient_id = VerifyRecencyNumber.person_id AND ClientCode.encounter_id = VerifyRecencyNumber.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166212 THEN get_concept_name(value_coded) END AS  ControlLine
FROM obs WHERE concept_id = 166212 AND voided = 0) AS ControlLine
ON ClientCode.patient_id = ControlLine.person_id AND ClientCode.encounter_id = ControlLine.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166243 THEN get_concept_name(value_coded) END  AS  VerificationLine
FROM obs WHERE concept_id = 166243 AND voided = 0) AS VerificationLine
ON ClientCode.patient_id = VerificationLine.person_id AND ClientCode.encounter_id = VerificationLine.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166211 THEN get_concept_name(value_coded) END AS  LongTermLine
FROM obs WHERE concept_id = 166211 AND voided = 0) AS LongTermLine
ON ClientCode.patient_id = LongTermLine.person_id AND ClientCode.encounter_id = LongTermLine.encounter_id AND ClientCode.num = 1


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  HIVRecencyTestDate
FROM obs WHERE concept_id = 165850 AND voided = 0) AS HIVRecencyTestDate
ON ClientCode.patient_id = HIVRecencyTestDate.person_id AND ClientCode.encounter_id = HIVRecencyTestDate.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id IN (166213,165853) THEN get_concept_name(value_coded) END AS  RecencyInterpretation
FROM obs WHERE concept_id IN (166213,165853) AND voided = 0) AS RecencyInterpretation
ON ClientCode.patient_id = RecencyInterpretation.person_id AND ClientCode.encounter_id = RecencyInterpretation.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,
 CASE WHEN concept_id = 166244 THEN get_concept_name(value_coded) END AS  ViralLoadRequest
FROM obs WHERE concept_id = 166244 AND voided = 0 ) AS ViralLoadRequest
ON ClientCode.patient_id = ViralLoadRequest.person_id AND ClientCode.encounter_id = ViralLoadRequest.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  VLSampleCollectionDate
FROM obs WHERE concept_id = 159951 AND voided = 0) AS VLSampleCollectionDate
ON ClientCode.patient_id = VLSampleCollectionDate.person_id AND ClientCode.encounter_id = VLSampleCollectionDate.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_text AS  PCR_LabNo
FROM obs WHERE concept_id = 165715 AND voided = 0) AS PCR_LabNo
ON ClientCode.patient_id = PCR_LabNo.person_id AND ClientCode.encounter_id = PCR_LabNo.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 162476 THEN get_concept_name(value_coded) END AS  SampleType
FROM obs WHERE concept_id = 162476 AND voided = 0) AS SampleType
ON ClientCode.patient_id = SampleType.person_id AND ClientCode.encounter_id = SampleType.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166233 THEN get_concept_name(value_coded) END AS 'PCR_Laboratory'
FROM obs WHERE concept_id = 166233 AND voided = 0
) AS PCR_Laboratory
ON ClientCode.patient_id = PCR_Laboratory.person_id AND ClientCode.encounter_id = PCR_Laboratory.encounter_id AND ClientCode.num = 1


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_numeric AS  HIV_ViralLoad
FROM obs WHERE concept_id = 856 AND voided = 0) AS HIV_ViralLoad
ON ClientCode.patient_id = HIV_ViralLoad.person_id AND ClientCode.encounter_id = HIV_ViralLoad.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165856 THEN get_concept_name(value_coded) END AS FinalHIVRecencyResult
FROM obs WHERE concept_id = 165856 AND voided = 0) AS FinalHIVRecencyResult
ON ClientCode.patient_id = FinalHIVRecencyResult.person_id AND ClientCode.encounter_id = FinalHIVRecencyResult.encounter_id AND ClientCode.num = 1
LEFT JOIN
(

SELECT person_id,COUNT(obs_id) AS NoOfPatnerElicited,  obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
GROUP BY person_id,encounter_id) AS NoOfPatnerElicited
ON ClientCode.patient_id = NoOfPatnerElicited.person_id AND ClientCode.num = 1

-- ============================================================================
 -- Partner Elicitation for Partner One
 -- =====================================
LEFT JOIN

 
 ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number1 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number1 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 1 ) AS PatnerElicitation1
 ON ClientCode.patient_id = PatnerElicitation1.person_id AND ClientCode.encounter_id = PatnerElicitation1.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_1
FROM obs WHERE concept_id = 165857 AND voided = 0) AS IndexRelation_Gender_1
ON PatnerElicitation1.person_id = IndexRelation_Gender_1.person_id AND PatnerElicitation1.encounter_id = IndexRelation_Gender_1.encounter_id AND PatnerElicitation1.obs_id = IndexRelation_Gender_1.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner1
FROM obs WHERE concept_id = 165798 AND voided = 0 ) AS IndexType_Partner1
ON PatnerElicitation1.person_id = IndexType_Partner1.person_id AND PatnerElicitation1.encounter_id = IndexType_Partner1.encounter_id AND PatnerElicitation1.obs_id = IndexType_Partner1.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_1
FROM obs WHERE concept_id = 161135 AND voided = 0) AS PartnerFullName_1
ON PatnerElicitation1.person_id = PartnerFullName_1.person_id AND PatnerElicitation1.encounter_id = PartnerFullName_1.encounter_id AND PatnerElicitation1.obs_id = PartnerFullName_1.obs_group_id
    
-- ============================================================================
 -- Partner Elicitation for Partner Two
 -- =====================================
LEFT JOIN

 ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number2 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number2 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 2 ) AS PatnerElicitation2
 ON ClientCode.patient_id = PatnerElicitation2.person_id AND ClientCode.encounter_id = PatnerElicitation2.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_2
FROM obs WHERE concept_id = 165857 AND voided = 0 ) AS IndexRelation_Gender_2
ON PatnerElicitation2.person_id = IndexRelation_Gender_2.person_id AND PatnerElicitation2.encounter_id = IndexRelation_Gender_2.encounter_id AND PatnerElicitation2.obs_id = IndexRelation_Gender_2.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner2
FROM obs WHERE concept_id = 165798 AND voided = 0) AS IndexType_Partner2
ON PatnerElicitation2.person_id = IndexType_Partner2.person_id AND PatnerElicitation2.encounter_id = IndexType_Partner2.encounter_id AND PatnerElicitation2.obs_id = IndexType_Partner2.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_2
FROM obs WHERE concept_id = 161135 AND voided = 0) AS PartnerFullName_2
ON PatnerElicitation2.person_id = PartnerFullName_2.person_id AND PatnerElicitation2.encounter_id = PartnerFullName_2.encounter_id AND PatnerElicitation2.obs_id = PartnerFullName_2.obs_group_id
   

-- ============================================================================
 -- Partner Elicitation for Partner Three
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number3 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number3 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 3 ) AS PatnerElicitation3
 ON ClientCode.patient_id = PatnerElicitation3.person_id AND ClientCode.encounter_id = PatnerElicitation3.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_3
FROM obs WHERE concept_id = 165857 AND voided = 0) AS IndexRelation_Gender_3
ON PatnerElicitation3.person_id = IndexRelation_Gender_3.person_id AND PatnerElicitation3.encounter_id = IndexRelation_Gender_3.encounter_id AND PatnerElicitation3.obs_id = IndexRelation_Gender_3.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner3
FROM obs WHERE concept_id = 165798 AND voided = 0) AS IndexType_Partner3
ON PatnerElicitation3.person_id = IndexType_Partner3.person_id AND PatnerElicitation3.encounter_id = IndexType_Partner3.encounter_id AND PatnerElicitation3.obs_id = IndexType_Partner3.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_3
FROM obs WHERE concept_id = 161135 AND voided = 0 ) AS PartnerFullName_3
ON PatnerElicitation3.person_id = PartnerFullName_3.person_id AND PatnerElicitation3.encounter_id = PartnerFullName_3.encounter_id AND PatnerElicitation3.obs_id = PartnerFullName_3.obs_group_id
 
-- ============================================================================
 -- Partner Elicitation for Partner Four
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number4 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number4 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 4) AS PatnerElicitation4
 ON ClientCode.patient_id = PatnerElicitation4.person_id AND ClientCode.encounter_id = PatnerElicitation4.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_4
FROM obs WHERE concept_id = 165857 AND voided = 0 ) AS IndexRelation_Gender_4
ON PatnerElicitation4.person_id = IndexRelation_Gender_4.person_id AND PatnerElicitation4.encounter_id = IndexRelation_Gender_4.encounter_id AND PatnerElicitation4.obs_id = IndexRelation_Gender_4.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner4
FROM obs WHERE concept_id = 165798 AND voided = 0) AS IndexType_Partner4
ON PatnerElicitation4.person_id = IndexType_Partner4.person_id AND PatnerElicitation4.encounter_id = IndexType_Partner4.encounter_id AND PatnerElicitation4.obs_id = IndexType_Partner4.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_4
FROM obs WHERE concept_id = 161135 AND voided = 0) AS PartnerFullName_4
ON PatnerElicitation4.person_id = PartnerFullName_4.person_id AND PatnerElicitation4.encounter_id = PartnerFullName_4.encounter_id AND PatnerElicitation4.obs_id = PartnerFullName_4.obs_group_id


-- ============================================================================
 -- Partner Elicitation for Partner Five
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number5 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number5 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 5) AS PatnerElicitation5
 ON ClientCode.patient_id = PatnerElicitation5.person_id AND ClientCode.encounter_id = PatnerElicitation5.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_5
FROM obs WHERE concept_id = 165857 AND voided = 0) AS IndexRelation_Gender_5
ON PatnerElicitation5.person_id = IndexRelation_Gender_5.person_id AND PatnerElicitation5.encounter_id = IndexRelation_Gender_5.encounter_id AND PatnerElicitation5.obs_id = IndexRelation_Gender_5.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner5
FROM obs WHERE concept_id = 165798 AND voided = 0 ) AS IndexType_Partner5
ON PatnerElicitation5.person_id = IndexType_Partner5.person_id AND PatnerElicitation5.encounter_id = IndexType_Partner5.encounter_id AND PatnerElicitation5.obs_id = IndexType_Partner5.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_5
FROM obs WHERE concept_id = 161135 AND voided = 0) AS PartnerFullName_5
ON PatnerElicitation5.person_id = PartnerFullName_5.person_id AND PatnerElicitation5.encounter_id = PartnerFullName_5.encounter_id AND PatnerElicitation5.obs_id = PartnerFullName_5.obs_group_id
 

-- ============================================================================
 -- Partner Elicitation for Partner six
 -- =====================================
LEFT JOIN


 (
 SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number6 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number6 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858 AND voided = 0
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 6) AS PatnerElicitation6
 ON ClientCode.patient_id = PatnerElicitation6.person_id AND ClientCode.encounter_id = PatnerElicitation6.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN get_concept_name(value_coded) END AS IndexRelation_Gender_6
FROM obs WHERE concept_id = 165857 AND voided = 0 ) AS IndexRelation_Gender_6
ON PatnerElicitation6.person_id = IndexRelation_Gender_6.person_id AND PatnerElicitation6.encounter_id = IndexRelation_Gender_6.encounter_id AND PatnerElicitation6.obs_id = IndexRelation_Gender_6.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN get_concept_name(value_coded) END AS IndexType_Partner6
FROM obs WHERE concept_id = 165798 AND voided = 0 ) AS IndexType_Partner6
ON PatnerElicitation6.person_id = IndexType_Partner6.person_id AND PatnerElicitation6.encounter_id = IndexType_Partner6.encounter_id AND PatnerElicitation6.obs_id = IndexType_Partner6.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_6
FROM obs WHERE concept_id = 161135 AND voided = 0 ) AS PartnerFullName_6
ON PatnerElicitation6.person_id = PartnerFullName_6.person_id AND PatnerElicitation6.encounter_id = PartnerFullName_6.encounter_id AND PatnerElicitation6.obs_id = PartnerFullName_6.obs_group_id
  
 
 
-- =======================================
-- Join Biographical Information
-- =================================
LEFT JOIN
(SELECT DISTINCT A.person_id,A.birthdate, CASE WHEN A.gender = 'F' THEN 'Female' WHEN A.gender = 'M' THEN 'Male' ELSE NULL END AS Gender,FLOOR(DATEDIFF(CURDATE(), A.birthdate) / 365.25) AS CurrentAge,B.given_name, B.family_name FROM person AS A
JOIN person_name AS B USING (person_id) WHERE A.voided = 0 AND B.voided = 0 ) AS BioInfo
ON ClientCode.patient_id  = BioInfo.person_id

LEFT JOIN
(SELECT DISTINCT person_id, VALUE AS PhoneNumber FROM `person_attribute` WHERE person_attribute_type_id = 8 AND voided = 0) AS PhoneNo
ON ClientCode.patient_id = PhoneNo.person_id

LEFT JOIN 
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4 AND voided = 0)AS PEPFAR_Number
ON ClientCode.patient_id = PEPFAR_Number.patient_id
LEFT JOIN
(SELECT PAddress.person_id,PAddress.city_village AS LGA,TempLat.Latitude AS LGA_Latitude,TempLat.Longitude AS LGA_Longitude FROM
(SELECT person_id,city_village,state_province FROM person_address) AS PAddress
INNER JOIN
(SELECT * FROM Latitude_Temp) AS TempLat
ON PAddress.city_village  = TempLat.LGA  AND PAddress.state_province =  TempLat.state) AS Latitude
ON Latitude.person_id = ClientCode.patient_id
LEFT JOIN
(SELECT a.person_id, CONCAT(a.address1, ' ,', a.address2, ' ,', a.city_village, ' ,', a.state_province) AS 'Address' FROM `person_address` AS a GROUP BY a.person_id ) AS Address
ON ClientCode.patient_id = Address.person_id
LEFT JOIN 
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 8 AND voided = 0)AS HTS_ClientCode
ON ClientCode.patient_id = HTS_ClientCode.patient_id
WHERE ClientCode.num = 1 AND ClientCode.voided = 0
GROUP BY ClientCode.patient_id ;
DROP TABLE IF EXISTS Latitude_Temp;