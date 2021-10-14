package natime.common.service;

import natime.common.dao.MemberDAO;
import natime.common.util.SHA_256;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "memberDAO")
    private MemberDAO memberDAO;

    @Resource(name = "SHA_256")
    private SHA_256 sha_256;

    @Override
    public int Login(Map<String, Object> map, HttpServletRequest req) throws Exception {
        HttpSession session = req.getSession();
        Map<String, Object> resultMap = new HashMap<>();

        if ((resultMap = memberDAO.Login(map)) == null) {
            log.error("등록이 안된 회원 ID : " + map.get("id"));
            return 1;
        } else {
            try {
                //map.put("pw", sha_256.encrypt((String)map.get("pw")));
                map.put("pw", (String)map.get("pw"));
            } catch (Exception e) {
                log.error("비밀번호 sha 암호화 오류 : " + e);
            }
            if ((resultMap = memberDAO.Login_2(map)) == null) {
                log.error("비밀번호 오류 ID : " + map.get("id"));
                return 2;
            }
        }

        session.setAttribute("member_info", resultMap);
        log.debug("로그인 : " + resultMap);

        return 3;
    }
}
