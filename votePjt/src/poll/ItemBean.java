package poll;

public class ItemBean { 
	
	private int listnum; //투표 된 설문번호
	private int itemnum; //아에템 번호 (1,2,3,4)
	private String[] item; //아이템 내용 (4가지)
	private int count;  //투표수

	public int getListnum() {
		return listnum;
	}

	public void setListnum(int listnum) {
		this.listnum = listnum;
	}

	public int getItemnum() {
		return itemnum;
	}

	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}

	public String[] getItem() {
		return item;
	}

	public void setItem(String[] item) {
		this.item = item;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;

	}
}
