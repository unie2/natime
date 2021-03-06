package natime.common.dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MemberDAO extends AbstractDAO {
    Logger log = Logger.getLogger(this.getClass());

    public Map<String, Object> Login(Map<String, Object> map) {
        return (Map<String, Object>) selectOne("member.Login", map);
    }

    public Map<String, Object> Login_2(Map<String, Object> map) {
        return (Map<String, Object>) selectOne("member.Login_2", map);
    }

    public int idCK(String id) throws Exception {
        return (int) selectOne("member.idCK", id);
    }

    public void registration(Map<String, Object> map) {
        insert("member.registration", map);
    }

    public Map<String, Object> find_id(Map<String, Object> map) throws Exception {
        return (Map<String, Object>) selectOne("member.find_id", map);
    }

    public Map<String, Object> find_pw(Map<String, Object> map) throws Exception {
        return (Map<String, Object>) selectOne("member.find_pw", map);
    }

    public int change_pw(Map<String, Object> map) throws Exception {
        return (int) update("member.change_pw", map);
    }

    public Map<String, Object> myPage(Map<String, Object> map) throws Exception {
        return (Map<String, Object>) selectOne("member.myPage", map);
    }

    public void edit_profile(Map<String, Object> map) throws Exception {
        update("member.edit_profile", map);
    }

    public void edit_password(Map<String, Object> map) throws Exception {
        update("member.edit_password", map);
    }
}
