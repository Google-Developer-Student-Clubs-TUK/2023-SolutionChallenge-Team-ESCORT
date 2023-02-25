package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;
import com.solution.escort.domain.sos.entity.SOS;
import com.solution.escort.domain.sos.repository.SOSREpository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class SOSServiceImpl implements SOSservice{

    @Autowired
    private SOSREpository sosRepository;

    // 배회 노인 신고 등록 서비스
    @Override
    public void createSOS(SOSRequestDTO sosRequestDTO) throws Exception{
        if (sosRequestDTO.getProtegeId() == null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        SOS saveSOS = sosRequestDTO.toSOSEntity(sosRequestDTO);
        sosRepository.save(saveSOS);
    }

    // 모든 배회노인 리스트 가져오기 서비스
    @Override
    public List<SOSResponseDTO> getSOSAll() throws Exception {
        List<SOS> sosAll = sosRepository.findAll();
        return toSOSResponse(sosAll);
    }

    @Override
    public void deleteSOS(Integer id) throws Exception {
        SOS sos = sosRepository.findById(id).get();
        //SOS deleteSOS = sosRequestDTO.toSOSEntity(sosRequestDTO);
        sosRepository.delete(sos);
    }

    public List<SOSResponseDTO> toSOSResponse(List<SOS> sosAll) throws Exception {
        List<SOSResponseDTO> sosResponseDTOList = new ArrayList<>();
        // 이미 신고된 사람인지 확인하는 예외 처리 필요
        for(SOS sos: sosAll) {
            sosResponseDTOList.add(sos.toSOSResponse(sos));
        }
        return sosResponseDTOList;
    }

}
