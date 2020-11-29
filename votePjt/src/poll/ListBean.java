package poll;

public class ListBean {  

	private int num; 		//설문번호
	private String question;//설문내용
	private String sdate;	//시작날짜
	private String edate;	//종료날짜
	private String wdate;	//작성날짜
	private int type;		//중복투표 허용여부
	private int active;		//설문 활성화 여부
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int actice) {
		this.active = actice;
	}
}
