package natime.common.dao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

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
}
