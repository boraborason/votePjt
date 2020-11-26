package poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class DBConnecter {

	private DBConnectionMgr pool;

	public DBConnecter() { // 생성자
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
		}
	}

	//tbpollList에서 가장 큰 num값을 가져오는 메서드
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblpollList"; //설문 리스트에서 가장 큰 num값을 가져옴
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxNum = rs.getInt(1);  //가장 높은 num값 
			}
		} catch (Exception e) {
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return maxNum;
	}
	
	
	public boolean insertPoll(ListBean listbean, ItemBean itembean ){
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "insert tblPollList(question, sdate, edate, wdate, type)" + "values(?,?,?,now(),?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, listbean.getQuestion());
			pstmt.setString(2, listbean.getSdate());
			pstmt.setString(3, listbean.getEdate());
			pstmt.setInt(4, listbean.getType());
			
			int result = pstmt.executeUpdate();
			
			if(result==1) {
				sql = "insert tblPollItem values(?,?,?,?)";
			}
			pstmt = con.prepareStatement(sql);
			String item[] = itembean.getItem();
			int itemnum = getMaxNum();
			int j = 0;
			for(int i = 0; i < item.length; i++) {
				if(item[i] == null || item[i].equals("")) {
					break;
				}
			pstmt.setInt(1, itemnum);	
			pstmt.setInt(2, i);	
			pstmt.setString(3, item[i]);	
			pstmt.setInt(4, 0);
			j = pstmt.executeUpdate();
			}
			if (j > 0) {
				flag = true;
			}
		} catch (Exception e) {
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// 모든 투표 설문 가져오는 메서드
	public Vector<ListBean> getAllList() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		Vector<ListBean> list = new Vector<ListBean>();

		try {
			con = pool.getConnection();
			sql = "select * from tblpollList order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ListBean listbean = new ListBean();
				listbean.setNum(rs.getInt("num"));
				listbean.setQuestion(rs.getString("question"));
				listbean.setSdate(rs.getString("sdate"));
				listbean.setEdate(rs.getString("edate"));
				list.add(listbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return list;
	}

	
	//num값에 맞는 선택된 투표 설문을 tbpollList에서 얻는 메서드 
	public ListBean getList(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		ListBean listbean = new ListBean();

		try {
			con = pool.getConnection();
			if (num == 0) {
				sql = "select * from tblpollList order by num desc"; // num값이 0이면 tbpollList를 내림차순으로 가져옴
			} else {
				sql = "select * from tblpollList where num=" + num; // 아니라면 num값을 매개변수로 받아 조건으로 사용
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				listbean.setQuestion(rs.getString("question"));
				listbean.setType(rs.getInt("type"));
				listbean.setActive(rs.getInt("active"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return listbean;
	}
	
	//선택된 투표 설문의 항목을 tblPollItem에서 읽어오는 메서드
	public Vector<String> getItem(int num){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		Vector<String> list = new Vector<String>();
		
		try {
			con = pool.getConnection();
			if(num == 0) {
				num = getMaxNum();
			}
			sql = "select item from tblPollItem where listnum = ?";
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (Exception e) {
		}
		return list;
	}
	
	//사용자의 투표를 반영하는 메서드로 num값에 의해 선택된 값을 통해 tblPollItem 테이블에 투표 데이터 업뎃
	public boolean updatePoll(int num, String[] itemnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false; 
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "update tblPollItem set cout = count + 1 where listnum = ? and item = ?";
			pstmt = con.prepareStatement(sql);
			if(num == 0) 
				num = getMaxNum();
			for(int i = 0; i < itemnum.length; i++) {
				if(itemnum[i] == null || itemnum[i].equals("")) {
					break;	
				}
				pstmt.setInt(1, num);
				pstmt.setInt(2, Integer.parseInt(itemnum[i]));
				int j = pstmt.executeUpdate();
				if(j > 0) {
					flag = true;
				}
			}
			
		} catch (Exception e) {
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public Vector<ItemBean> getView(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		Vector<ItemBean> list = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "select item,count from tblPollItem where listnum=?";
			pstmt = con.prepareStatement(sql);
			if (num == 0)
				pstmt.setInt(1, getMaxNum());
			else
				pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ItemBean itemBean = new ItemBean();
				String item[] = new String[1];
				item[0] = rs.getString(1);
				itemBean.setItem(item);
				itemBean.setCount(rs.getInt(2));
				list.add(itemBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;
	}

	public int sumCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select sum(count) from tblPollItem where listnum=?";
			pstmt = con.prepareStatement(sql);
			if (num == 0)
				pstmt.setInt(1, getMaxNum());
			else
				pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return count;
	}
}
