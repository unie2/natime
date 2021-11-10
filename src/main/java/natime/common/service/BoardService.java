package natime.common.service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface BoardService {

    List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;

    List<Map<String, Object>> SearchInfo(Map<String, Object> map) throws Exception;

    void insertBoard(Map<String, Object> map) throws Exception;

    void deleteBoard(Map<String, Object> map) throws Exception;
}
