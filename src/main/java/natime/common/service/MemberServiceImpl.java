package natime.common.service;

import natime.common.dao.MemberDAO;
import natime.common.util.AES_256;
import natime.common.util.SHA_256;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "memberDAO")
    private MemberDAO memberDAO;

    @Resource(name = "SHA_256")
    private SHA_256 sha_256;

    @Resource(name = "AES_256")
    private AES_256 aes_256;

    @Override
    public int Login(Map<String, Object> map, HttpServletRequest req) throws Exception {
        HttpSession session = req.getSession();
        Map<String, Object> resultMap = new HashMap<>();

        if ((resultMap = memberDAO.Login(map)) == null) {
            log.error("등록이 안된 회원 ID : " + map.get("id"));
            return 1;
        } else {
            try {
                map.put("pw", sha_256.encrypt((String)map.get("pw")));
                //map.put("pw", (String)map.get("pw"));
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

    @SuppressWarnings("unchecked")
    @Override
    public int idCK(String id) throws Exception {
        int result = memberDAO.idCK(id);
        return result;
    }

    @Override
    public boolean registration(Map<String, Object> map) throws Exception {
        boolean flag = false;

        log.info("회원가입 : " + map.get("id"));
        try {
            String pw = (String) map.get("pw");
            String phone = (String) map.get("phone");
            String email = (String) map.get("email");

            map.put("pw", sha_256.encrypt(pw));
            map.put("phone", aes_256.encrypt(phone));
            map.put("email", aes_256.encrypt(email));

            memberDAO.registration(map);
            flag = true;

        } catch (Exception e) {
            flag = false;
            log.error(e);
        }

        return flag;
    }
}
