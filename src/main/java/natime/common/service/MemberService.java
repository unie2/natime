package natime.common.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface MemberService {

    int Login(Map<String, Object> map, HttpServletRequest req) throws Exception;

    int idCK(String id) throws Exception;

    boolean registration(Map<String, Object> map) throws Exception;

    String find_id(Map<String, Object> map) throws Exception;

    String find_pw(Map<String, Object> map) throws Exception;
}
