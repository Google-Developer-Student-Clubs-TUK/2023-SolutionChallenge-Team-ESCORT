package com.solution.escort.domain.PPConnection.service;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.PPConnection.repository.PPconnectionRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;

@Service
@Slf4j
public class PPConnectionServiceImpl implements PPConnectionService{

    @Autowired
    private PPconnectionRepository ppConnectionRepository;

    // 보호자 노인 등록 API 관련 서비스
    @Override
    public void ppConnection(PPConnectionRequestDTO ppConnectionRequestDTO) throws Exception {
        log.info(String.valueOf(ppConnectionRequestDTO));

        if (ppConnectionRequestDTO.getProtegeId() == null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        if (ppConnectionRequestDTO.getProtectorId() == null){
            throw new Exception("유효하지 않은 보호자 아이디 정보입니다.");
        }
        ProtectorProtege savePPConnection = ppConnectionRequestDTO.toPPEntity(ppConnectionRequestDTO);
        ppConnectionRepository.save(savePPConnection);
    }
}
