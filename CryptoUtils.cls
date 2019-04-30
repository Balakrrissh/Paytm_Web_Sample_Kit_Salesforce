public class CryptoUtils {

	public CryptoUtils() {}

	/**
	* @description
	* @author @BK | 26/3/2019
	* @param Integer length
	* @return String
	*/
	public String generateRandomString(Integer length) {
        String charString = '9876543210ZYXWVUTSRQPONMLKJIHGFEDCBAabcdefghijklmnopqrstuvwxyz!@#$&_';
        String randomNew = '';
        while (randomNew.length() < length) {
            Integer changeInt5 = Math.mod(Math.abs(Crypto.getRandomInteger()), charString.length());
            randomNew += charString.substring(changeInt5 , changeInt5 +1);
        }
        randomNew = randomNew.left(4);
        return randomNew;
    }

	/**
	* @description
	* @author @BK | 26/3/2019
	* @param String value
	* @return String
	*/
	public String getSHA256(String value) {
        String hashValue = '';
        try {
            System.debug('value of hash -->'+value);
            Blob targetBlob = Blob.valueOf(value);
            Blob hash = Crypto.generateDigest('SHA-256', targetBlob);
            hashValue = EncodingUtil.convertToHex(hash);
            System.debug('hashValue -->'+hashValue);
        }
        catch (Exception e) {
            System.debug('Error in getSHA256 -->'+e);
        }
        return hashValue;
    }

	/**
	* @description
	* @author @BK | 26/3/2019
	* @param String inputString
	* @param Integer subStringLength
	* @return String
	*/
	public String getLastNChars(String inputString, Integer subStringLength) {
        if ((inputString != null) && (inputString.length() > 0)) {
            Integer length = inputString.length();
            if (length <= subStringLength) {
                return inputString;
            }
            Integer startIndex = length - subStringLength;
            return inputString.substring(startIndex);
        }
        return '';
    }
}