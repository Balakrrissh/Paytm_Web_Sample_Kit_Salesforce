public class AesEncryption implements Encryption {

    private List<Integer> paramBytes = new List<Integer> { 64, 64, 64, 64, 38, 38, 38, 38, 35, 35, 35, 35, 36, 36, 36, 36 };

    /**
    * @description
    * @author @BK | 26/3/2019
    * @param String data
    * @param String Key
    * @return String
    */
    public String encrypt(String data, String Key) {
        String encryptedString = '';
        Blob ivParamBytes = initializationVector();
        Blob crypto128Key = Blob.valueOf(Key);
        Blob dataToBeEncryptedAsBlob = Blob.valueOf(data);
        try {
            Blob returnCipher = Crypto.encrypt('AES128', crypto128Key, ivParamBytes, dataToBeEncryptedAsBlob); //encrypts the Blob using the AES128 algorithm and 128 bit private key
            encryptedString = EncodingUtil.base64Encode(returnCipher);
        } catch (Exception e) {
           System.debug('Error in encrypt -->'+e);
        }
        return encryptedString;
    }

    /**
    * @description
    * @author @BK | 26/3/2019
    * @param String toDecrypt
    * @param String key
    * @return String
    */
    public String decrypt(String toDecrypt, String key) {
        String decryptedString = '';
        Blob crypto128Key = Blob.valueOf(Key);
        Blob ivParamBytes = initializationVector();
        Blob dataToBeDecryptedAsString = EncodingUtil.base64Decode(toDecrypt);
        try {
            Blob decrypted = Crypto.decrypt('AES128', crypto128Key, ivParamBytes, dataToBeDecryptedAsString);
            decryptedString = decrypted.toString();
        } catch (Exception e) {
            System.debug('Error in decrypt -->'+e);
        }
        return decryptedString;
    }


    /**
    * @description for initializationVector
    * @author @BK | 26/3/2019
    * @return Blob
    */
    public Blob initializationVector() {
        String[] codes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='.split('');
        Integer length = paramBytes.size();
        // Preallocate memory for speed
        String[] result = new String[(length+2)/3];
        // Every three bytes input becomes four bytes output
        Integer size = length - Math.mod(length, 3);
        Integer resultIndex = 0;
        for(Integer index = 0; index < size;) {
            // Combine three bytes in to one single integer
            Integer temp = (paramBytes[index++]<<16|paramBytes[index++]<<8)|paramBytes[index++];
            // Extract four values from 0-63, and use the code from the base 64 index
            result[resultIndex++]=codes[temp>>18]+(codes[(temp>>12)&63])+(codes[(temp>>6)&63])+codes[temp&63];
        }
        if(Math.mod(length,3)==1) {
            // One byte left over, need two bytes padding
            Integer temp = (paramBytes[length-1]<<16);
            result[result.size()-1] = codes[temp>>18]+(codes[(temp>>12)&63])+codes[64]+codes[64];
        } else if(Math.mod(paramBytes.size(),3)==2) {
            // Two bytes left over, need one byte padding
            Integer temp = (paramBytes[length-2]<<16)|(paramBytes[length-1]<<8);
            result[result.size()-1] = codes[temp>>18]+(codes[(temp>>12)&63])+(codes[(temp>>6)&63])+codes[64];
        }
        String base64Encoded = String.join(result, '');
        // Join into a single string
        return EncodingUtil.base64Decode(base64Encoded);
    }

}