package natime.common.service;

import natime.common.dao.MemberDAO;
import natime.common.util.AES_256;
import natime.common.util.SHA_256;
import natime.common.util.Send_Mail;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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

    @Override
    public String find_id(Map<String, Object> map) throws Exception {
        List<Map<String, Object>> resultMap = memberDAO.find_id(map);
        System.out.println("resultMap : " + resultMap);
        JSONObject obj = new JSONObject();

        return obj.toJSONString();
    }

    @Override
    public String find_pw(Map<String, Object> map) throws Exception {
        Map<String, Object> resultMap = memberDAO.find_pw(map);
        JSONObject obj = new JSONObject();

        boolean flag = true;
        try {
            String id = (String) resultMap.get("id");
            if (id.length() <= 0) {
                flag = false;
                log.debug("가입되지 않은 정보");
            }
        } catch (Exception e) {
            flag = false;
            log.debug("가입되지 않은 정보" + e);
            obj.put("msg", "일치하는 정보가 없습니다.");
        }

        if (flag) {
            String origin_pw = (String) resultMap.get("pw");
            String temp_pw = "";
            String email = (String) resultMap.get("email");

            try {
                email = new AES_256().decrypt(email);
            } catch (Exception e) {
                log.error("메일 복호화 오류" + e);
                obj.put("msg", "죄송합니다. 메일 발송에 실패하였습니다.");
                return obj.toJSONString();
            }

            Random random = new Random();
            for (int i=0; i<10; i++) {
                if (random.nextBoolean()) {
                    temp_pw = temp_pw + (char)((int)(random.nextInt(26)) + 97);
                } else {
                    temp_pw = temp_pw + (random.nextInt(10));
                }
            }

            map.put("temp_pw", sha_256.encrypt(temp_pw));
            memberDAO.change_pw(map);

            try {
                String Content = "안녕하세요. NaTime 웹 관리자입니다. <br> 회원님의 임시 비밀번호는 [ "+temp_pw+" ] 입니다. <br> 임시비밀번호로 로그인 후 프로필에서 비밀번호를 다시 설정해주세요. <br> - NaTime-";
                String Title = "NaTime - 임시 비밀번호 설정 안내입니다.";
                log.info("비밀번호 찾기 : id = "+resultMap.get("id")+" email = " + resultMap.get("email"));
                new Send_Mail(email, Content, Title).Send_pw_mail();
                obj.put("msg", "등록된 이메일로 임시 비밀번호가 발송되었습니다.");
            } catch (Exception e) {
                log.error("비밀번호 찾기 실패" + e);
                map.put("temp_pw", origin_pw);
                memberDAO.change_pw(map);
                obj.put("msg", "죄송합니다. 메일 발송에 실패하였습니다.");
            }
        } else {
            obj.put("msg", "일치하는 정보가 없습니다.\n회원가입을 해주세요.");
        }
        return obj.toJSONString();
    }
}
