public interface Encryption {

	
	/**
	* @description
	* @author @BK | 26/3/2019
	* @param ;
	* @return String
	*/
	String encrypt(String data, String Key);

	/**
	* @description
	* @author @BK | 26/3/2019
	* @param ;
	* @return String
	*/
	String decrypt(String toDecrypt, String key);
}