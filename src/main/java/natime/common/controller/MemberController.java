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
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Map;

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
        PrintWriter out = res.getWriter();
        if (commandMap.getMap().get("id").equals("")) {
            out.print("<script>alert('아이디를 입력해주세요.');window.location.href='login_page.do'</script>");
            return;
        }

        int flag = memberService.Login(commandMap.getMap(), req);

        if (flag == 1) {
            out.print("<script>alert('가입된 아이디가 아닙니다. 회원가입을 진행해주세요.');window.location.href='login_page.do'</script>");
        } else if (flag == 2) {
            out.print("<script>alert('비밀번호를 잘못 입력하였습니다.');window.location.href='login_page.do'</script>");
        } else if (flag == 3) {
            HttpSession session = req.getSession();
            Map<String, Object> map = (Map<String, Object>) session.getAttribute("member_info");
            out.print("<script>window.location.href='sample/openSampleBoardList.do'</script>");
        }

    }

    @RequestMapping(value = "logout.do")
    public ModelAndView logout(HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/login_page.do");
        HttpSession session = req.getSession();
        session.invalidate();
        return mv;
    }
}
