package natime.common.controller;

import natime.common.service.BoardService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class BoardController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "boardService")
    private BoardService boardService;

    @RequestMapping(value = "/boardList_page.do")
    public ModelAndView boardListPage(Map<String, Object> commandMap, HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("/board/boardList");
        List<Map<String, Object>> list = boardService.selectBoardList(commandMap);
        HttpSession session = req.getSession();
        Map<String, Object> map = (Map) session.getAttribute("member_info");

        Map star = new HashMap();
        star.put(0, "☆☆☆☆☆");
        star.put(1, "★☆☆☆☆");
        star.put(2, "★★☆☆☆");
        star.put(3, "★★★☆☆");
        star.put(4, "★★★★☆");
        star.put(5, "★★★★★");

        mv.addObject("list", list);
        mv.addObject("star", star);
        mv.addObject("member_info", map);
        return mv;
    }

}
