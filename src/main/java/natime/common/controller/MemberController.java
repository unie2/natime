package natime.common.controller;

import natime.common.common.CommandMap;
import natime.common.service.MemberService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class MemberController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "memberService")
    private MemberService memberService;


    @RequestMapping(value = "/login_page.do")
    public ModelAndView loginPage() throws Exception {
        ModelAndView mv = new ModelAndView("/main/login");
        return mv;
    }

    @RequestMapping(value = "/loginCK.do")
    public void loginCK(CommandMap commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception {
        res.setContentType("text/html; charset=UTF-8");
        if (commandMap.getMap().get("id").equals("")) {
            res.getWriter().print("<script>alert('아이디를 입력해주세요.');window.location.href='login_page.do'</script>");
            return;
        }

        int flag = memberService.Login(commandMap.getMap(), req);

    }
}
