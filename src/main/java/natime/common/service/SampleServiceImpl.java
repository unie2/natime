package natime.common.service;

import natime.common.dao.SampleDAO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name = "sampleDAO")
    private SampleDAO sampleDAO;

    @Override
    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
        return sampleDAO.selectBoardList(map);
    }
}
