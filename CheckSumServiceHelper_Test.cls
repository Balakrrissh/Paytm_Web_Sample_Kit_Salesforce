@isTest
private class CheckSumServiceHelper_Test
{
	//Initial Test Data
	//Add Logic to Create data required
	static CheckSumServiceHelper instance = null;
	static void SetUp(){
		test.StartTest();
	}
	//Tear Down 
	//Add Logic to delete data that has been created
	static void TearDown(){
		test.StopTest();
	}
	
	// Test Method: getVersion
	public static testmethod void Test_getVersion(){
		SetUp();
		// TODO : Change following Assert Statement
		System.Assert(CheckSumServiceHelper.getCheckSumServiceHelper().getVersion() == '2.0');
		TearDown();
	}

	// Test Method: getCheckSumServiceHelper
	public static testmethod void Test_getCheckSumServiceHelper(){
		SetUp();
		// TODO : Change following Assert Statement
		System.Assert(CheckSumServiceHelper.getCheckSumServiceHelper() != null);
		TearDown();
	}

	// Test Method: verifycheckSum
	public static testmethod void Test_verifycheckSum(){
		SetUp();

		string masterkey = 'ldnoMOg0GFUJBsR1';
		Map<string, string> paramap = new Map<string,string>();
        paramap.put('MID','Sharda81867340973124');
        paramap.put('ORDER_ID','01191164763201932619332931562');
        paramap.put('CHANNEL_ID','WEB');
        paramap.put('CUST_ID','00QO0000009fIGo');
        paramap.put('MOBILE_NO','7945341321');
        paramap.put('EMAIL','test34@gmail.com');
        paramap.put('TXN_AMOUNT','1200.00');
        paramap.put('WEBSITE','WEBSTAGING');
        paramap.put('INDUSTRY_TYPE_ID','Retail');
        paramap.put('CALLBACK_URL', 'http://sandbox.cs1.force.com/nmPaytmPayResponse');

		
		// Test Method: genrateCheckSum
		string responsechecksumstring = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum(masterkey, paramap);

		// TODO : Change following Assert Statement
		System.Assert(CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(masterkey, paramap, responsechecksumstring) == true);
		TearDown();
	}

	// Test Method: getCheckSumString
	public static testmethod void Test_getCheckSumString(){
		SetUp();

		Map<string, string> parammap = new Map<string,string>();
        parammap.put('MID','Sharda81867340973124');
        parammap.put('ORDER_ID','01191164763201932619332931562');
        parammap.put('CHANNEL_ID','WEB');
        parammap.put('CUST_ID','00QO0000009fIGo');
        parammap.put('MOBILE_NO','7945341321');
        parammap.put('EMAIL','test34@gmail.com');
        parammap.put('TXN_AMOUNT','1200.00');
        parammap.put('WEBSITE','WEBSTAGING');
        parammap.put('INDUSTRY_TYPE_ID','Retail');
        parammap.put('CALLBACK_URL', 'http://sandbox.cs1.force.com/nmPaytmPayResponse');
		// TODO : Change following Assert Statement
		System.Assert(CheckSumServiceHelper.getCheckSumServiceHelper().getCheckSumString(parammap) == 'http://sandbox.cs1.force.com/nmPaytmPayResponse|WEB|00QO0000009fIGo|test34@gmail.com|Retail|Sharda81867340973124|7945341321|01191164763201932619332931562|1200.00|WEBSTAGING|');
		TearDown();
	}

	// Test Method: verifycheckSumQueryStr
	public static testmethod void Test_verifycheckSumQueryStr(){
		SetUp();

		String paramap = 'MID=Sharda81867340973124&ORDERID=SU0201601695900001&TXNAMOUNT=1200.00&CURRENCY=INR&TXNID=32297948&BANKTXNID=561597&STATUS=TXN_SUCCESS&RESPCODE=01&RESPMSG=Txn Successful.&TXNDATE=2017-02-22 10:30:25.0&GATEWAYNAME=WALLET&BANKNAME=&PAYMENTMODE=PPI';
		String masterkey = 'ldnoMOg0GFUJBsR1';
		String responsechecksumstring = '7K6+aA8sk5Mr8LMRfhnYdBt3f5IwZdZUUsVT/aIr/xqaZO9Yjjafr1Y0mOYK61xCHJhp+JJOfaFIgf/VHpx6SRxr0rurIWR9O6EnrSiOzSc=';

		// TODO : Change following Assert Statement
		System.Assert(CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSumQueryStr(masterkey, paramap, responsechecksumstring) == true);
		TearDown();
	}
}