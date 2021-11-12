package natime.common.controller;

import natime.common.common.CommandMap;
import natime.common.service.MemberService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
        } else if(commandMap.getMap().get("pw").equals("")) {
            out.print("<script>alert('비밀번호를 입력해주세요.'); window.location.href='login_page.do'</script>");
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
            out.print("<script>window.location.href='boardList_page.do'</script>");
        }

    }

    @RequestMapping(value = "logout.do")
    public ModelAndView logout(HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/login_page.do");
        HttpSession session = req.getSession();
        session.invalidate();
        return mv;
    }

    @RequestMapping(value = "/registration_page.do")
    public ModelAndView registrationPage() throws Exception {
        ModelAndView mv = new ModelAndView("/main/registration");
        return mv;
    }

    @ResponseBody
    @RequestMapping(value = "/id_CK.do", method = RequestMethod.POST)
    public int idCK(CommandMap commandMap, HttpServletResponse res) throws Exception {
        String id = commandMap.getMap().get("id").toString();
        int result = memberService.idCK(id);
        return result;
    }

    @RequestMapping(value = "/registration.do")
    public void registration(CommandMap commandMap, HttpServletResponse res) throws Exception {
        res.setContentType("text/html; charset=UTF-8");
        PrintWriter out = res.getWriter();
        if (memberService.registration(commandMap.getMap())) {
            out.print("<script>alert('가입이 정상적으로 완료되었습니다.'); window.location.href='login_page.do'</script>");
        } else {
            out.print("<script>alert('오류가 발생했습니다.'); window.location.href='registration_page.do'</script>");
        }
    }

    @RequestMapping(value = "/findInfo_page.do")
    public ModelAndView findIDPage() throws Exception {
        ModelAndView mv = new ModelAndView("/main/findInfo");
        return mv;
    }

    @RequestMapping(value = "/find_id.do")
    public void find_id(CommandMap commandMap, HttpServletResponse res) throws Exception {
        String json = memberService.find_id(commandMap.getMap());
        res.setContentType("text/html; charset=UTF-8");
        PrintWriter out = res.getWriter();
        out.print(json);
        return;
    }

    @RequestMapping(value = "/find_pw.do")
    public void find_pw(CommandMap commandMap, HttpServletResponse res) throws Exception {
        String json = memberService.find_pw(commandMap.getMap());
        res.setContentType("text/html; charset=UTF-8");
        PrintWriter out = res.getWriter();
        out.print(json);
        return;
    }

    @RequestMapping(value = "/myPage.do")
    public ModelAndView myPage(HttpServletRequest req) throws Exception {
        ModelAndView mv = new ModelAndView("/main/myPage");
        HttpSession session = req.getSession();
        Map<String, Object> map = (Map<String, Object>) session.getAttribute("member_info");

        mv.addObject("userInfo", memberService.myPage(map));
        return mv;
    }

    @RequestMapping(value = "/edit_profile.do")
    public ModelAndView edit_profile(CommandMap commandMap) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/boardList_page.do");

        memberService.edit_profile(commandMap.getMap());
        return mv;
    }

    @RequestMapping(value = "/edit_password.do")
    public ModelAndView edit_password(CommandMap commandMap) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/boardList_page.do");

        memberService.edit_password(commandMap.getMap());
        return mv;
    }

}
