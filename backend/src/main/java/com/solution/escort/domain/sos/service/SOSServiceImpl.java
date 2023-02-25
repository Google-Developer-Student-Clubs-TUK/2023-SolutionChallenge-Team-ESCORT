package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.entity.SOS;
import com.solution.escort.domain.sos.repository.SOSREpository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class SOSServiceImpl implements SOSservice{

    @Autowired
    private SOSREpository sosRepository;

    // 노인 도움 신고 등록 api
    @Override
    public void createSOS(SOSRequestDTO sosRequestDTO) throws Exception{
        if (sosRequestDTO.getProtegeId() == null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        SOS saveSOS = sosRequestDTO.toSOSEntity(sosRequestDTO);
        sosRepository.save(saveSOS);
    }
}
