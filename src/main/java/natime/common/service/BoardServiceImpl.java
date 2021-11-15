package natime.common.service;

import natime.common.dao.BoardDAO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "boardDAO")
    private BoardDAO boardDAO;

    @Override
    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
        return boardDAO.selectBoardList(map);
    }

    @Override
    public List<Map<String, Object>> SearchInfo(Map<String, Object> map) throws Exception {
        return boardDAO.SearchInfo(map);
    }

    public void insertBoard(Map<String, Object> map) throws Exception {
        map.put("content", map.get("content").toString().replaceAll("\r\n", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>"));
        boardDAO.insertBoard(map);
    }

    public void deleteBoard(Map<String, Object> map) throws Exception {
        boardDAO.deleteBoard(map);
    }

    public List<Map<String, Object>> boardChart() throws Exception {
        return boardDAO.boardChart();
    }
}
