package natime.common.controller;

import natime.common.common.CommandMap;
import natime.common.service.BoardService;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


@Controller
public class BoardController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "boardService")
    private BoardService boardService;

    @RequestMapping(value = "/boardList_page.do")
    public ModelAndView boardListPage(Map<String, Object> commandMap, HttpServletRequest req, CommandMap command) throws Exception {
        ModelAndView mv = new ModelAndView("/board/boardList");
        //List<Map<String, Object>> list = boardService.selectBoardList(commandMap);
        List<Map<String, Object>> data = boardService.boardChart();
        String chart = "";
        for (int i=0 ; i<data.size(); i++) {
            if (chart != "") {
                chart += ",";
            }
            chart += "['"+data.get(i).get("lecture")+"', "+data.get(i).get("COUNT")+"]";
        }

        HttpSession session = req.getSession();
        Map<String, Object> map = (Map) session.getAttribute("member_info");

        Map star = new HashMap();
        star.put(0, "☆☆☆☆☆");
        star.put(1, "★☆☆☆☆");
        star.put(2, "★★☆☆☆");
        star.put(3, "★★★☆☆");
        star.put(4, "★★★★☆");
        star.put(5, "★★★★★");

        List<Map<String, Object>> list = boardService.SearchInfo(command.getMap());


        mv.addObject("chart", chart);
        mv.addObject("list", list);
        mv.addObject("star", star);
        mv.addObject("member_info", map);

        return mv;
    }

    @RequestMapping(value = "/boardWrite_page.do")
    public ModelAndView boardWritePage(CommandMap commandMap, HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("/board/boardWrite");
        HttpSession session = req.getSession();
        Map<String, Object> map = (Map<String, Object>) session.getAttribute("member_info");

        mv.addObject("member_info", map);
        return mv;
    }

    @RequestMapping(value = "/insertBoard.do")
    public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/boardList_page.do");
        System.out.println(commandMap.getMap());
        boardService.insertBoard(commandMap.getMap());

        return mv;
    }

    @RequestMapping(value = "/deleteBoard.do")
    public ModelAndView deleteBoard(CommandMap commandMap, HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/boardList_page.do");
        boardService.deleteBoard(commandMap.getMap());


        return mv;
    }

    @RequestMapping(value = "/ajaxchart.do")
    public String boardChart(HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("/board/boardList");
        List<Map<String, Object>> list = boardService.boardChart();
        System.out.println("list : " + list);
        mv.addObject("list", list);

        HashMap map = new HashMap();
        map.put("list", list);
        String json = null;
        try {
            json = new ObjectMapper().writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return json;
    }
}
