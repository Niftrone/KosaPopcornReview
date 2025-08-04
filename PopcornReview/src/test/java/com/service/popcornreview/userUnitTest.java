package com.service.popcornreview;

import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.service.popcornreview.vo.User;


public class userUnitTest {

	   public static void main(String[] args) throws Exception {
	        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
	        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
	        SqlSession session = factory.openSession(true); // auto-commit

	        String NS = "ns.sql.UserMapper.";

	        // 1. INSERT 테스트
	        User user = new User();
	        user.setId("u100");
	        user.setPwd("pass1234");
	        user.setEmail("test@kosa.com");
	        user.setName("홍길동");
	        user.setBirthdate("1990-01-01");
	        user.setPhone("010-1234-5678");
	        user.setGender(true);

	        int insertResult = session.insert(NS + "addUser", user);
	        System.out.println("📌 INSERT 결과: " + insertResult);

	        // 2. UPDATE 테스트
	        user.setPwd("updated1234");
	        user.setEmail("newemail@kosa.com");
	        user.setName("홍길동수정");
	        user.setPhone("010-9876-5432");

	        int updateResult = session.update(NS + "updateUser", user);
	        System.out.println("UPDATE 결과: " + updateResult);

	        // 3. SELECT 테스트 (조건: id + pwd)
	        User loginParam = new User();
	        loginParam.setId("u100");
	        loginParam.setPwd("updated1234");

	        List<User> loginResult = session.selectList(NS + "getUser", loginParam);
	        System.out.println("SELECT 로그인 결과:");
	        for (User u : loginResult) {
	            System.out.println(u);
	        }

	        // 4. SELECT 테스트 (조건: name + phone)
	        User namePhoneParam = new User();
	        namePhoneParam.setName("홍길동수정");
	        namePhoneParam.setPhone("010-9876-5432");

	        List<User> namePhoneResult = session.selectList(NS + "getUser", namePhoneParam);
	        System.out.println("SELECT 이름+전화번호 결과:");
	        for (User u : namePhoneResult) {
	            System.out.println(u);
	        }

	        // 5. SELECT 테스트 (조건: id + email)
	        User idEmailParam = new User();
	        idEmailParam.setId("u100");
	        idEmailParam.setEmail("newemail@kosa.com");

	        List<User> idEmailResult = session.selectList(NS + "getUser", idEmailParam);
	        System.out.println("SELECT 아이디+이메일 결과:");
	        for (User u : idEmailResult) {
	            System.out.println(u);
	        }

	        // 6. DELETE 테스트
	        int deleteResult = session.delete(NS + "deleteUser", "u100");
	        System.out.println("DELETE 결과: " + deleteResult);

	        session.close();
	    }

}
