package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.logging.entity.Logging;
import com.solution.escort.domain.logging.repository.LoggingRepository;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;
import com.solution.escort.domain.sos.entity.SOS;
import com.solution.escort.domain.sos.repository.SOSRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class SOSServiceImpl implements SOSservice{

    @Autowired
    private SOSRepository sosRepository;

    @Autowired
    private LoggingRepository loggingRepository;


    // 배회 노인 신고 등록 서비스
    @Override
    public void createSOS(Protege protege) throws Exception{
        Logging logging = new Logging();
        if (protege == null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        // 이미 신고된 사람인지 확인하는 예외 처리
        if(sosRepository.existsByProtegeId(protege.getId())) {
            throw new EntityExistsException();
        }
        SOS sos = new SOS();
        sos.setProtege(protege);
        sosRepository.save(sos);

        logging.setProtege(protege); // 로깅- 신고 대상(pk가 아니라 이름, fbid로 들어가야할것같음)
        LocalDateTime now = LocalDateTime.now();
        logging.setProtegeName(protege.getName()); // 로깅- 신고 대상 이름
        logging.setProtegeFbId(protege.getFbId()); // 로깅- 신고 대상 파이어베이스 UID
        logging.setReportTime(now); // 로깅- 신고 시간
        loggingRepository.save(logging);

    }

    // 모든 배회노인 리스트 가져오기 서비스
    @Override
    public List<SOSResponseDTO> getSOSAll() throws Exception {
        List<SOS> sosAll = sosRepository.findAll();
        return toSOSResponse(sosAll);
    }

    @Override
    public void deleteSOS(Integer id) throws Exception {
        SOS sos = sosRepository.findByProtegeId(id);
        //SOS deleteSOS = sosRequestDTO.toSOSEntity(sosRequestDTO)
        sosRepository.delete(sos);
        LocalDateTime now = LocalDateTime.now();

        Optional<Logging> updateLogging = Optional.ofNullable(loggingRepository.findByProtegeId(id));
        updateLogging.ifPresent(selectLogging -> {
            selectLogging.setReportCancelTime(now);
            loggingRepository.save(selectLogging);
        });

    }

    public List<SOSResponseDTO> toSOSResponse(List<SOS> sosAll) throws Exception {
        List<SOSResponseDTO> sosResponseDTOList = new ArrayList<>();
        for(SOS sos: sosAll) {
            sosResponseDTOList.add(sos.toSOSResponse(sos));
        }
        return sosResponseDTOList;
    }

}
