package natime.common.dao;


import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO {
    Logger log = Logger.getLogger(this.getClass());

    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
        return (List<Map<String, Object>>) selectList("board.selectBoardList", map);
    }

    public List<Map<String, Object>> SearchInfo(Map<String, Object> map) throws Exception {
        return (List<Map<String, Object>>) selectList("board.SearchInfo", map);
    }

    public void insertBoard(Map<String, Object> map) throws Exception {
        insert("board.insertBoard", map);
    }

    public void deleteBoard(Map<String, Object> map) throws Exception {
        delete("board.deleteBoard", map);
    }
}
