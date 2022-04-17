package AllLayout;

public class Airport {
	public String id, name, contact, address;
	public Airport() {
		this.id = this.name = this.contact= this.address = "";
	}
	public Airport(String argId, String argName, String argContact, String argAddress) {
		this.id = argId;
		this.name = argName;
		this.contact = argContact;
		this.address = argAddress;
	}
}
