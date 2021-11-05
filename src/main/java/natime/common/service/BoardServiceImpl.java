package natime.common.service;

import natime.common.dao.BoardDAO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
}
