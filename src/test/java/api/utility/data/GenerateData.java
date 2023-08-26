package api.utility.data;

public class GenerateData {

	public static String getEmail() {
		String prefix = "1shoshi";
		String provider = "@tekschool.us";
		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider;
		return email;
		// "Auto_email12425453@tekschool.us"
	}
	
	public static String getPhoneNumber() {
//		
		String phoneNumber = "2";
		for(int i = 0; i < 9; i++) {
			phoneNumber += (int) (Math.random() *10);
		}
		return phoneNumber;
//		
	}
 public static void main(String[] args) {
	 
	 String number = getPhoneNumber();
	 System.out.println(number);
	 System.out.println(number.length());
 }
	
 public static String getLicensePlate() {
	 String prefix =  "xcv";
	 String sufix = "abv";
	 int random = (int)(Math.random()*10000);
	 String licensePlate = prefix + random + sufix;
	 return licensePlate;
			
	 
 }
	
}
