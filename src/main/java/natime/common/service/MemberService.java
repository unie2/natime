package natime.common.service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface MemberService {

    int Login(Map<String, Object> map, HttpServletRequest req) throws Exception;
}
