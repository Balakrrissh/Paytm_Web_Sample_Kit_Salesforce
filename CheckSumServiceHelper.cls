public with sharing class CheckSumServiceHelper {

	private CryptoUtils CryptoUtils = new CryptoUtils();
    private static final CheckSumServiceHelper CheckSumServiceHelper = new CheckSumServiceHelper();

    private CheckSumServiceHelper() {}
    
    public String getVersion() {
        return '2.0';
    }

    public static CheckSumServiceHelper getCheckSumServiceHelper() {
        return CheckSumServiceHelper;
    }

	/**
    * @description
    * @author @BK | 20/3/2019
    * @param String Key
    * @param Map<String, String> paramap
    * @return String
    */
    public String genrateCheckSum(String Key, Map<String, String> paramap) {
        String response = CheckSumServiceHelper.getCheckSumString(paramap);
        String checkSumValue = null;
        try {
            Encryption encryption = new AesEncryption();
            String randomNo = CryptoUtils.generateRandomString(4);
            response = response + randomNo;
            String checkSumHash = CryptoUtils.getSHA256(response);
            checkSumHash = checkSumHash + randomNo;
            checkSumValue = encryption.encrypt(checkSumHash, Key);

            if (String.isNotBlank(checkSumValue)) {
                checkSumValue = checkSumValue.replaceAll('\r\n', '');
                checkSumValue = checkSumValue.replaceAll('\r', '');
                checkSumValue = checkSumValue.replaceAll('\n', '');
            }

            System.debug('checkSumValue after ==>'+checkSumValue);
        }
        catch (Exception e) {
            System.debug('Error in genrateCheckSum -->'+e);
        }
        return checkSumValue;
    }

    /**
    * @description
    * @author @BK | 22/3/2019
    * @param String masterKey
    * @param Map<String, String> paramap
    * @param String responseCheckSumString
    * @return Boolean
    */
    public Boolean verifycheckSum(String masterKey, Map<String, String> paramap, String responseCheckSumString) {
        Boolean isValidChecksum = false;
        String response = CheckSumServiceHelper.getCheckSumString(paramap);
        Encryption encryption = new AesEncryption();
        String responseCheckSumHash = encryption.decrypt(responseCheckSumString, masterKey);
        String randomStr = CryptoUtils.getLastNChars(responseCheckSumHash, 4);
        String payTmCheckSumHash = calculateRequestCheckSum(randomStr, response);
        
        if((responseCheckSumHash != null) && (payTmCheckSumHash != null) && (responseCheckSumHash.equals(payTmCheckSumHash))) {
            isValidChecksum = true;
        }
        return isValidChecksum;
    }

    /**
    * @description
    * @author @BK | 20/3/2019
    * @param Map<String, String> paramMap
    * @return String
    */
    public String getCheckSumString(Map<String, String> paramMap) {
        Set<String> keys = paramMap.keySet();
        String checkSumStringBuffer = '';
        List<String> parameterSet = new List<String>();
        for (String key : keys) {
            if (!'CHECKSUMHASH'.equalsIgnoreCase(key)) {
                parameterSet.add(key);
            }
        }
        // To sort the Key in alphabetical order.
        parameterSet.sort();
        for (String paramName : parameterSet) {
            String value = (String)paramMap.get(paramName);
            System.debug('---paramName--'+paramName+'----'+value);
            if((!value.toLowerCase().contains('|'))){
                if ((value == null) || (value.trim().equalsIgnoreCase('NULL'))) {
                    System.debug('empty Key -->'+paramName);
                    value = '';
                }
                checkSumStringBuffer = checkSumStringBuffer + value +'|' ;
            }
        }
        return checkSumStringBuffer;
    }

    /**
    * @description
    * @author @BK | 20/3/2019
    * @param String randomStr
    * @param String checkSumString
    * @return String
    */
    private String calculateRequestCheckSum(String randomStr, String checkSumString) {
        String reqCheckSumValue = checkSumString + randomStr;
        String checkSumHash = CryptoUtils.getSHA256(reqCheckSumValue);
        checkSumHash = checkSumHash + randomStr;
        return checkSumHash;
    }

    /**
    * @description
    * @author @BK | 20/3/2019
    * @param String masterKey
    * @param String paramap
    * @param String responseCheckSumString
    * @return Boolean
    */
    public Boolean verifycheckSumQueryStr(String masterKey, String paramap, String responseCheckSumString) {
        Boolean isValidChecksum = false;
        String response = CheckSumServiceHelper.getCheckSumStringByQueryString(paramap);
        Encryption encryption = new AesEncryption();
        String responseCheckSumHash = encryption.decrypt(responseCheckSumString, masterKey);
        String randomStr = CryptoUtils.getLastNChars(responseCheckSumHash, 4);
        String payTmCheckSumHash = calculateRequestCheckSum(randomStr, response);
        
        if((responseCheckSumHash != null) && (payTmCheckSumHash != null) && (responseCheckSumHash.equals(payTmCheckSumHash))) {
            isValidChecksum = true;
        }
        return isValidChecksum;
    }

    /**
    * @description
    * @author @BK | 20/3/2019
    * @param String paramString
    * @return String
    */
    public String getCheckSumStringByQueryString(String paramString) { 
        Map<String, String> paramMap = new Map<String, String>();
        String[] params = paramString.split('&');
        String[] keyValue;
        if ((params != null) && (params.size() > 0)) {
            for (String param : params) {
                keyValue = param.split('=');
                if (keyValue != null) {
                    if (keyValue.size() == 2) {
                        paramMap.put(keyValue[0], keyValue[1]);
                        System.debug('Key=' + keyValue[0] + ', Value=' + keyValue[1]);
                    } else if (keyValue.size() == 1) {
                        paramMap.put(keyValue[0], '');
                    }
                }
            }
        }
        String checkSumStringBuffer = CheckSumServiceHelper.getCheckSumString(paramMap);
        return checkSumStringBuffer;
    }
}