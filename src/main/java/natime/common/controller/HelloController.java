package natime.common.controller;

import natime.common.service.SampleService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
public class HelloController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "sampleService")
    private SampleService sampleService;

    @RequestMapping(value = "/sample/openSampleBoardList.do")
    public ModelAndView openSampleBoardList(Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView("/sample/boardList");

        List<Map<String, Object>> list = sampleService.selectBoardList(commandMap);
        mv.addObject("list", list);

        return mv;
    }
}
